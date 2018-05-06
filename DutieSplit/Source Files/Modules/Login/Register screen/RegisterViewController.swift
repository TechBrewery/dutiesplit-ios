//
//  RegisterViewController.swift
//  DutieSplit
//


import UIKit

internal final class RegisterViewController: ViewController<RegisterView, RegisterViewModel>, BindingsSetupable, NavigationBarSetupable {
    
    /// - SeeAlso: NavigationBarSetupable
    func setup(navigationBar: UINavigationBar) {
        navigationBar.barStyle = .blackTranslucent
        navigationBar.tintColor = .white
        navigationBar.setTransparent()
    }
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        customView.emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.emailText)
            .disposed(by: disposeBag)
        
        customView.passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.passwordText)
            .disposed(by: disposeBag)
        
        customView.registerButton.rx.tap
            .bind(to: viewModel.registerButtonTap)
            .disposed(by: disposeBag)
    }
}

