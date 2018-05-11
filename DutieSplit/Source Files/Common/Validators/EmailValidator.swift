//
//  EmailValidator.swift
//  DutieSplit
//


/// Validates the email
internal struct EmailValidator {
    private static let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    /// Validates given input
    ///
    /// - Parameter input: Input to validate
    /// - Returns: Result of the validation
    static func validate(_ input: String) -> Bool {
        return input.range(of: pattern, options: [.regularExpression, .caseInsensitive]) != nil
    }
}
