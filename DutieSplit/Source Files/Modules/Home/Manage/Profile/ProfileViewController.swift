//
//  ProfileViewController.swift
//  DutieSplit
//


import UIKit

internal final class ProfileViewController: MVVMViewController<ProfileView, ProfileViewModel>, BindingsSetupable, NavigationBarSetupable {
    
    /// - SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.ProfileScreen.title
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
