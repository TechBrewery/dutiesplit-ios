//
//  ViewController.swift
//  DutieSplit
//


import UIKit

/// Simplest View controller subclass with to be used in the application
internal class ViewController: KeyboardAwareViewController {
    
    /// - SeeAlso: UIViewController.viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationBarCustomizable = self as? NavigationBarSetupable, let navigationController = navigationController {
            navigationBarCustomizable.setup(navigationBar: navigationController.navigationBar)
        }
    }
    
    /// - SeeAlso: UIViewController.willMove()
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)

        // Fix for the glitch when NavigationBar not changed it's style to the end of the pop animation
        guard
            let navigationController = navigationController,
            let controllerIndex = navigationController.viewControllers.index(of: self),
            controllerIndex > 0,
            let previousController = navigationController.viewControllers[controllerIndex-1] as? NavigationBarSetupable
        else { return }
        previousController.setup(navigationBar: navigationController.navigationBar)
    }
}
