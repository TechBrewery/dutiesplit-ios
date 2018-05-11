//
//  PasswordValidator.swift
//  DutieSplit
//


/// Validates the password
internal struct PasswordValidator {
    
    /// Validates given password
    ///
    /// - Parameter password: Password to validate
    /// - Returns: Result of the validation
    static func validate(_ password: String) -> Bool {
        return password.count >= 1
    }
}
