//
//  ApplicationDependency.swift
//  DutieSplit
//


import ResponseDetective

/// Shared dependencies used extensively in the application
internal protocol ApplicationDependencies: HasViewControllerFactory, HasApplicationKeys, HasCrashLogger, HasSecureStorageService, HasAuthenticationService, HasNetworkService { }

/// - SeeAlso: ApplicationDependencies
internal class DefaultApplicationDependencies: ApplicationDependencies {
    
    lazy var viewControllerFactory = ViewControllerFactory(applicationDependencies: self)
    
    lazy var applicationKeys: ApplicationKeys = ApplicationKeys(keys: DutieSplitKeys())
    
    lazy var crashLogger: CrashLogger = HockeyAppService(keys: applicationKeys)
    
    lazy var secureStorageService: SecureStorageService = {
        let bundleIdentifier = Bundle.main.infoDictionary!["CFBundleIdentifier"] as? String ?? "co.techbrewery.dutiesplit"
        return DefaultSecureStorageService(serviceIdentifier: "\(bundleIdentifier).keychain")
    }()
    
    lazy var authenticationService: AuthenticationService = DefaultAuthenticationService(secureStorageService: secureStorageService)
    
    lazy var networkService: NetworkService = {
        #if ENV_DEVELOPMENT
            let configuration = URLSessionConfiguration.default
            ResponseDetective.enable(inConfiguration: configuration)
        return DefaultNetworkService(authenticationService: authenticationService, session: URLSession(configuration: configuration))
        #else
            return DefaultNetworkService(authenticationService: authenticationService)
        #endif
    }()
}
