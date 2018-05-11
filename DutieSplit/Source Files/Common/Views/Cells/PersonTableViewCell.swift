//
//  PersonTableViewCell.swift
//  DutieSplit
//


import UIKit

internal final class PersonTableViewCell: TableViewCell, ViewSetupable {
    
    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17)
        view.textColor = .dsTextBlack
        return view
    }()
    
    private lazy var balanceLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .dsTextLightGray
        return view
    }()
    
    private lazy var stackView = UIStackView.make(
        axis: .vertical,
        with: [nameLabel, balanceLabel],
        spacing: 2
    ).layoutable()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        contentView.addSubview(stackView)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 52),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        nameLabel.text = "Barack Obama"
        balanceLabel.text = "0 pt"
    }
}
