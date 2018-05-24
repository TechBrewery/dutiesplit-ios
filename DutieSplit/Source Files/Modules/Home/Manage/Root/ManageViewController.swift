//
//  ManageViewController.swift
//  DutieSplit
//


import UIKit

internal final class ManageViewController: ViewController<ManageView, ManageViewModel>, BindingsSetupable, NavigationBarSetupable, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: nil, action: nil)
    
    /// - SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Group name"
        navigationItem.rightBarButtonItem = logoutButton
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
    }
    
    /// - SeeAlso: UIViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let selectedRow = customView.tableView.indexPathForSelectedRow else { return }
        customView.tableView.deselectRow(at: selectedRow, animated: true)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ManageTableViewCell = tableView.dequeueReusableCell(for: indexPath) else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return SectionHeader(leftLabelTitle: Localizable.ManageScreen.group, height: .large)
        case 1:
            return SectionHeader(leftLabelTitle: Localizable.ManageScreen.settings, height: .large)
        default:
            return nil
        }
    }
}

