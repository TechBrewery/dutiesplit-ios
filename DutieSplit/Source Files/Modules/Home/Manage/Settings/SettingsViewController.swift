//
//  SettingsViewController.swift
//  DutieSplit
//


import UIKit

internal final class SettingsViewController: ViewController<SettingsView, SettingsViewModel>, BindingsSetupable, NavigationBarSetupable {
    
    /// - SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.SettingsScreen.title
    }
    
    /// - SeeAlso: NavigationBarSetupable
    func setup(navigationBar: UINavigationBar) {
        
    }
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        
    }
}

