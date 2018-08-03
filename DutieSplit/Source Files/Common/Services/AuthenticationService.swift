//
//  AuthenticationService.swift
//  DutieSplit
//


import RxSwift

/// Authentiator service for stroring and providing access token
internal protocol AuthenticationService {

    /// Token for requests authorization
    var token: Variable<String?> { get }
    
    /// Saves the token to the secure storage
    ///
    /// - Parameter token: Token to save
    func save(token: String)
    
    /// Removes saved token
    func removeToken()
}

internal class DefaultAuthenticationService: AuthenticationService {

    /// - SeeAlso: AuthenticationService.token
    let token: Variable<String?>
    
    private let secureStorageService: SecureStorageService
    
    /// Initializes the instance
    ///
    /// - Parameter secureStorageService: Secure storage service to use
    init(secureStorageService: SecureStorageService) {
        self.secureStorageService = secureStorageService
        token = .init(secureStorageService.retrieveToken())
    }

    
    /// - SeeAlso: AuthenticationService.save()
    func save(token: String) {
        secureStorageService.save(token: token)
        self.token.value = token
    }
    
    /// - SeeAlso: AuthenticationService.removeToken()
    func removeToken() {
        secureStorageService.removeToken()
        token.value = nil
    }
}
