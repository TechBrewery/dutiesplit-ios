//
//  ApplicationDependencies.swift
//  DutieSplit
//


import ResponseDetective

/// Shared dependencies used extensively in the application
internal protocol ApplicationDependencies: class,
    HasViewControllerFactory,
    HasApplicationKeys,
    HasCrashLogger,
    HasSecureStorageService,
    HasAuthenticationService,
    HasNetworkSession,
    HasNetworkService,
    HasUserController { }

/// - SeeAlso: ApplicationDependencies
internal final class DefaultApplicationDependencies: ApplicationDependencies {
    
    lazy var viewControllerFactory = ViewControllerFactory(applicationDependencies: self)
    
    lazy var applicationKeys: ApplicationKeys = ApplicationKeys(keys: DutieSplitKeys())
    
    lazy var crashLogger: CrashLogger = HockeyAppService(keys: applicationKeys)
    
    lazy var secureStorageService: SecureStorageService = {
        let bundleIdentifier = Bundle.main.infoDictionary!["CFBundleIdentifier"] as? String ?? "co.techbrewery.dutiesplit"
        return DefaultSecureStorageService(serviceIdentifier: "\(bundleIdentifier).keychain")
    }()
    
    lazy var authenticationService: AuthenticationService = DefaultAuthenticationService(secureStorageService: secureStorageService)

    lazy var networkSession: NetworkSession = {
        #if ENV_DEVELOPMENT
            let configuration = URLSessionConfiguration.default
            ResponseDetective.enable(inConfiguration: configuration)
            return DefaultNetworkSession(session: URLSession(configuration: configuration))
        #else
            return DefaultNetworkSession(session: .shared)
        #endif
    }()

    lazy var networkService: NetworkService = DefaultNetworkService(
        authenticationService: authenticationService,
        session: networkSession
    )

    lazy var userController: UserController = DefaultUserController(
        networkService: networkService,
        authenticationService: authenticationService
    )
}
