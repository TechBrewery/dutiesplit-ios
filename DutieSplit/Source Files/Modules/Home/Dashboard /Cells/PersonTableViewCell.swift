//
//  PersonTableViewCell.swift
//  DutieSplit
//


import UIKit

internal final class PersonTableViewCell: SubtitledTableViewCell {
    
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
        titleLabel.text = "Barack Obama"
        subtitleLabel.text = "0 pt"
    }
}
