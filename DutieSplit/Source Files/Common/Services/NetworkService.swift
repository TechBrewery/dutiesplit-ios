//
//  NetworkService.swift
//  DutieSplit
//


import Foundation
import RxSwift

/// Service for performing network requests
internal protocol NetworkService {
    
    /// Method for registering callback when 401 error occurred
    ///
    /// - Parameter callback: Callback to call when 401 unauthorized error occurred
    func setUnauthorizedErrorCallback(_ callback: @escaping () -> ())
    
    /// Performs network request and returns Observable of its reponse
    ///
    /// - Parameter request: Request to be performed
    /// - Returns: Observable of type Request.Response
    func perform<Request>(request: Request) -> Observable<NetworkResponseResult<Request.Response>> where Request: NetworkRequest
    
    /// Handles response from the server
    ///
    /// - Parameters:
    ///   - dataTaskResponse: Response received from the URLSessionDataTask
    ///   - request: Request used to retrieve the data
    ///   - observer: Observer for parsed response
    func handle<Request>(dataTaskResponse: URLSessionDataTaskResponse, for request: Request, observer: AnyObserver<NetworkResponseResult<Request.Response>>) where Request: NetworkRequest
}

/// Default network application for performing API requests
internal class DefaultNetworkService: NetworkService {
    
    private let authenticationService: AuthenticationService
    
    private let session: URLSession
    
    private let acceptableStatusCodes = 200 ..< 300
    
    private let authorizationErrorStatusCode = 401
    
    private var onUnauthorizedError: () -> () = { }
    
    /// Initialize network service with given session (leave empty for shared session)
    ///
    /// - Parameter session: Session to be used for requests
    init(authenticationService: AuthenticationService, session: URLSession = .shared) {
        self.authenticationService = authenticationService
        self.session = session
    }
    
    /// - SeeAlso: NetworkService.setUnauthorizedErrorCallback()
    func setUnauthorizedErrorCallback(_ callback: @escaping () -> ()) {
        onUnauthorizedError = callback
    }
    
    /// - SeeAlso: NetworkService.perform(request:)
    func perform<Request>(request: Request) -> Observable<NetworkResponseResult<Request.Response>> where Request: NetworkRequest {
        return Observable<NetworkResponseResult<Request.Response>>.create { [unowned self] observer in
            let urlRequest = URLRequest(request: request, authenticationService: self.authenticationService)
            let task = self.session.dataTask(with: urlRequest) { [weak self] data, response, error in
                var wrappedResponse: URLResponseWrapper?
                if let response = response as? HTTPURLResponse {
                    wrappedResponse = URLResponseWrapper(statusCode: response.statusCode)
                }
                let response = URLSessionDataTaskResponse(data: data, response: wrappedResponse, error: error)
                self?.handle(dataTaskResponse: response, for: request, observer: observer)
            }
            task.resume()
            return Disposables.create() {
                task.cancel()
            }
        }
    }
    
    /// - SeeAlso: NetworkService.handle(dataTaskResponse:for:observer:)
    func handle<Request>(dataTaskResponse: URLSessionDataTaskResponse, for request: Request, observer: AnyObserver<NetworkResponseResult<Request.Response>>) where Request: NetworkRequest {
        // If error occurred, resolve failure immediately
        if let error = dataTaskResponse.error {
            observer.onNext(.failure(.connectionError(error)))
            observer.onCompleted()
        }
        
        // If the response is invalid, resolve failure immediately
        guard let response = dataTaskResponse.response else {
            observer.onNext(.failure(.missingResponse))
            observer.onCompleted()
            return
        }
        
        // If data is missing, resolve failure immediately
        guard let data = dataTaskResponse.data else {
            observer.onNext(.failure(.missingData))
            observer.onCompleted()
            return
        }
        
        // Initialize decoder with proper decoding strategy
        let decoder = JSONDecoder()
        
        // Validate against acceptable status codes
        guard acceptableStatusCodes ~= response.statusCode else {
            // Call unauthorized callback in case of unauthorized status code
            guard response.statusCode != authorizationErrorStatusCode || request is LoginRequest else {
                authenticationService.removeToken()
                observer.onNext(.failure(.unauthorized))
                observer.onCompleted()
                onUnauthorizedError()
                return
            }
            
            // Try to parse status from response, otherwise resolve failure only with status code
            guard let parsedErrorStatusResponse = try? decoder.decode(NetworkStatusResponse.self, from: data) else {
                observer.onNext(.failure(.unacceptableStatusCode(response.statusCode)))
                observer.onCompleted()
                return
            }
            observer.onNext(.failure(.errorStatus(parsedErrorStatusResponse.status)))
            observer.onCompleted()
            return
        }
        
        // Parse a response
        do {
            let parsedResponse = try decoder.decode(Request.Response.self, from: data)
            
            // Resolve success with a parsed response
            observer.onNext(.success(parsedResponse))
            observer.onCompleted()
        } catch let error {
            #if ENV_DEVELOPMENT
                // Prints which value failed decoding - only for development
                print("Decodable error: \(error)")
            #endif
            observer.onNext(.failure(.responseParseError(error)))
            observer.onCompleted()
        }
    }
}
