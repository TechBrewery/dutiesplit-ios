//
//  ViewControllerFactory.swift
//  DutieSplit
//


internal struct ViewControllerFactory {
 
    func makeLoginViewController() -> LoginViewController {
        let viewModel = LoginViewModel()
        return LoginViewController(viewModel: viewModel, viewMaker: LoginView())
    }
}
