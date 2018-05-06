//
//  UIButtonFactory.swift
//  DutieSplit
//


import UIKit

internal struct UIButtonFactory {
    
    /// Creates UIButton with style used on the login screen
    ///
    /// - Returns: Styled view
    static func loginStyled() -> UIButton {
        let view = UIButton(type: .system)
        view.layer.cornerRadius = 20
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.backgroundColor = .white
        view.titleLabel?.textAlignment = .center
        view.titleLabel?.font = .systemFont(ofSize: 14)
        return view
    }
}
