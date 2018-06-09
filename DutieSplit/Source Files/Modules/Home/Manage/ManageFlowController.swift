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
            }
        }
        return viewController
    }
}
