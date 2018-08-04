//
//  AuthState.swift
//  DutieSplit
//


/// Describe available authentication states.
internal enum AuthState: Equatable {
    case authenticated(token: String)
    case unauthenticated

    /// Initiales the object with given token.
    ///
    /// - Parameter token: Token to be used for initialization.
    init(_ token: String?) {
        if let token = token {
            self = .authenticated(token: token)
        } else {
            self = .unauthenticated
        }
    }
}
