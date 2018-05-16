//
//  DashboardView.swift
//  DutieSplit
//


import UIKit

internal final class DashboardView: View, ViewSetupable {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(cell: PersonTableViewCell.self)
        view.register(cell: ActivityTableViewCell.self)
        view.separatorStyle = .none
        view.estimatedRowHeight = 52
        view.tableFooterView = UIView()
        return view.layoutable()
    }()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        addSubview(tableView)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        tableView.constraintToSuperviewEdges()
    }
}
