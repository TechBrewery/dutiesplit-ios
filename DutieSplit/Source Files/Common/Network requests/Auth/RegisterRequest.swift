//
//  RegisterRequest.swift
//  DutieSplit
//


internal struct RegisterRequest: NetworkRequest {
    typealias Response = RegisterResponse
    
    /// Body content
    let name: String
    let email: String
    let password: String
    
    /// - SeeAlso: Swift.CodingKey
    private enum CodingKeys: String, CodingKey {
        case name
        case email
        case password
    }
    
    /// - SeeAlso: Swift.Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
    }
    
    /// - SeeAlso: APIRequest.method
    var method: NetworkMethod {
        return .POST
    }
    
    /// - SeeAlso: APIRequest.path
    var path: String {
        return "/auth/register"
    }
    
    /// - SeeAlso: APIRequest.requiresAuthorization
    var requiresAuthorization: Bool {
        return false
    }
}

internal struct RegisterResponse: NetworkResponse {
    let name: String
    let email: String
    let token: String
}
