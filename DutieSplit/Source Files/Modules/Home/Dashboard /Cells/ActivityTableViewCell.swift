//
//  ActivityTableViewCell.swift
//  DutieSplit
//


internal final class ActivityTableViewCell: SubtitledTableViewCell {
    
    /// - SeeAlso: ViewSetupable
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
    }
    
    /// - SeeAlso: ViewSetupable
    override func setupConstraints() {
        super.setupConstraints()
    }
    
    /// - SeeAlso: ViewSetupable
    override func setupProperties() {
        super.setupProperties()
        subtitleLabel.textColor = .dsGreen
        titleLabel.text = "Dishwasher"
        subtitleLabel.text = "+1 pt"
    }
}
