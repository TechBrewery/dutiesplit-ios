//
//  LoginViewController.swift
//  DutieSplit
//


import UIKit

internal final class LoginViewController: ViewController<LoginView, LoginViewModel>, BindingsSetupable, NavigationBarSetupable {
    
    /// - SeeAlso: NavigationBarSetupable
    func setup(navigationBar: UINavigationBar) {
        navigationBar.barStyle = .blackTranslucent
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
        
        customView.loginButton.rx.tap
            .bind(to: viewModel.loginButtonTap)
            .disposed(by: disposeBag)
        
        customView.registerButton.rx.tap
            .bind(to: viewModel.registerButtonTap)
            .disposed(by: disposeBag)
        
        viewModel.loginButtonEnabled.asDriver(onErrorJustReturn: false)
            .drive(customView.loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
