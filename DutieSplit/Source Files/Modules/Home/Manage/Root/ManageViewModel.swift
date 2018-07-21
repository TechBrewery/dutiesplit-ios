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
        case didTapGroupSettings
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
                title: Localizable.ManageScreen.groupSection.uppercased(),
                cells: [
                    ManageMenuCell(icon: #imageLiteral(resourceName: "duties-icon"), title: Localizable.GroupDutiesScreen.title, option: .duties),
                    ManageMenuCell(icon: #imageLiteral(resourceName: "settings-icon"), title: Localizable.GroupSettingsScreen.title, option: .groupSettings)
                ]
            ),
            StaticSection<ManageMenuCellType>(
                title: Localizable.ManageScreen.settingsSection.uppercased(),
                cells: [
                    ManageMenuCell(icon: #imageLiteral(resourceName: "profile-icon"), title: Localizable.ProfileScreen.title, option: .profile),
                    ManageMenuCell(icon: #imageLiteral(resourceName: "switch-group-icon"), title: Localizable.SwitchGroupScreen.title, option: .switchGroup),
                    ManageMenuCell(icon: #imageLiteral(resourceName: "logout-icon"), title: Localizable.ManageScreen.logout, option: .logout)
                ]
            )
        ]
    )
    
    func didTapCell(_ option: ManageMenuOption) {
        switch option {
        case .duties:
            eventTriggered?(.didTapDuties)
        case .groupSettings:
            eventTriggered?(.didTapGroupSettings)
        case .profile:
            eventTriggered?(.didTapProfile)
        case .switchGroup:
            eventTriggered?(.didTapSwitchGroup)
        case .logout:
            dependencies.authenticationService.removeToken()
            eventTriggered?(.didTapLogout)
        }
    }
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        
    }
}

