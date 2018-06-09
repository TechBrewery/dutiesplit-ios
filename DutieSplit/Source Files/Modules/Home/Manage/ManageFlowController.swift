//
//  ManageFlowController.swift
//  DutieSplit
//


import UIKit

internal final class ManageFlowController: FlowController {
    typealias Dependencies = HasViewControllerFactory
    internal typealias EventCallback = (Event) -> ()
    
    /// Enum describing events that can be triggered
    ///
    /// - userLoggedOut: Send when user logged out
    internal enum Event {
        case userLoggedOut
    }
    
    var eventTriggered: EventCallback?
    
    private let dependencies: Dependencies
    
    /// Initializes Flow controllers with given dependencies
    ///
    /// - Parameters:
    ///   - dependencies: Dependencies to use in the class
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        rootViewController = UINavigationController(rootViewController: makeManageViewController())
    }
    
    /// Root view controler of the flow
    private(set) var rootViewController = UIViewController()
    
    /// Root view controller casted as navigation controller
    var navigationController: UINavigationController? {
        return rootViewController as? UINavigationController
    }
    
    private func makeManageViewController() -> ManageViewController {
        let viewController = dependencies.viewControllerFactory.manageViewController()
        viewController.viewModel.eventTriggered = { [unowned self] event in
            switch event {
            case .userLoggedOut:
                self.eventTriggered?(.userLoggedOut)
            case .didTapDuties:
                self.navigationController?.pushViewController(self.makeDutiesViewController(), animated: true)
            case .didTapSettings:
                self.navigationController?.pushViewController(self.makeSettingsViewController(), animated: true)
            case .didTapProfile:
                self.navigationController?.pushViewController(self.makeProfileViewController(), animated: true)
            case .didTapSwitchGroup:
                self.navigationController?.pushViewController(self.makeSwitchGroupViewController(), animated: true)
            }
        }
        return viewController
    }
    
    private func makeDutiesViewController() -> UIViewController {
        let viewController = UIViewController()
        viewController.title = "Duties"
        return viewController
    }
    
    private func makeSettingsViewController() -> UIViewController {
        let viewController = UIViewController()
        viewController.title = "Settings"
        return viewController
    }
    
    private func makeProfileViewController() -> UIViewController {
        let viewController = UIViewController()
        viewController.title = "Profile"
        return viewController
    }
    
    private func makeSwitchGroupViewController() -> UIViewController {
        let viewController = UIViewController()
        viewController.title = "Switch group"
        return viewController
    }
}
