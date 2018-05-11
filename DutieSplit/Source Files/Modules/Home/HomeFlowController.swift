//
//  HomeFlowController.swift
//  DutieSplit
//


import UIKit

internal final class HomeFlowController: FlowController {
    typealias Dependencies = HasViewControllerFactory
    
    /// Enum describing events that can be triggered
    ///
    /// - userLoggedOut: Send when user logged out
    internal enum Event {
        case userLoggedOut
    }
    
    /// Convenience typealias for event callback
    internal typealias EventCallback = (Event) -> ()
    
    private let dependencies: Dependencies
    
    private let eventTriggered: EventCallback?
    
    /// Initializes Flow controllers with given dependencies
    ///
    /// - Parameters:
    ///   - dependencies: Dependencies to use in the class
    ///   - onEventTriggered: Callback with triggered event
    init(dependencies: Dependencies, onEventTriggered: EventCallback?) {
        self.dependencies = dependencies
        self.eventTriggered = onEventTriggered
        rootViewController = makeTabBarController()
    }
    
    /// Root view controler of the flow
    var rootViewController: UIViewController?
    
    private func makeTabBarController() -> HomeTabBarController {
        let tabBarController = HomeTabBarController()
        let dashboardViewController = UINavigationController(rootViewController: makeDashboardViewController())
        let manageViewController = UINavigationController(rootViewController: makeManageViewController())
        dashboardViewController.tabBarItem = UITabBarItem(title: "Dashboard", image: #imageLiteral(resourceName: "dashboard-icon"), tag: 0)
        manageViewController.tabBarItem = UITabBarItem(title: "Manage", image: #imageLiteral(resourceName: "dashboard-icon"), tag: 2)
        tabBarController.viewControllers = [dashboardViewController, UIViewController(), manageViewController]

        tabBarController.eventTriggered = { event in
            switch event {
            case .didTapAddActivity:
                print("didTapAddActivity called")
            }
        }
        return tabBarController
    }
    
    private func makeDashboardViewController() -> DashboardViewController {
        let viewController = dependencies.viewControllerFactory.dashboardViewController()
        viewController.viewModel.eventTriggered = { event in
            switch event {
            case .didTapDetailedRanking:
                print("didTapDetailedRanking called")
            case .didTapAllActivities:
                print("didTapAllActivities called")
            }
        }
        return viewController
    }
    
    private func makeManageViewController() -> ManageViewController {
        let viewController = dependencies.viewControllerFactory.manageViewController()
        viewController.viewModel.eventTriggered = { [unowned self] event in
            switch event {
            case .userLoggedOut:
                self.eventTriggered?(.userLoggedOut)
            }
        }
        return viewController
    }
}
