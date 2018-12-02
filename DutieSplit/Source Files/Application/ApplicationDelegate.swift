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
    
    fileprivate func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard !TestsHelper.isRunningUnitTests else { return false }
        applicationDependencies.crashLogger.start()
        return true
    }
    
    fileprivate func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard !TestsHelper.isRunningUnitTests else { return false }
        flowController.startApp()
        return true
    }
}
