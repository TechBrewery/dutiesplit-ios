//
//  ViewControllerFactory.swift
//  DutieSplit
//


/// Factory class that creates view controllers with its view and view model
internal struct ViewControllerFactory {
    
    private let applicationDependencies: ApplicationDependencies
    
    init(applicationDependencies: ApplicationDependencies) {
        self.applicationDependencies = applicationDependencies
    }
 
    func loginViewController() -> LoginViewController {
        let viewModel = LoginViewModel(dependencies: applicationDependencies)
        return LoginViewController(viewModel: viewModel, viewMaker: LoginView())
    }
}
