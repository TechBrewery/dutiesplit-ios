//
//  UIViewExtension.swift
//  DutieSplit
//


import UIKit

internal extension UIView {
    
    /// Anchor of the view
    internal enum Anchor {
        case top
        case right
        case bottom
        case left
    }
    
    /// Constraint edges of the view to its superview edges
    ///
    /// - Parameters:
    ///   - excludingAnchors: Anchros that shouldn't be constraint
    ///   - insets: Insets to use, .zero by default
    /// - Returns: Created constraints
    @discardableResult func constraintToSuperviewEdges(excludingAnchors: [Anchor]? = nil, withInsets insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        guard let superview = superview else {
            fatalError("Cannot constrain to nil superview")
        }
        return constraintToEdges(of: superview, excludingAnchors: excludingAnchors, withInsets: insets)
    }
    
    /// Constraint edges of the view to given view edges
    ///
    /// - Parameters:
    ///   - view: View to constraint edges to
    ///   - excludingAnchors: Anchros that shouldn't be constraint
    ///   - insets: Insets to use, .zero by default
    /// - Returns: Created constraints
    @discardableResult func constraintToEdges(of view: UIView, excludingAnchors: [Anchor]? = nil, withInsets insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        if let excludedAnchors = excludingAnchors {
            if !excludedAnchors.contains(.top) { constraints.append(topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top)) }
            if !excludedAnchors.contains(.right) { constraints.append(rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right)) }
            if !excludedAnchors.contains(.bottom) { constraints.append(bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)) }
            if !excludedAnchors.contains(.left) { constraints.append(leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left)) }
        } else {
            constraints = [
                topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
                leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left),
                rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right),
                bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
            ]
        }
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    /// Constraint edges of the view to its superview layout guide
    ///
    /// - Parameters:
    ///   - excludingAnchors: Anchros that shouldn't be constraint
    ///   - insets: Insets to use, .zero by default
    /// - Returns: Created constraints
    @discardableResult func constraintToSuperviewLayoutGuide(excludingAnchors: [Anchor]? = nil, withInsets insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        guard let superview = superview else {
            fatalError("Cannot constrain to nil superview")
        }
        return constraintToLayoutGuide(of: superview, excludingAnchors: excludingAnchors, withInsets: insets)
    }
    
    /// Constraint edges of the view to given view layout guide
    ///
    /// - Parameters:
    ///   - view: View to constraint edges to
    ///   - excludingAnchors: Anchros that shouldn't be constraint
    ///   - insets: Insets to use, .zero by default
    /// - Returns: Created constraints
    @discardableResult func constraintToLayoutGuide(of view: UIView, excludingAnchors: [Anchor]? = nil, withInsets insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        if #available(iOS 11.0, *) {
            let layoutGuide = view.safeAreaLayoutGuide
            if let excludedAnchors = excludingAnchors {
                if !excludedAnchors.contains(.top) { constraints.append(topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top)) }
                if !excludedAnchors.contains(.right) { constraints.append(rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -insets.right)) }
                if !excludedAnchors.contains(.bottom) { constraints.append(bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom)) }
                if !excludedAnchors.contains(.left) { constraints.append(leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: insets.left)) }
            } else {
                constraints = [
                    topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top),
                    leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: insets.left),
                    rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -insets.right),
                    bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom)
                ]
            }
            NSLayoutConstraint.activate(constraints)
            return constraints
        }
        else {
            return []
        }
    }
}
