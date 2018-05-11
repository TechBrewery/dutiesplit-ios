//
//  DashboardView.swift
//  DutieSplit
//


import UIKit

internal final class DashboardView: View, ViewSetupable {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(cell: PersonTableViewCell.self)
        view.estimatedRowHeight = 52
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
