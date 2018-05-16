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
    
    func registerViewController() -> RegisterViewController {
        let viewModel = RegisterViewModel(dependencies: applicationDependencies)
        return RegisterViewController(viewModel: viewModel, viewMaker: RegisterView())
    }
    
    func dashboardViewController() -> DashboardViewController {
        let viewModel = DashboardViewModel(dependencies: applicationDependencies)
        return DashboardViewController(viewModel: viewModel, viewMaker: DashboardView())
    }
    
    func manageViewController() -> ManageViewController {
        let viewModel = ManageViewModel(dependencies: applicationDependencies)
        return ManageViewController(viewModel: viewModel, viewMaker: ManageView())
    }
}
