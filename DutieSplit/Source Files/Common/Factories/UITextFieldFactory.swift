//
//  UITextFieldFactory.swift
//  DutieSplit
//


import UIKit

internal struct UITextFieldFactory {

    /// Creates UITextField with style used on the login screen
    ///
    /// - Returns: Styled view
    static func loginStyled() -> UITextField {
        let view = UITextField()
        view.borderStyle = .none
        view.layer.cornerRadius = 20
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.textColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 14)
        return view
    }
}
