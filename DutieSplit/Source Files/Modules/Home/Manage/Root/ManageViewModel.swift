//
//  ManageViewModel.swift
//  DutieSplit
//


import RxSwift
import UIKit.UIImage

internal final class ManageViewModel: ViewModel, BindingsSetupable {
    internal typealias Dependencies = HasNetworkService & HasAuthenticationService
    internal typealias EventCallback = (Event) -> ()
    
    /// Enum describing events that can be triggered
    internal enum Event {
        case didTapDuties
        case didTapSettings
        case didTapProfile
        case didTapSwitchGroup
        case didTapLogout
    }
    
    /// Callback with triggered event
    var eventTriggered: EventCallback?
    
    private let dependencies: Dependencies
    
    /// Initialize View model with needed dependencies
    ///
    /// - Parameters:
    ///   - depndencies: Dependencies to use in the class
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    /// Data for feeding the cells on the view
    let cellsData: StaticSectionedMenu = StaticSectionedMenu(
        sections: [
            StaticSection<ManageMenuCellType>(
                title: Localizable.ManageScreen.group.uppercased(),
                cells: [
                    ManageMenuCell(icon: #imageLiteral(resourceName: "duties-icon"), title: "Duties", option: .duties),
                    ManageMenuCell(icon: #imageLiteral(resourceName: "settings-icon"), title: "Settings", option: .settings)
                ]
            ),
            StaticSection<ManageMenuCellType>(
                title: Localizable.ManageScreen.settings.uppercased(),
                cells: [
                    ManageMenuCell(icon: #imageLiteral(resourceName: "profile-icon"), title: "Profile", option: .profile),
                    ManageMenuCell(icon: #imageLiteral(resourceName: "switch-group-icon"), title: "Switch group", option: .switchGroup),
                    ManageMenuCell(icon: #imageLiteral(resourceName: "logout-icon"), title: "Logout", option: .logout)
                ]
            )
        ]
    )
    
    func didTapCell(_ option: ManageMenuOption) {
        switch option {
        case .duties:
            eventTriggered?(.didTapDuties)
        case .settings:
            eventTriggered?(.didTapSettings)
        case .profile:
            eventTriggered?(.didTapProfile)
        case .switchGroup:
            eventTriggered?(.didTapSwitchGroup)
        case .logout:
            dependencies.authenticationService.removeToken()
            eventTriggered?(.didTapLogout)
        }
    }
    
    /// Indicates name of the currently selected group
    let groupName = Variable<String>("")
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        groupName.value = "Group name"
    }
}

