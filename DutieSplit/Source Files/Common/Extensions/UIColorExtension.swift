//
//  UIColorExtension.swift
//  DutieSplit
//


import UIKit.UIColor

internal extension UIColor {
    
    /// Convenience intitializer for hex format
    ///
    /// - Parameter hex: color in hex format (for example 0x121212)
    convenience init(hex: Int) {
        let red = CGFloat((hex >> 16) & 0xff) / 255
        let green = CGFloat((hex >> 08) & 0xff) / 255
        let blue = CGFloat((hex >> 00) & 0xff) / 255
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    class var DSRed: UIColor {
        return .init(hex: 0xAF1F31)
    }
    
    class var DSGreen: UIColor {
        return .init(hex: 0x056D17)
    }
    
    class var DSBlue: UIColor {
        return .init(hex: 0x0076FF)
    }
    
    class var DSGray: UIColor {
        return .init(hex: 0xEFEFF4)
    }
    
    class var DSTextGray: UIColor {
        return .init(hex: 0x8F8E94)
    }
}
