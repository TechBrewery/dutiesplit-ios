//
//  CurrentUserRequest.swift
//  DutieSplit
//


internal struct CurrentUserRequest: NetworkRequest {
    typealias Response = User

    /// - SeeAlso: APIRequest.method
    var method: NetworkMethod {
        return .GET
    }

    /// - SeeAlso: APIRequest.path
    var path: String {
        return "/users/me"
    }

    /// - SeeAlso: APIRequest.requiresAuthorization
    var requiresAuthorization: Bool {
        return true
    }
}
