//
//  ManageViewController.swift
//  DutieSplit
//


import UIKit

internal final class ManageViewController: ViewController<ManageView, ManageViewModel>, BindingsSetupable, NavigationBarSetupable {
    
    private lazy var logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: nil, action: nil)
    
    /// - SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Manage"
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    /// - SeeAlso: NavigationBarSetupable
    func setup(navigationBar: UINavigationBar) {
        navigationBar.tintColor = .dsRed
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
        }
    }
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        logoutButton.rx.tap.bind(to: viewModel.logoutButtonTap).disposed(by: disposeBag)
    }
}

