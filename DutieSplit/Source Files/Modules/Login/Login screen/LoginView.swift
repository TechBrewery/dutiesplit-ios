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
        textField.placeholder = "password"
        return textField
    }()
    
    /// Button for logging in using email and password
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    /// Button for signing up
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        return button
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "splash-screen"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var stackView = UIStackView.make(
        axis: .vertical,
        with: [
            emailTextField,
            .separator(axis: .vertical, thickness: 8),
            passwordTextField,
            .separator(axis: .vertical, thickness: 8),
            loginButton,
            registerButton
        ]
    )
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [backgroundImageView, stackView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        [backgroundImageView, stackView].forEach { addSubview($0) }
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        backgroundImageView.constraintToSuperviewEdges()
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
