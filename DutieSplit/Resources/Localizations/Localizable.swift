//
//  Localizable.swift
//  DutieSplit
//

import Foundation

internal struct Localizable {
    
    struct Common {
        static let loremIpsum = localized("lorem.ipsum")
        static let ok = localized("ok")
        static let cancel = localized("cancel")
        static let confirm = localized("confirm")
        static let next = localized("next")
        static let back = localized("back")
        static let done = localized("done")
        static let close = localized("close")
        static let yes = localized("yes")
        static let no = localized("no")
    }
    
    struct LoginScreen {
        static let placeholderEmail = localized("login.placeholder.email")
        static let placeholderPassword = localized("login.placeholder.password")
        static let placeholderName = localized("login.placeholder.name")
        static let logIn = localized("login.log.in")
        static let register = localized("login.register")
    }
    
    struct DashboardScreen {
        static let title = localized("dashboard.title")
        static let buttonAll = localized("dashboard.button.all")
        static let ranking = localized("dashboard.ranking")
        static let recentActivities = localized("dashboard.recent.activities")
    }
    
    struct Error {
        static let title = localized("error.title")
        static let unknownErrorOccurred = localized("error.unknown.error.occurred")
        static let sessionExpired = localized("error.session.expired")
    }
}

private func localized(_ value: String) -> String {
    return NSLocalizedString(value, comment: "")
}
