//
//  ActivityTableViewCell.swift
//  DutieSplit
//


import UIKit

internal final class ActivityTableViewCell: SubtitledTableViewCell {
    
    private lazy var personLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .dsTextBlack
        view.textAlignment = .right
        return view
    }()

    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .dsTextLightGray
        view.textAlignment = .right
        return view
    }()
    
    private lazy var rightStackView = UIStackView.make(
        axis: .vertical,
        with: [personLabel, dateLabel],
        spacing: 2
    ).layoutable()
    
    /// - SeeAlso: ViewSetupable
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        contentView.addSubview(rightStackView)
    }
    
    /// - SeeAlso: ViewSetupable
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            rightStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            rightStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    override func setupProperties() {
        super.setupProperties()
        subtitleLabel.textColor = .dsGreen
        titleLabel.text = "Dishwasher"
        subtitleLabel.text = "+1 pt"
        personLabel.text = "Barack Obama"
        dateLabel.text = "Today, 16:36"
    }
}
