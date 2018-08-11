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
    
    struct AddActivity {
        static let title = localized("add.activity.title")
    }
    
    struct ManageScreen {
        static let title = localized("manage.title")
        static let groupSection = localized("manage.section.group")
        static let settingsSection = localized("manage.section.settings")
        static let logout = localized("manage.logout")
    }
    
    struct GroupDutiesScreen {
        static let title = localized("group.duties.title")
    }
    
    struct GroupSettingsScreen {
        static let title = localized("group.settings.title")
        static let groupMembers = localized("group.settings.group.members")
        static let addMember = localized("group.settings.add.member")
        static let editName = localized("group.settings.edit.name")
        static let groupName = localized("group.settings.group.name")
        static let addMemberAlertMessage = localized("group.settings.add.member.alert.message")
        static let emailPlaceholder = localized("group.settings.email.placeholder")

        struct Error {
            static let emptyGroupName = localized("group.settings.error.group.name.empty")
            static let emptyEmail = localized("group.settings.error.email.empty")
        }
    }
    
    struct ProfileScreen {
        static let title = localized("profile.title")
    }
    
    struct SwitchGroupScreen {
        static let title = localized("switch.group.title")
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
