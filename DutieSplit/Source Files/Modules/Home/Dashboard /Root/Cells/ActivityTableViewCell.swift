//
//  ActivityTableViewCell.swift
//  DutieSplit
//


import UIKit

internal final class ActivityTableViewCell: SubtitledTableViewCell {
    
    /// - SeeAlso: SubtitledTableViewCell.textLeadingMargin
    override var textLeadingMargin: CGFloat {
        return 54
    }
    
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
    
    private lazy var emojiView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.dsRed.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 6
        return view.layoutable()
    }()
    
    private lazy var rightStackView = UIStackView.make(
        axis: .vertical,
        with: [personLabel, dateLabel],
        spacing: 2
    ).layoutable()
    
    /// - SeeAlso: ViewSetupable
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        [emojiView, rightStackView].forEach { contentView.addSubview($0) }
    }
    
    /// - SeeAlso: ViewSetupable
    override func setupConstraints() {
        super.setupConstraints()
        emojiView.constraintToConstant(.init(width: 28, height: 28))
        NSLayoutConstraint.activate([
            emojiView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            emojiView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
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
