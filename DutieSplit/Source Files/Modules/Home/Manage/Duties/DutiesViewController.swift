//
//  DutiesViewController.swift
//  DutieSplit
//


import UIKit

internal final class DutiesViewController: ViewController<DutiesView, DutiesViewModel>, BindingsSetupable, NavigationBarSetupable, UITableViewDataSource, UITableViewDelegate {
    
    /// - SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.DutiesScreen.title
        customView.tableView.dataSource = self
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
    
    /// - SeeAlso: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    /// - SeeAlso: UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: DutieTableViewCell = tableView.dequeueReusableCell(for: indexPath) else { return UITableViewCell() }
        return cell
    }
}

