//
//  LoginView.swift
//  DutieSplit
//


import UIKit

internal final class LoginView: View, ViewSetupable {
    
    /// Text Field with the email
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "email"
        return textField
    }()
    
    /// Text Field with the password
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "email"
        return textField
    }()
    
    /// Button for logging in using email and password
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    /// Button for signing up
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            SeparatorView(axis: .vertical, thickness: 8),
            passwordTextField,
            SeparatorView(axis: .vertical, thickness: 8),
            loginButton,
            signUpButton
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        stackView.constraintCenterToSuperview()
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        backgroundColor = .white
    }
    
    /// - SeeAlso: UIView.touchesBegan()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        endEditing(true)
    }
}
