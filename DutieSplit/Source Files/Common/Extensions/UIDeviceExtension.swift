//
//  UIDeviceExtension.swift
//  DutieSplit
//


import UIKit

internal extension UIDevice {
    
    /// Indicates if currently used device is a simulator
    static var isIOSSimulator: Bool {
        var toReturn = false
        #if targetEnvironment(simulator)
            toReturn = true
        #endif
        return toReturn
    }
}
