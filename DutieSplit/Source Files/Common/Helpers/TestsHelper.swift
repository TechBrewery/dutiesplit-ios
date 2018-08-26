//
//  TestsHelper.swift
//  DutieSplit
//


struct TestsHelper {

    static var isRunningUnitTests: Bool {
        return ProcessInfo.processInfo.arguments.contains("-UnitTests")
    }
}
