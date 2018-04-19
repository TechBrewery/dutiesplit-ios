//
//  UIViewExtension.swift
//  DutieSplit
//


import UIKit

internal extension UIView {
    
    /// Looks for first responder in given view
    ///
    /// - Returns: Found first responder view or nil if not found
    func firstResponder() -> UIView? {
        if isFirstResponder {
            return self
        }
        for subview in subviews {
            if let firstResponder = subview.firstResponder() {
                return firstResponder
            }
        }
        return nil
    }
}
