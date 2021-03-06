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
    
    private var addActivityFlowController: AddActivityFlowController?
    
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
    private(set) var rootViewController = UIViewController()
    
    private func makeTabBarController() -> HomeTabBarController {
        let tabBarController = dependencies.viewControllerFactory.homeTabBarController(
            dashboardFlowController: dashboardFlowController,
            manageFlowController: manageFlowController
        )
        tabBarController.eventTriggered = { [unowned self] event in
            switch event {
            case .didTapAddActivity:
                self.addActivityFlowController = self.makeAddActivityFlowController()
                guard let addActivityFlowController = self.addActivityFlowController else { return }
                self.rootViewController.present(addActivityFlowController.rootViewController, animated: true)
            }
        }
        return tabBarController
    }
    
    private func makeDashboardFlowController() -> DashboardFlowController {
        let flowController = DashboardFlowController(dependencies: dependencies)
        return flowController
    }
    
    private func makeAddActivityFlowController() -> AddActivityFlowController {
        let flowController = AddActivityFlowController(dependencies: dependencies)
        flowController.eventTriggered = { [unowned self] event in
            switch event {
            case .didTapCancel:
                self.addActivityFlowController?.rootViewController.dismiss(animated: true)
                self.addActivityFlowController = nil
            }
        }
        return flowController
    }
    
    private func makeManageFlowController() -> ManageFlowController {
        return ManageFlowController(dependencies: dependencies)
    }
}
