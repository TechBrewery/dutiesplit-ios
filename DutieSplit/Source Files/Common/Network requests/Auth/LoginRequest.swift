//
//  LoginRequest.swift
//  DutieSplit
//


internal struct LoginRequest: NetworkRequest {
    typealias Response = LoginResponse
    
    /// Body content
    let email: String
    let password: String
    
    /// - SeeAlso: Swift.CodingKey
    private enum CodingKeys: String, CodingKey {
        case email
        case password
    }
    
    /// - SeeAlso: Swift.Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
    }
    
    /// - SeeAlso: APIRequest.method
    var method: NetworkMethod {
        return .POST
    }
    
    /// - SeeAlso: APIRequest.path
    var path: String {
        return "/auth/login"
    }
    
    /// - SeeAlso: APIRequest.requiresAuthorization
    var requiresAuthorization: Bool {
        return false
    }
}

internal struct LoginResponse: NetworkResponse {
    let name: String
    let email: String
    let token: String
}
