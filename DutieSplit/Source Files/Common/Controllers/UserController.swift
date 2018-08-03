//
//  UserController.swift
//  DutieSplit
//


import RxSwift

internal protocol UserController {

    /// User authentication state
    var authState: Observable<AuthState> { get }

    /// Makes login request with given arguments
    func login(email: String, password: String) -> Observable<NetworkError?>

    /// Makes register request with given arguments
    func register(name: String, email: String, password: String) -> Observable<NetworkError?>

    /// Loggs out currect user
    func logout()
}

internal final class DefaultUserController: UserController {
    
    /// - SeeAlso: UserController.authState
    let authState: Observable<AuthState>

    private let networkService: NetworkService

    private let authenticationService: AuthenticationService

    /// Initialize object with needed dependencies
    ///
    /// - Parameters:
    ///   - networkService: Service for making  network requests
    ///   - authenticationService: Service for authentication tasks
    init(networkService:NetworkService, authenticationService: AuthenticationService) {
        self.networkService = networkService
        self.authenticationService = authenticationService

        authState = authenticationService
            .token
            .asObservable()
            .map(AuthState.init)
            .share(replay: 1, scope: .forever)
    }

    /// - SeeAlso: UserController.login(email:password:)
    func login(email: String, password: String) -> Observable<NetworkError?> {
        return networkService
            .perform(request: LoginRequest(email: email, password: password))
            .map { [unowned self] response in
                switch response {
                    case .success(let response):
                        self.authenticationService.save(token: response.token)
                        return nil
                    case .failure(let error):
                        return error
                }
            }
    }

    /// - SeeAlso: UserController.register(name:email:password:)
    func register(name: String, email: String, password: String) -> Observable<NetworkError?> {
        return networkService
            .perform(request: RegisterRequest(name: name, email: email, password: password))
            .map { [unowned self] response in
                switch response {
                case .success(let response):
                    self.authenticationService.save(token: response.token)
                    return nil
                case .failure(let error):
                    return error
                }
            }
    }

    /// - SeeAlso: UserController.logout()
    func logout() {
        authenticationService.removeToken()
    }
}
