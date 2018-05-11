//
//  DashboardViewController.swift
//  DutieSplit
//


import UIKit

internal final class DashboardViewController: ViewController<DashboardView, DashboardViewModel>, BindingsSetupable, NavigationBarSetupable {
    
    /// - SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dashboard"
    }
    
    /// - SeeAlso: NavigationBarSetupable
    func setup(navigationBar: UINavigationBar) {
        
    }
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        
    }
}
