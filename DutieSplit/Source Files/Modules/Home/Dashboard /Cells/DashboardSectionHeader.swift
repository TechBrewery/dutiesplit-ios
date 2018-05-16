//
//  DashboardSectionHeader.swift
//  DutieSplit
//


import UIKit

internal final class DashbaordSectionHeader: View, ViewSetupable {
    
    /// Initializes the view with given parameters
    ///
    /// - Parameters:
    ///   - leftLabelTitle: Title to be set on the label on the left side
    ///   - onRightButtonTap: Callback invoked when button on the right was tapped
    init(leftLabelTitle: String, onRightButtonTap: @escaping () -> ()) {
        self.onRightButtonTap = onRightButtonTap
        super.init()
        leftLabel.text = leftLabelTitle
    }
    
    private let onRightButtonTap: () -> ()
    
    private lazy var leftLabel: UILabel = {
        let view = UILabel()
        view.textColor = .dsTextGray
        view.font = .systemFont(ofSize: 13)
        return view.layoutable()
    }()
    
    private lazy var rightButton: UIButton = {
        let view = UIButton(type: .system)
        view.tintColor = .dsRed
        view.titleLabel?.font = .systemFont(ofSize: 13)
        view.setTitle(Localizable.DashboardScreen.buttonAll, for: .normal)
        view.addTarget(self, action: #selector(didTapRightButton), for: .touchUpInside)
        return view.layoutable()
    }()
    
    private lazy var bottomBorder: UIView = .separator(axis: .vertical, thickness: 1, color: UIColor.dsGray.withAlphaComponent(0.6))
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        [leftLabel, rightButton, bottomBorder].forEach { addSubview($0) }
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        bottomBorder.constraintToSuperviewEdges(excludingAnchors: [.top])
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 30),
            leftLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        backgroundColor = .dsDarkGray
    }
    
    @objc private func didTapRightButton() {
        onRightButtonTap()
    }
}
