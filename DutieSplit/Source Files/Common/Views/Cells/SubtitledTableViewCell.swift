//
//  SubtitledTableViewCell.swift
//  DutieSplit
//


import UIKit

/// Cell with title and subitle, should be used as the base cell for similar ones
internal class SubtitledTableViewCell: TableViewCell, ViewSetupable {
    
    /// Constant to be set as the leading for the title and subtitle
    var textLeadingMargin: CGFloat {
        return 16
    }
    
    /// Title label at the top with bigger font
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17)
        view.textColor = .dsTextBlack
        return view
    }()
    
    /// Subtitle gray label with smaller font below the title
    lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.textColor = .dsTextLightGray
        return view
    }()
    
    private lazy var leftStackView = UIStackView.make(
        axis: .vertical,
        with: [titleLabel, subtitleLabel],
        spacing: 2
    ).layoutable()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        contentView.addSubview(leftStackView)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 52),
            leftStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: textLeadingMargin),
            leftStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    /// Empty implementation only to route the method to the child classes
    func setupProperties() { }
}
