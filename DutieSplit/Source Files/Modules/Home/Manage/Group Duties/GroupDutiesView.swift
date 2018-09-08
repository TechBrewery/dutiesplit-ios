//
//  GroupDutiesView.swift
//  DutieSplit
//


import UIKit

internal final class GroupDutiesView: View, ViewSetupable {
    
    /// Main table view of the screen
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(cell: DutieTableViewCell.self)
        view.allowsSelection = false
        view.estimatedRowHeight = 40
        view.tableFooterView = UIView()
        return view.layoutable()
    }()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        addSubview(tableView)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        tableView.constrainToSuperviewEdges()
    }
}
