//
//  NetworkService.swift
//  DutieSplit
//


import Foundation
import RxSwift

/// Service for performing network requests
internal protocol NetworkService {
    
    /// Performs network request and returns Single of its reponse
    ///
    /// - Parameter request: Request to be performed
    /// - Returns: Single of type Request.Response
    func perform<Request>(request: Request) -> Single<NetworkResponseResult<Request.Response>> where Request: NetworkRequest
    
    /// Parses response from the server
    ///
    /// - Parameters:
    ///   - dataTaskResponse: Response received from the URLSessionDataTask
    ///   - request: Request used to retrieve the data
    /// - Returns: Single with parsed data
    func parse<Request>(dataTaskResponse: URLSessionDataTaskResponse, for request: Request) -> Single<NetworkResponseResult<Request.Response>> where Request: NetworkRequest
}

/// Default network application for performing API requests
internal final class DefaultNetworkService: NetworkService {
    
    private let authenticationService: AuthenticationService
    
    private let networkSession: NetworkSession
    
    private let acceptableStatusCodes = 200 ..< 300
    
    private let authorizationErrorStatusCode = 401
    
    /// Initialize network service with given session (leave empty for shared session)
    ///
    /// - Parameter session: Session to be used for requests
    init(authenticationService: AuthenticationService, session: NetworkSession) {
        self.authenticationService = authenticationService
        self.networkSession = session
    }
    
    /// - SeeAlso: NetworkService.perform(request:)
    func perform<Request>(request: Request) -> Single<NetworkResponseResult<Request.Response>> where Request: NetworkRequest {
        return Single
            .just(authenticationService.token.value)
            .flatMap { [unowned self] in self.networkSession.send(request: URLRequest(request: request, token: $0)) }
            .flatMap { [unowned self] in self.parse(dataTaskResponse: $0, for: request) }
    }
    
    /// - SeeAlso: NetworkService.parse(dataTaskResponse:for:)
    func parse<Request>(dataTaskResponse: URLSessionDataTaskResponse, for request: Request) -> Single<NetworkResponseResult<Request.Response>> where Request: NetworkRequest {
        // If error occurred, resolve failure immediately
        if let error = dataTaskResponse.error {
            return .just(.failure(NetworkError.connectionError(error)))
        }
        
        // If the response is invalid, resolve failure immediately
        guard let response = dataTaskResponse.response else {
            return .just(.failure(.missingResponse))
        }
        
        // If data is missing, resolve failure immediately
        guard let data = dataTaskResponse.data else {
            return .just(.failure(.missingData))
        }
        
        // Initialize decoder with proper decoding strategy
        let decoder = JSONDecoder()
        
        // Validate against acceptable status codes
        guard acceptableStatusCodes ~= response.statusCode else {
            // Call unauthorized callback in case of unauthorized status code
            guard response.statusCode != authorizationErrorStatusCode || request is LoginRequest else {
                authenticationService.removeToken()
                return .just(.failure(.unauthorized))
            }
            
            // Try to parse status from response, otherwise resolve failure only with status code
            guard let parsedErrorStatusResponse = try? decoder.decode(NetworkStatusResponse.self, from: data) else {
                return .just(.failure(.unacceptableStatusCode(response.statusCode)))
            }
            return .just(.failure(.errorStatus(parsedErrorStatusResponse.status)))
        }
        
        // Parse a response
        do {
            let parsedResponse = try decoder.decode(Request.Response.self, from: data)
            
            // Resolve success with a parsed response
            return .just(.success(parsedResponse))
        } catch let error {
            #if ENV_DEVELOPMENT
                // Prints which value failed decoding - only for development
                print("Decodable error: \(error)")
            #endif
            return .just(.failure(.responseParseError(error)))
        }
    }
}
