//
//  AuthenticationService.swift
//  DutieSplit
//


import Foundation

/// Authentiator service for stroring and providing access token
internal protocol AuthenticationService {
    
    /// Token for requests authorization
    var token: String? { get }
    
    /// Saves the token to the secure storage
    ///
    /// - Parameter token: Token to save
    func save(token: String)
    
    /// Removes saved token
    func removeToken()
}

internal class DefaultAuthenticationService: AuthenticationService {
    
    private let secureStorageService: SecureStorageService
    
    /// Initializes the instance
    ///
    /// - Parameter secureStorageService: Secure storage service to use
    init(secureStorageService: SecureStorageService) {
        self.secureStorageService = secureStorageService
    }
    
    /// - SeeAlso: AuthenticationService.token
    var token: String? {
        return secureStorageService.retrieveToken()
    }
    
    /// - SeeAlso: AuthenticationService.save()
    func save(token: String) {
        secureStorageService.save(token: token)
    }
    
    /// - SeeAlso: AuthenticationService.removeToken()
    func removeToken() {
        secureStorageService.removeToken()
    }
}
