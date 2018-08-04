//
//  GroupMemberTableViewCell.swift
//  DutieSplit
//


import UIKit

internal final class GroupMemberTableViewCell: TableViewCell, ViewSetupable {

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17)
        view.textColor = .dsTextBlack
        return view
    }()

    private lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .dsTextLightGray
        return view
    }()

    private lazy var stackView = UIStackView.make(
        axis: .horizontal,
        with: [titleLabel, subtitleLabel],
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
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        titleLabel.text = "Barack Obama"
        subtitleLabel.text = "OWNER"
    }
}
