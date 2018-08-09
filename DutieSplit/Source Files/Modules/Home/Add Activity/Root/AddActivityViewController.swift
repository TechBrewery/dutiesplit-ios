//
//  AddActivityViewController.swift
//  DutieSplit
//


import UIKit

internal final class AddActivityViewController: MVVMViewController<AddActivityView, AddActivityViewModel>, BindingsSetupable, NavigationBarSetupable {
    
    private lazy var cancelButton = UIBarButtonItem(title: Localizable.Common.cancel, style: .plain, target: nil, action: nil)
    
    /// - SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.AddActivity.title
        navigationItem.leftBarButtonItem = cancelButton
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
        cancelButton.rx.tap.bind(to: viewModel.cancelButtonTap).disposed(by: disposeBag)
    }
}
