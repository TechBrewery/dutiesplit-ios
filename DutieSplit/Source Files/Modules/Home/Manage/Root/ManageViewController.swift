//
//  ManageViewController.swift
//  DutieSplit
//


import UIKit

internal final class ManageViewController: ViewController<ManageView, ManageViewModel>, BindingsSetupable, NavigationBarSetupable, UITableViewDelegate, UITableViewDataSource {
    
    /// - SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.ManageScreen.title
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
        
    }
    
    /// - SeeAlso: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellsData.sections[section].cells.count
    }
    
    /// - SeeAlso: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.cellsData.sections.count
    }
    
    /// - SeeAlso: UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ManageTableViewCell = tableView.dequeueReusableCell(for: indexPath) else { return UITableViewCell() }
        cell.cellData = viewModel.cellsData.sections[indexPath.section].cells[indexPath.row]
        return cell
    }
    
    /// - SeeAlso: UITableViewDataSource
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionData = viewModel.cellsData.sections[section]
        return SectionHeader(leftLabelTitle: sectionData.title, height: .large)
    }
    
    /// - SeeAlso: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = viewModel.cellsData.sections[indexPath.section].cells[indexPath.row]
        viewModel.didTapCell(cellData.option)
    }
}

