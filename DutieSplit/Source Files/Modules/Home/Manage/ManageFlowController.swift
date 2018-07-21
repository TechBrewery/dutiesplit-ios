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
            case .didTapDuties:
                self.navigationController?.pushViewController(self.makeGroupDutiesViewController(), animated: true)
            case .didTapGroupSettings:
                self.navigationController?.pushViewController(self.makeGroupSettingsViewController(), animated: true)
            case .didTapProfile:
                self.navigationController?.pushViewController(self.makeProfileViewController(), animated: true)
            case .didTapSwitchGroup:
                self.navigationController?.pushViewController(self.makeSwitchGroupViewController(), animated: true)
            case .didTapLogout:
                self.eventTriggered?(.userLoggedOut)
            }
        }
        return viewController
    }
    
    private func makeGroupDutiesViewController() -> GroupDutiesViewController {
        let viewController = dependencies.viewControllerFactory.groupDutiesViewController()
        viewController.hidesBottomBarWhenPushed = true
        return viewController
    }
    
    private func makeGroupSettingsViewController() -> GroupSettingsViewController {
        let viewController = dependencies.viewControllerFactory.groupSettingsViewController()
        viewController.hidesBottomBarWhenPushed = true
        return viewController
    }
    
    private func makeProfileViewController() -> ProfileViewController {
        let viewController = dependencies.viewControllerFactory.profileViewController()
        viewController.hidesBottomBarWhenPushed = true
        return viewController
    }
    
    private func makeSwitchGroupViewController() -> SwitchGroupViewController {
        let viewController = dependencies.viewControllerFactory.switchGroupViewController()
        viewController.hidesBottomBarWhenPushed = true
        viewController.viewModel.eventTriggered = { [unowned self] event in
            switch event {
            case .didSelectGroup:
                self.navigationController?.popViewController(animated: true)
            }
        }
        return viewController
    }
}
