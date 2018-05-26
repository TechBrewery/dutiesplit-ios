//
//  MockSecureStorageService.swift
//  DutieSplitTests
//


@testable import DutieSplit

internal final class MockSecureStorageService: SecureStorageService {
    
    var savedToken: String?
    
    /// - SeeAlso: SecureStorageService.save()
    func save(token: String) {
        savedToken = token
    }
    
    /// - SeeAlso: SecureStorageService.removeToken()
    func removeToken() {
        savedToken = nil
    }
    
    /// - SeeAlso: SecureStorageService.retrieveToken()
    func retrieveToken() -> String? {
        return savedToken
    }
}
