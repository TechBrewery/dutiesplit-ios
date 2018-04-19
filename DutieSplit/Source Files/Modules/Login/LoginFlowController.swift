//
//  LoginFlowController.swift
//  DutieSplit
//


import UIKit

internal final class HomeFlowController: FlowController {
    typealias Dependencies = HasViewControllerFactory
    
    /// Enum describing events that can be triggered
    ///
    /// - testEvent: Event added just to test the architecture
    internal enum Event {
        case testEvent
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
        rootViewController = makeLoginViewController()
    }
    
    /// Root view controler of the flow
    var rootViewController: UIViewController?
    
    private func makeLoginViewController() -> LoginViewController {
        let viewController = dependencies.viewControllerFactory.makeLoginViewController()
        viewController.viewModel.eventTriggered = { event in
            switch event {
            case .userLoggedIn:
                print("LoginViewController triggered: .userLoggedIn")
            case .didTapRegister:
                print("LoginViewController triggered: .didTapRegister")
            }
        }
        return viewController
    }
}
