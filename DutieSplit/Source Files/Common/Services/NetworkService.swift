//
//  NetworkService.swift
//  DutieSplit
//


import Foundation
import RxSwift

/// Service for performing network requests
internal protocol NetworkService {
    
    /// URL Session to use for performing requests
    var session: URLSession { get }
    
    /// Authenticator service for requests authorization
    var authenticationService: AuthenticationService { get }
    
    /// Method for registering callback when 401 error occurred
    ///
    /// - Parameter callback: Callback to call when 401 unauthorized error occurred
    func setUnauthorizedErrorCallback(_ callback: @escaping () -> ())
    
    /// Performs network request and returns Observable of its reponse
    ///
    /// - Parameter request: Request to be performed
    /// - Returns: Observable of type Request.Response
    func perform<Request>(request: Request) -> Single<Request.Response> where Request: NetworkRequest
}

/// Default network application for performing API requests
internal final class DefaultNetworkService: NetworkService {
    
    /// URL Session to use for performing requests
    let session: URLSession
    
    /// Authenticator service for requests authorization
    let authenticationService: AuthenticationService
    
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
    
    /// Performs network request and returns Single of its reponse
    ///
    /// - Parameter request: Request to be performed
    /// - Returns: Observable of type Request.Response
    func perform<Request>(request: Request) -> Single<Request.Response> where Request: NetworkRequest {
        return Single<Request.Response>.create { [unowned self] single in
            let urlRequest = URLRequest(request: request, authenticationService: self.authenticationService)
            let task = self.session.dataTask(with: urlRequest) { [weak self] data, response, error in
                guard let `self` = self else { return }
                
                // If error occurred, resolve failure immediately
                if let error = error {
                    single(.error(NetworkError.connectionError(error)))
                }
                
                // If the response is invalid, resolve failure immediately
                guard let response = response as? HTTPURLResponse else {
                    single(.error(NetworkError.missingResponse))
                    return
                }
                
                // If data is missing, resolve failure immediately
                guard let data = data else {
                    single(.error(NetworkError.missingData))
                    return
                }
                
                // Initialize decoder with proper decoding strategy
                let decoder = JSONDecoder()
                
                // Validate against acceptable status codes
                guard self.acceptableStatusCodes ~= response.statusCode else {
                    // Call unauthorized callback in case of unauthorized status code
                    guard response.statusCode != self.authorizationErrorStatusCode else {
                        self.authenticationService.removeToken()
                        single(.error(NetworkError.unauthorized))
                        self.onUnauthorizedError()
                        return
                    }
                    single(.error(NetworkError.unacceptableStatusCode(response.statusCode)))
                    return
                }
                
                // Parse a response
                do {
                    let parsedResponse = try decoder.decode(Request.Response.self, from: data)
                    
                    // Resolve success with a parsed response
                    single(.success(parsedResponse))
                } catch let error {
                    #if ENV_DEVELOPMENT
                        // Prints which value failed decoding - only for development
                        print("Decodable error: \(error)")
                    #endif
                    single(.error(NetworkError.responseParseError(error)))
                }
            }
            task.resume()
            return Disposables.create() {
                task.cancel()
            }
        }
    }
}
