//
//  AddActivityViewController.swift
//  DutieSplit
//


import UIKit

internal final class AddActivityViewController: ViewController<AddActivityView, AddActivityViewModel>, BindingsSetupable, NavigationBarSetupable {
    
    /// - SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.AddActivity.title
    }
    
    /// - SeeAlso: NavigationBarSetupable
    func setup(navigationBar: UINavigationBar) {
        
    }
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        
    }
}
