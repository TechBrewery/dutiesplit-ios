//
//  TestsHelperSpec.swift
//  DutieSplitTests
//


@testable import DutieSplit
import Quick
import Nimble

internal final class TestsHelperSpec: QuickSpec {

    override func spec() {
        context("when testing the app") {
            it("should know about it") {
                expect(TestsHelper.isRunningUnitTests).to(beTrue())
            }
        }
    }
}
