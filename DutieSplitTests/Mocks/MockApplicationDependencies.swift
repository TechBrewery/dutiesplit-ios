//
//  MockApplicationDependencies.swift
//  DutieSplitTests
//


@testable import DutieSplit

/// - SeeAlso: ApplicationDependencies
internal class MockApplicationDependencies: ApplicationDependencies {
    
    lazy var viewControllerFactory = ViewControllerFactory(applicationDependencies: self)
    
    lazy var applicationKeys: ApplicationKeys = ApplicationKeys(keys: DutieSplitKeys())
    
    lazy var crashLogger: CrashLogger = MockCrashLogger()
    
    lazy var secureStorageService: SecureStorageService = MockSecureStorageService()
    
    lazy var authenticationService: AuthenticationService = DefaultAuthenticationService(secureStorageService: secureStorageService)

    lazy var networkSession: NetworkSession = MockNetworSession()

    lazy var networkService: NetworkService = DefaultNetworkService(
        authenticationService: authenticationService,
        session: networkSession
    )

    lazy var userController: UserController = DefaultUserController(networkService: networkService, authenticationService: authenticationService)
}
