//
//  ViewControllerFactory.swift
//  DutieSplit
//


/// Factory class that creates view controllers with its view and view model
internal struct ViewControllerFactory {
 
    func loginViewController() -> LoginViewController {
        let viewModel = LoginViewModel()
        return LoginViewController(viewModel: viewModel, viewMaker: LoginView())
    }
}
