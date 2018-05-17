//
//  SectionHeader.swift
//  DutieSplit
//


import UIKit

internal final class SectionHeader: View, ViewSetupable {
    
    /// Available view heights to apply to the view
    internal enum SectionHeight: CGFloat {
        case small = 30
        case large = 70
    }
    
    /// Initializes the view with given parameters
    ///
    /// - Parameters:
    ///   - leftLabelTitle: Title to be set on the label on the left side
    ///   - height: Height that should be applied to the view
    ///   - onRightButtonTap: Callback invoked when button on the right was tapped. Pass nil to hide the button
    init(leftLabelTitle: String, height: SectionHeight, onRightButtonTap: (() -> ())? = nil) {
        self.onRightButtonTap = onRightButtonTap
        self.height = height
        super.init()
        leftLabel.text = leftLabelTitle
    }
    
    private let height: SectionHeight
    
    private let onRightButtonTap: (() -> ())?
    
    private var shouldHaveRightButton: Bool { return onRightButtonTap != nil }
    
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
    
    private lazy var blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular)).layoutable()
    
    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        // Add blur effect if it's not disabled in the settings
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            addSubview(blurEffectView)
        }
        
        if shouldHaveRightButton{
            addSubview(rightButton)
        }
        
        [leftLabel, bottomBorder].forEach { addSubview($0) }
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        if blurEffectView.superview != nil {
            blurEffectView.constraintToSuperviewEdges()
        }
        bottomBorder.constraintToSuperviewEdges(excludingAnchors: [.top])
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height.rawValue),
            leftLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
        
        guard shouldHaveRightButton else { return }
        NSLayoutConstraint.activate([
            rightButton.centerYAnchor.constraint(equalTo: leftLabel.centerYAnchor),
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        backgroundColor = .dsDarkGray
    }
    
    @objc private func didTapRightButton() {
        onRightButtonTap?()
    }
}