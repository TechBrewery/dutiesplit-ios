//
//  DashboardViewController.swift
//  DutieSplit
//


import UIKit

internal final class DashboardViewController: MVVMViewController<DashboardView, DashboardViewModel>, BindingsSetupable, NavigationBarSetupable, UITableViewDataSource, UITableViewDelegate {
    
    /// - SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Localizable.DashboardScreen.title
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
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
        }
    }
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        
    }
    
    /// - SeeAlso: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : 5
    }
    
    /// - SeeAlso: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    /// - SeeAlso: UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell: PersonTableViewCell = tableView.dequeueReusableCell(for: indexPath) else { return UITableViewCell() }
            return cell
        case 1:
            guard let cell: ActivityTableViewCell = tableView.dequeueReusableCell(for: indexPath) else { return UITableViewCell() }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    /// - SeeAlso: UITableViewDataSource
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: UIView?
        switch section {
        case 0:
            view = SectionHeader(leftLabelTitle: Localizable.DashboardScreen.ranking, height: .small, onRightButtonTap: {
                print("section RANKING all tap")
            })
        case 1:
            view = SectionHeader(leftLabelTitle: Localizable.DashboardScreen.recentActivities, height: .small, onRightButtonTap: {
                print("section RECENT ACTIVITIES all tap")
            })
        default:
            view = nil
        }
        return view
    }
}
