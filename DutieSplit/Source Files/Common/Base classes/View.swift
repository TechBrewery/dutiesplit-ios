//
//  View.swift
//  DutieSplit
//


import UIKit

/// Base class for UIView sublclasses to remove boilerplate from custom views
internal class View: UIView {
    
    /// - SeeAlso: NSCoding.init?(coder:)
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initialize an instance and calls required methods
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        guard let setupableView = self as? ViewSetupable else { return }
        setupableView.setupViewHierarchy()
        setupableView.setupConstraints()
        setupableView.setupProperties()
    }
    
    /// - SeeAlso: UIView.requiresConstraintBasedLayout
    override static var requiresConstraintBasedLayout : Bool {
        return true
    }
}
