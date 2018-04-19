//
//  FlowController.swift
//  DutieSplit
//


import UIKit

/// Interface for the flow controller
internal protocol FlowController {
    
    /// Root view controller of the given flow
    var rootViewController: UIViewController? { get }
}
