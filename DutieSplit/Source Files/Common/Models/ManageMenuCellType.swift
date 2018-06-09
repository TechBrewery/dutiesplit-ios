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
}

internal struct ManageMenuCell: ManageMenuCellType {
    
    let icon: UIImage
    let title: String
}
