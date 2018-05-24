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
    
    private lazy var dashboardFlowController: DashboardFlowController = makeDashboardFlowController()
    
    private lazy var manageFlowController: ManageFlowController = makeManageFlowController()
    
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
        
        let dashboardViewController = dashboardFlowController.rootViewController!
        dashboardViewController.tabBarItem = UITabBarItem(title: Localizable.DashboardScreen.title, image: #imageLiteral(resourceName: "dashboard-icon"), tag: 0)
        
        let manageViewController = manageFlowController.rootViewController!
        manageViewController.tabBarItem = UITabBarItem(title: Localizable.ManageScreen.title, image: #imageLiteral(resourceName: "manage-icon"), tag: 2)
        
        tabBarController.viewControllers = [dashboardViewController, UIViewController(), manageViewController]
        tabBarController.eventTriggered = { event in
            switch event {
            case .didTapAddActivity:
                print("didTapAddActivity called")
            }
        }
        return tabBarController
    }
    
    private func makeDashboardFlowController() -> DashboardFlowController {
        let flowController = DashboardFlowController(dependencies: dependencies)
        return flowController
    }
    
    private func makeManageFlowController() -> ManageFlowController {
        let flowController = ManageFlowController(dependencies: dependencies)
        flowController.eventTriggered = { [unowned self] event in
            switch event {
            case .userLoggedOut:
                self.eventTriggered?(.userLoggedOut)
            }
        }
        return flowController
    }
}
