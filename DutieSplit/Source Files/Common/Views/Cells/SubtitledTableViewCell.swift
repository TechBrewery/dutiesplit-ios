//
//  SubtitledTableViewCell.swift
//  DutieSplit
//


import UIKit

/// Cell with title and subitle, should be used as the base cell for similar ones
internal class SubtitledTableViewCell: TableViewCell, ViewSetupable {
    
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
    
    private lazy var stackView = UIStackView.make(
        axis: .vertical,
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
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    /// Empty implementation only to route the method to the child classes
    func setupProperties() { }
}
