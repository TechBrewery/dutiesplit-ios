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
            string: Localizable.LoginScreen.placeholderEmail,
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
        )
        textField.keyboardType = .emailAddress
        return textField.layoutable()
    }()
    
    /// Text Field with the password
    lazy var passwordTextField: UITextField = {
        let textField = UITextFieldFactory.loginStyled()
        textField.attributedPlaceholder = NSAttributedString(
            string: Localizable.LoginScreen.placeholderPassword,
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
        )
        textField.isSecureTextEntry = true
        return textField.layoutable()
    }()
    
    /// Button for logging in using email and password
    lazy var loginButton: UIButton = {
        let button = UIButtonFactory.loginStyled()
        button.tintColor = .dsRed
        button.setTitle(Localizable.LoginScreen.logIn, for: .normal)
        return button.layoutable()
    }()
    
    /// Button for signing up
    lazy var registerButton: UIButton = {
        let button = UIButtonFactory.loginStyled()
        button.tintColor = .dsGreen
        button.setTitle(Localizable.LoginScreen.signIn, for: .normal)
        return button.layoutable()
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "splash-screen"))
        view.contentMode = .scaleAspectFill
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
            passwordTextField,
            loginButton
        ],
        spacing: 12
    ).layoutable()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [backgroundImageView, logoImageView, stackView, registerButton].forEach { addSubview($0) }
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        backgroundImageView.constraintToSuperviewEdges()
        stackView.constraintCenterToSuperview()
        logoImageView.constraintToSuperviewEdges(excludingAnchors: [.bottom], withInsets: .init(top: 20, left: 40, bottom: 0, right: 40))
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 170),
            stackView.widthAnchor.constraint(equalToConstant: 260),
            registerButton.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            registerButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            registerButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
