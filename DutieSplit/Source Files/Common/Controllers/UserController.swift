//
//  UserController.swift
//  DutieSplit
//


import RxSwift

internal protocol UserController {

    /// User authentication state
    var authState: Observable<AuthState> { get }

    /// Currently logged in user Variable
    var user: Variable<User?> { get }

    /// Makes login request with given arguments
    func login(email: String, password: String) -> Single<NetworkError?>

    /// Makes register request with given arguments
    func register(name: String, email: String, password: String) -> Single<NetworkError?>

    /// Loggs out currect user
    func logout()
}

internal final class DefaultUserController: UserController {
    
    /// - SeeAlso: UserController.authState
    let authState: Observable<AuthState>

    /// - SeeAlso: UserController.user
    let user = Variable<User?>(nil)

    private let disposeBag = DisposeBag()

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
            .distinctUntilChanged()
            .map(AuthState.init)
            .share(replay: 1, scope: .forever)

        authState
            .filter { $0 != .unauthenticated }
            .map { _ in CurrentUserRequest() }
            .flatMap { [unowned self] in self.networkService.perform(request: $0) }
            .map { response -> User? in
                switch response {
                case .success(let response): return response
                case .failure(_): return nil
                }
            }
            .bind(to: user)
            .disposed(by: disposeBag)

        authState
            .filter { $0 == .unauthenticated }
            .map { _ in nil }
            .bind(to: user)
            .disposed(by: disposeBag)
    }

    /// - SeeAlso: UserController.login(email:password:)
    func login(email: String, password: String) -> Single<NetworkError?> {
        return Single
            .just(LoginRequest(email: email, password: password))
            .flatMap { [unowned self] in self.networkService.perform(request: $0) }
            .flatMap { [unowned self] response in
                switch response {
                    case .success(let response):
                        self.authenticationService.save(token: response.token)
                        return .just(nil)
                    case .failure(let error):
                        return .just(error)
                }
            }
    }

    /// - SeeAlso: UserController.register(name:email:password:)
    func register(name: String, email: String, password: String) -> Single<NetworkError?> {
        return Single
            .just(RegisterRequest(name: name, email: email, password: password))
            .flatMap { [unowned self] in self.networkService.perform(request: $0) }
            .flatMap { [unowned self] response in
                switch response {
                case .success(let response):
                    self.authenticationService.save(token: response.token)
                    return .just(nil)
                case .failure(let error):
                    return .just(error)
                }
            }
    }

    /// - SeeAlso: UserController.logout()
    func logout() {
        authenticationService.removeToken()
    }
}
