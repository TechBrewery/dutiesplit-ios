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
        
    }
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        
    }
}
