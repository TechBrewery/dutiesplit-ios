//
//  ManageMenuCellType.swift
//  DutieSplit
//


import UIKit.UIImage

/// Defines elements to be displayed on the manage cell
internal protocol ManageMenuCellType {
    
    /// Icon of the row
    var icon: UIImage { get }
    
    /// Title of the row
    var title: String { get }
    
    /// Type of the displayed option
    var option: ManageMenuOption { get }
}

/// Enum describing all available options
internal enum ManageMenuOption {
    case duties
    case settings
    case profile
    case switchGroup
    case logout
}

internal struct ManageMenuCell: ManageMenuCellType {
    let icon: UIImage
    let title: String
    let option: ManageMenuOption
}
