//
//  LoginFlowController.swift
//  DutieSplit
//


import UIKit

internal final class LoginFlowController: FlowController {
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
        rootViewController = UINavigationController(rootViewController: makeLoginViewController())
    }
    
    /// Root view controler of the flow
    var rootViewController: UIViewController?
    
    /// Root view controller casted as navigation controller
    var navigationController: UINavigationController? {
        return rootViewController as? UINavigationController
    }
    
    private func makeLoginViewController() -> LoginViewController {
        let viewController = dependencies.viewControllerFactory.loginViewController()
        viewController.viewModel.eventTriggered = { [unowned self] event in
            switch event {
            case .userLoggedIn:
                print("LoginViewController triggered: .userLoggedIn")
            case .didTapRegister:
                self.navigationController?.pushViewController(self.makeRegisterViewController(), animated: true)
            }
        }
        return viewController
    }
    
    private func makeRegisterViewController() -> RegisterViewController {
        let viewController = dependencies.viewControllerFactory.registerViewController()
        viewController.viewModel.eventTriggered = { event in
            switch event {
            case .userLoggedIn:
                print("LoginViewController triggered: .userLoggedIn")
            }
        }
        return viewController
    }
}
