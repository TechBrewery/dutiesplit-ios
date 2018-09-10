//
//  DutieTableViewCell.swift
//  DutieSplit
//


import UIKit

internal final class DutieTableViewCell: TableViewCell, ViewSetupable {
    
    private lazy var emojiView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.dsRed.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 6
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17)
        view.textColor = .dsTextBlack
        return view
    }()
    
    private lazy var pointsLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textAlignment = .right
        view.textColor = .dsGreen
        return view
    }()
    
    private lazy var stackView = UIStackView.make(
        axis: .horizontal,
        with: [emojiView, titleLabel, pointsLabel],
        spacing: 10
    ).layoutable()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        contentView.addSubview(stackView)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        stackView.constrainToSuperviewEdges(excluding: [.top, .bottom], insets: .init(top: 8, left: 16, bottom: 8, right: 8))
        emojiView.constrainToConstant(size: .init(width: 28, height: 28))
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 40),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pointsLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        titleLabel.text = "Dishwasher"
        pointsLabel.text = "+1 pt"
    }
}
