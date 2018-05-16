//
//  DashboardFlowController.swift
//  DutieSplit
//


import UIKit

internal final class DashboardFlowController: FlowController {
    typealias Dependencies = HasViewControllerFactory
    
    private let dependencies: Dependencies
    
    /// Initializes Flow controllers with given dependencies
    ///
    /// - Parameters:
    ///   - dependencies: Dependencies to use in the class
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        rootViewController = UINavigationController(rootViewController: makeDashboardViewController())
    }
    
    /// Root view controler of the flow
    var rootViewController: UIViewController?
    
    /// Root view controller casted as navigation controller
    var navigationController: UINavigationController? {
        return rootViewController as? UINavigationController
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
}
