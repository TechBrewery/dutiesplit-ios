//
//  MockCrashLogger.swift
//  DutieSplitTests
//


@testable import DutieSplit

internal class MockCrashLogger: CrashLogger {
    
    var crashLoggerStarted = false
    
    /// - SeeAlso: CrashLogger.start()
    func start() {
        crashLoggerStarted = true
    }
}
