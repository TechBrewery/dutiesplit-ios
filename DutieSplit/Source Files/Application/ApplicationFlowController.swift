//
//  ApplicationFlowController.swift
//  DutieSplit
//


import UIKit

/// Main Flow controller of the app, has access to the main window and can change root controller
internal final class ApplicationFlowController {
    
    private weak var window: UIWindow?
    
    private let dependencies: ApplicationDependencies
    
    private var rootFlowController: FlowController?
    
    /// Initializes Main Flow Controllers
    ///
    /// - Parameters:
    ///   - window: Main window of the app
    ///   - dependencies: Deppendencies to use in the app
    init(window: UIWindow?, dependencies: ApplicationDependencies) {
        guard let window = window else {
            fatalError("Window given to the App Flow Controller was nil")
        }
        self.window = window
        self.dependencies = dependencies
    }
    
    /// Call after application was loaded, it will set proper view controller as window root
    internal func startApp() {
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        if dependencies.authenticationService.token == nil {
            changeRootFlowController(to: makeLoginFlowController())
        } else {
            // TODO: Replace below line with commented one.
            // It's changed for now because there's no logout method
            // changeRootFlowController(to: makeLoginFlowController())
            changeRootFlowController(to: makeLoginFlowController())
        }
        
    }
    
    private func makeLoginFlowController() -> FlowController {
        return LoginFlowController(
            dependencies: dependencies,
            onEventTriggered: { [unowned self] event in
                switch event {
                case .userLoggedIn:
                    self.changeRootFlowController(to: self.makeHomeFlowController())
                }
            }
        )
    }
    
    private func makeHomeFlowController() -> FlowController {
        return HomeFlowController(
            dependencies: dependencies,
            onEventTriggered: { [unowned self] event in
                switch event {
                case .userLoggedOut:
                    self.changeRootFlowController(to: self.makeLoginFlowController())
                }
            }
        )
    }
    
    private func changeRootFlowController(to flowController: FlowController) {
        rootFlowController = flowController
        window?.rootViewController = flowController.rootViewController
    }
}
