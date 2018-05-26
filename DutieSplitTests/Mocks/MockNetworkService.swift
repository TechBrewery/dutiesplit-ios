//
//  MockNetworkService.swift
//  DutieSplitTests
//


@testable import DutieSplit
import RxSwift

internal final class MockNetworkService: NetworkService {
    
    var mockedResponses = [String : NetworkResponseResult<NetworkResponse>]()
    
    private let authenticationService: AuthenticationService
    
    private let acceptableStatusCodes = 200 ..< 300
    
    private let authorizationErrorStatusCode = 401
    
    private var onUnauthorizedError: () -> () = { }
    
    /// Initialize network service with given session (leave empty for shared session)
    ///
    /// - Parameter session: Session to be used for requests
    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
    }
    
    /// - SeeAlso: NetworkService.setUnauthorizedErrorCallback()
    func setUnauthorizedErrorCallback(_ callback: @escaping () -> ()) {
        onUnauthorizedError = callback
    }
    
    /// Performs network request and returns Single of its reponse
    ///
    /// - Parameter request: Request to be performed
    /// - Returns: Observable of type Request.Response
    func perform<Request>(request: Request) -> Observable<NetworkResponseResult<Request.Response>> where Request: NetworkRequest {
        return Observable<NetworkResponseResult<Request.Response>>.create { [unowned self] observer in
            guard let mock = self.mockedResponses[request.path] else {
                fatalError("No stub provided for request: \(request.method) \(request.path)")
            }
            observer.onNext(mock as! NetworkResponseResult<Request.Response>)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
