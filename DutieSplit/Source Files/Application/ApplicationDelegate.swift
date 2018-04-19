//
//  ApplicationDelegate.swift
//  DutieSplit
//

import UIKit

@UIApplicationMain
private final class ApplicationDelegate: UIResponder, UIApplicationDelegate {
    
    /// - SeeAlso: ApplicationDependencies
    private let applicationDependencies = DefaultApplicationDependencies()
    
    /// Main Flow controller of the app
    private lazy var flowController = ApplicationFlowController(window: window, dependencies: applicationDependencies)
    
    /// - SeeAlso: UIApplicationDelegate.window
    fileprivate lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    fileprivate func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        applicationDependencies.crashLogger.start()
        return true
    }
    
    fileprivate func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        flowController.startApp()
        return true
    }
}
