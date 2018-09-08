//
//  ManageTableViewCell.swift
//  DutieSplit
//


import UIKit

internal final class ManageTableViewCell: TableViewCell, ViewSetupable {
    
    /// Data displayed on the cell. Automatically updates the view after settings the value.
    var cellData: ManageMenuCellType! {
        didSet {
            iconImageView.image = cellData.icon
            titleLabel.text = cellData.title
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17)
        view.textColor = .dsTextBlack
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var bottomBorder: SeparatorView = .init(axis: .vertical, thickness: 1, color: .dsBorderGray)
    
    private lazy var leftStackView = UIStackView.make(
        axis: .horizontal,
        with: [iconImageView, titleLabel],
        spacing: 12
    ).layoutable()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [leftStackView, bottomBorder].forEach { contentView.addSubview($0) }
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        iconImageView.constrainToConstant(size: .init(width: 30, height: 30))
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 50),
            leftStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            leftStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            bottomBorder.leadingAnchor.constraint(equalTo: leftStackView.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 40),
            bottomBorder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        accessoryType = .disclosureIndicator
    }
}
