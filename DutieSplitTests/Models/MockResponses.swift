//
//  MockResponses.swift
//  DutieSplitTests
//


@testable import DutieSplit

class MockResponses {
    
    private(set) var loginResponse: NetworkResponseResult<LoginResponse>!
    
    init() {
        setSuccessLoginResponse()
    }
    
    func setSuccessLoginResponse() {
        loginResponse = .success(LoginResponse(name: "fixture_name", email: "fixture@email.com", token: "fixture_token"))
    }
    
    func setFailureLoginResponse() {
        loginResponse = .failure(.errorStatus(NetworkStatus(message: "fixture.error")))
    }
}
