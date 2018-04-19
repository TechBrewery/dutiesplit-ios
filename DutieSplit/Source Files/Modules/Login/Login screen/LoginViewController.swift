//
//  LoginViewController.swift
//  DutieSplit
//


import UIKit

internal final class LoginViewController: ViewController<LoginView, LoginViewModel>, BindingsSetupable {

    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        print("LoginViewController setup called")
    }
}
