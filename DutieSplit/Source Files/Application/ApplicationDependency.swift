//
//  ApplicationDependency.swift
//  DutieSplit
//


/// Shared dependencies used extensively in the application
internal protocol ApplicationDependencies: HasApplicationKeys, HasCrashLogger, HasViewControllerFactory { }

/// - SeeAlso: ApplicationDependencies
internal class DefaultApplicationDependencies: ApplicationDependencies {
    lazy var applicationKeys: ApplicationKeys = ApplicationKeys(keys: DutieSplitKeys())
    lazy var crashLogger: CrashLogger = HockeyAppService(keys: applicationKeys)
    lazy var viewControllerFactory = ViewControllerFactory()
}
