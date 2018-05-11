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
    
    /// Root view controller casted as navigation controller
    var navigationController: UINavigationController? {
        return rootViewController as? UINavigationController
    }
    
    private func makeTabBarController() -> UITabBarController {
        let tabBarController = HomeTabBarController()
        tabBarController.eventTriggered = { event in
            switch event {
            case .didTapAddActivity:
                print("didTapAddActivity called")
            }
        }
        tabBarController.viewControllers = [UIViewController(), UIViewController(), UIViewController()]
        return tabBarController
    }
}
