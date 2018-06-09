//
//  SwitchGroupViewController.swift
//  DutieSplit
//


import UIKit

internal final class SwitchGroupViewController: ViewController<SwitchGroupView, SwitchGroupViewModel>, BindingsSetupable, NavigationBarSetupable {
    
    /// - SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.SwitchGroupScreen.title
    }
    
    /// - SeeAlso: NavigationBarSetupable
    func setup(navigationBar: UINavigationBar) {
        navigationBar.tintColor = .dsRed
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = false
        }
    }
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        
    }
}
