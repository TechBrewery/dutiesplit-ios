//
//  UINavigationBarExtension.swift
//  DutieSplit
//


import UIKit

internal extension UINavigationBar {
    
    /// Changes transparency of the navigation bar, also changes isTranslucent
    ///
    /// - Parameter isTransparent: Indicating if navigation bar should be transparent
    func setTransparent(_ isTransparent: Bool = true) {
        setBackgroundImage(isTransparent ? UIImage() : nil, for: .default)
        shadowImage = isTransparent ? UIImage() : nil
        isTranslucent = isTransparent
    }
}
