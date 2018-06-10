//
//  AddActivityFlowController.swift
//  DutieSplit
//


import UIKit

internal final class AddActivityFlowController: FlowController {
    typealias Dependencies = HasViewControllerFactory
    internal typealias EventCallback = (Event) -> ()
    
    /// Enum describing events that can be triggered
    ///
    /// - didTapCancel: Send when user tapped cancel button
    internal enum Event {
        case didTapCancel
    }
    
    var eventTriggered: EventCallback?
    
    private let dependencies: Dependencies
    
    /// Initializes Flow controllers with given dependencies
    ///
    /// - Parameters:
    ///   - dependencies: Dependencies to use in the class
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        rootViewController = UINavigationController(rootViewController: makeAddActivityViewController())
    }
    
    /// Root view controler of the flow
    private(set) var rootViewController = UIViewController()
    
    /// Root view controller casted as navigation controller
    var navigationController: UINavigationController? {
        return rootViewController as? UINavigationController
    }
    
    private func makeAddActivityViewController() -> AddActivityViewController {
        let viewController = dependencies.viewControllerFactory.addActivityViewController()
        viewController.viewModel.eventTriggered = { [unowned self] event in
            switch event {
            case .didTapCancel:
                self.eventTriggered?(.didTapCancel)
            }
        }
        return viewController
    }
}
