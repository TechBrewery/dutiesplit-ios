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
    
    lazy var authenticationService: AuthenticationService = MockAuthenticationService()
    
    lazy var networkService: NetworkService = MockNetworkService(authenticationService: authenticationService)
}
