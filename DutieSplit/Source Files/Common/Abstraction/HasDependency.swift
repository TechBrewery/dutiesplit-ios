//
//  HasDependency.swift
//  DutieSplit
//

internal protocol HasViewControllerFactory {
    var viewControllerFactory: ViewControllerFactory { get }
}

internal protocol HasApplicationKeys {
    var applicationKeys: ApplicationKeys { get }
}

internal protocol HasCrashLogger {
    var crashLogger: CrashLogger { get }
}

internal protocol HasAuthenticationService {
    var authenticationService: AuthenticationService { get }
}

internal protocol HasSecureStorageService {
    var secureStorageService: SecureStorageService { get }
}

internal protocol HasNetworkSession {
    var networkSession: NetworkSession { get }
}

internal protocol HasNetworkService {
    var networkService: NetworkService { get }
}

internal protocol HasUserController {
    var userController: UserController { get }
}
