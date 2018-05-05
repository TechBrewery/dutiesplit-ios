//
//  LoginView.swift
//  DutieSplit
//


import UIKit

internal final class LoginView: View, ViewSetupable {
    
    /// Text Field with the email
    lazy var emailTextField: UITextField = {
        let textField = UITextFieldFactory.loginStyled()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
        )
        textField.keyboardType = .emailAddress
        return textField.layoutable()
    }()
    
    /// Text Field with the password
    lazy var passwordTextField: UITextField = {
        let textField = UITextFieldFactory.loginStyled()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
        )
        textField.isSecureTextEntry = true
        return textField.layoutable()
    }()
    
    /// Button for logging in using email and password
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        return button.layoutable()
    }()
    
    /// Button for signing up
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        return button.layoutable()
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "splash-screen"))
        view.contentMode = .scaleAspectFit
        return view.layoutable()
    }()
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "logo"))
        view.contentMode = .scaleAspectFit
        return view.layoutable()
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
    ).layoutable()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [backgroundImageView, logoImageView, stackView].forEach { addSubview($0) }
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        backgroundImageView.constraintToSuperviewEdges()
        stackView.constraintCenterToSuperview()
        logoImageView.constraintToSuperviewEdges(excludingAnchors: [.bottom], withInsets: .init(top: 20, left: 40, bottom: 0, right: 40))
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            stackView.widthAnchor.constraint(equalToConstant: 260),
            logoImageView.heightAnchor.constraint(equalToConstant: 170)
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
