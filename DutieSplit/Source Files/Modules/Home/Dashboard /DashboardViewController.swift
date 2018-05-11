//
//  DashboardViewController.swift
//  DutieSplit
//


import UIKit

internal final class DashboardViewController: ViewController<DashboardView, DashboardViewModel>, BindingsSetupable, NavigationBarSetupable, UITableViewDataSource, UITableViewDelegate {
    
    /// - SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Dashboard"
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PersonTableViewCell = tableView.dequeueReusableCell(for: indexPath) else { return UITableViewCell() }
        return cell
    }
}
