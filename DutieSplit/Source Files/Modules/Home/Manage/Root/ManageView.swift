//
//  ManageView.swift
//  DutieSplit
//


import UIKit

internal final class ManageView: View, ViewSetupable {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(cell: ManageTableViewCell.self)
        view.separatorStyle = .none
        view.estimatedRowHeight = 50
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
