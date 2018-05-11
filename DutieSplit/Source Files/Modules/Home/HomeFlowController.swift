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
        let dashboardViewController = UINavigationController(rootViewController: UIViewController())
        let manageViewController = UINavigationController(rootViewController: UIViewController())
        dashboardViewController.tabBarItem = UITabBarItem(title: "Dashboard", image: #imageLiteral(resourceName: "dashboard-icon"), tag: 0)
        manageViewController.tabBarItem = UITabBarItem(title: "Manage", image: #imageLiteral(resourceName: "dashboard-icon"), tag: 0)
        tabBarController.viewControllers = [dashboardViewController, UIViewController(), manageViewController]

        tabBarController.eventTriggered = { event in
            switch event {
            case .didTapAddActivity:
                print("didTapAddActivity called")
            }
        }
        return tabBarController
    }
}
