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
        return viewModel.cellsData.sections[section].cells.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.cellsData.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ManageTableViewCell = tableView.dequeueReusableCell(for: indexPath) else { return UITableViewCell() }
        cell.cellData = viewModel.cellsData.sections[indexPath.section].cells[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionData = viewModel.cellsData.sections[section]
        return SectionHeader(leftLabelTitle: sectionData.title, height: .large)
    }
}

