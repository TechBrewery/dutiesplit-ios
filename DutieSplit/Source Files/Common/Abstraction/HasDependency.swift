//
//  HasDependency.swift
//  DutieSplit
//


internal protocol HasCrashLogger {
    var crashLogger: CrashLogger { get }
}

internal protocol HasApplicationKeys {
    var applicationKeys: ApplicationKeys { get }
}

internal protocol HasViewControllerFactory {
    var viewControllerFactory: ViewControllerFactory { get }
}
