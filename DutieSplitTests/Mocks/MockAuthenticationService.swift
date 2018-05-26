//
//  MockAuthenticationService.swift
//  DutieSplitTests
//


@testable import DutieSplit

internal class MockAuthenticationService: AuthenticationService {
    
    var storedToken: String?
    
    /// - SeeAlso: AuthenticationService.token
    var token: String? {
        return storedToken
    }
    
    /// - SeeAlso: AuthenticationService.save()
    func save(token: String) {
        storedToken = token
    }
    
    /// - SeeAlso: AuthenticationService.removeToken()
    func removeToken() {
        storedToken = nil
    }
}
