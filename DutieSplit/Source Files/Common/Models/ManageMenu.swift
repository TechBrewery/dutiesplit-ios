//
//  ManageMenuCell.swift
//  DutieSplit
//

import UIKit.UIImage

internal struct ManageMenu {
    let icon: UIImage
    let title: String
    let option: Option

    enum Option {
        case duties
        case groupSettings
        case profile
        case switchGroup
        case logout
    }
}

internal extension ManageMenu {

    /// Configures object in given cell.
    ///
    /// - Parameter cell: Cell to be feeded with data.
    /// - Returns: Configured cell
    func configured(in cell: ManageTableViewCell) -> ManageTableViewCell {
        cell.update(with: icon, title: title)
        return cell
    }
}
