//
//  ManageViewController.swift
//  DutieSplit
//


import UIKit

internal final class ManageViewController: ViewController<ManageView, ManageViewModel>, BindingsSetupable, NavigationBarSetupable {
    
    /// - SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Manage"
    }
    
    /// - SeeAlso: NavigationBarSetupable
    func setup(navigationBar: UINavigationBar) {
        
    }
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        
    }
}

