//
//  RegisterView.swift
//  DutieSplit
//


import UIKit

internal final class RegisterView: View, ViewSetupable {
    
    /// Text Field with the name
    lazy var nameTextField: UITextField = {
        let textField = UITextFieldFactory.loginStyled()
        textField.attributedPlaceholder = NSAttributedString(
            string: Localizable.LoginScreen.placeholderName,
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
        )
        return textField.layoutable()
    }()
    
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
    
    private lazy var stackView = UIStackView.make(
        axis: .vertical,
        with: [
            nameTextField,
            emailTextField,
            passwordTextField,
            registerButton
        ],
        spacing: 12
        ).layoutable()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [backgroundImageView, stackView].forEach { addSubview($0) }
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        backgroundImageView.constraintToSuperviewEdges()
        stackView.constraintCenterToSuperview()
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: 260),
        ])
    }
}
