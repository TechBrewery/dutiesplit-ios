//
//  ApplicationDelegate.swift
//  DutieSplit
//

import UIKit

@UIApplicationMain
private final class ApplicationDelegate: UIResponder, UIApplicationDelegate {
    
    /// - SeeAlso: UIApplicationDelegate.window
    fileprivate lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    fileprivate func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}
