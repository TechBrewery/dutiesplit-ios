//
//  ViewControllerFactory.swift
//  DutieSplit
//


import UIKit

/// Factory class that creates view controllers with its view and view model
internal class ViewControllerFactory {
    
    private unowned let applicationDependencies: ApplicationDependencies
    
    init(applicationDependencies: ApplicationDependencies) {
        self.applicationDependencies = applicationDependencies
    }
    
    func homeTabBarController(dashboardFlowController: FlowController, manageFlowController: FlowController) -> HomeTabBarController {
        let tabBarController = HomeTabBarController()
        
        let dashboardViewController = dashboardFlowController.rootViewController
        dashboardViewController.tabBarItem = UITabBarItem(title: Localizable.DashboardScreen.title, image: #imageLiteral(resourceName: "dashboard-icon"), tag: 0)
        
        let manageViewController = manageFlowController.rootViewController
        manageViewController.tabBarItem = UITabBarItem(title: Localizable.ManageScreen.title, image: #imageLiteral(resourceName: "manage-icon"), tag: 2)
        
        tabBarController.viewControllers = [dashboardViewController, UIViewController(), manageViewController]
        return tabBarController
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
    
    func addActivityViewController() -> AddActivityViewController {
        let viewModel = AddActivityViewModel(dependencies: applicationDependencies)
        return AddActivityViewController(viewModel: viewModel, viewMaker: AddActivityView())
    }
    
    func groupDutiesViewController() -> GroupDutiesViewController {
        let viewModel = GroupDutiesViewModel(dependencies: applicationDependencies)
        return GroupDutiesViewController(viewModel: viewModel, viewMaker: GroupDutiesView())
    }
    
    func groupSettingsViewController() -> GroupSettingsViewController {
        let viewModel = GroupSettingsViewModel(dependencies: applicationDependencies)
        return GroupSettingsViewController(viewModel: viewModel, viewMaker: GroupSettingsView())
    }
    
    func profileViewController() -> ProfileViewController {
        let viewModel = ProfileViewModel(dependencies: applicationDependencies)
        return ProfileViewController(viewModel: viewModel, viewMaker: ProfileView())
    }
    
    func switchGroupViewController() -> SwitchGroupViewController {
        let viewModel = SwitchGroupViewModel(dependencies: applicationDependencies)
        return SwitchGroupViewController(viewModel: viewModel, viewMaker: SwitchGroupView())
    }
}
