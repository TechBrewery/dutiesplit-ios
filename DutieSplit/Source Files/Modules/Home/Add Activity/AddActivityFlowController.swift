//
//  AddActivityFlowController.swift
//  DutieSplit
//


import UIKit

internal final class AddActivityFlowController: FlowController {
    typealias Dependencies = HasViewControllerFactory
    
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
    
    private func makeAddActivityViewController() -> UIViewController {
        let viewController = UIViewController()
        viewController.title = Localizable.AddActivity.title
        return viewController
    }
}
