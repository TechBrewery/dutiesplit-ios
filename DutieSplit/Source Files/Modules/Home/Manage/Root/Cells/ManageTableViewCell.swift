//
//  ManageTableViewCell.swift
//  DutieSplit
//


import UIKit

internal final class ManageTableViewCell: TableViewCell, ViewSetupable {
    
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
        iconImageView.constraintToConstant(.init(width: 30, height: 30))
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 50),
            leftStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            leftStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            bottomBorder.leadingAnchor.constraint(equalTo: leftStackView.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomBorder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        titleLabel.text = "Submenu"
        iconImageView.image = #imageLiteral(resourceName: "duties-icon")
    }
}
