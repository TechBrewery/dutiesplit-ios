//
//  SecureStorageService.swift
//  DutieSplit
//

import KeychainAccess

/// Service for securely storing sensitive data
internal protocol SecureStorageService {
    
    /// Saves the token to the secure storage
    ///
    /// - Parameter token: Token to save
    func save(token: String)
    
    /// Removes saved token
    func removeToken()
    
    /// Retrieves token from the secure storage
    ///
    /// - Returns: Retrieved token
    func retrieveToken() -> String?
}

internal final class DefaultSecureStorageService: SecureStorageService {
    
    private let keychain: Keychain
    
    private let token_key = "token"
    
    /// Initializes the instance
    ///
    /// - Parameter serviceIdentifier: Service indentifier to user for keychain
    init(serviceIdentifier: String) {
        self.keychain = Keychain(service: serviceIdentifier)
    }
    
    /// - SeeAlso: SecureStorageService.save()
    func save(token: String) {
        keychain[token_key] = token
    }
    
    /// - SeeAlso: SecureStorageService.removeToken()
    func removeToken() {
        keychain[token_key] = nil
    }
    
    /// - SeeAlso: SecureStorageService.retrieveToken()
    func retrieveToken() -> String? {
        return keychain[token_key]
    }
}
