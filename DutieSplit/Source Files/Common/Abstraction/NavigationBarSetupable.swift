//
//  NavigationBarSetupable.swift
//  DutieSplit
//


import UIKit.UINavigationBar

/// Interface for setting up the navigation bar
internal protocol NavigationBarSetupable {
    
    /// Called to setup the navigation bar
    ///
    /// - Parameter navigationBar: Navigation bar to be customized
    func setup(navigationBar: UINavigationBar)
}
