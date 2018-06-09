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
    ///
    /// - userLoggedOut: send when user logged out
    /// - didTapDuties, didTapSettings, didTapProfile, didTapSwitchGroup: send when user tapped one of cell
    internal enum Event {
        case userLoggedOut
        case didTapDuties
        case didTapSettings
        case didTapProfile
        case didTapSwitchGroup
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
    
    let cellsData: StaticSectionedMenu = StaticSectionedMenu(
        sections: [
            StaticSection<ManageMenuCellType>(
                title: Localizable.ManageScreen.group.uppercased(),
                cells: [
                    ManageMenuCell(icon: #imageLiteral(resourceName: "duties-icon"), title: "Duties"),
                    ManageMenuCell(icon: #imageLiteral(resourceName: "settings-icon"), title: "Settings")
                ]
            ),
            StaticSection<ManageMenuCellType>(
                title: Localizable.ManageScreen.settings.uppercased(),
                cells: [
                    ManageMenuCell(icon: #imageLiteral(resourceName: "profile-icon"), title: "Profile"),
                    ManageMenuCell(icon: #imageLiteral(resourceName: "switch-group-icon"), title: "Switch group"),
                    ManageMenuCell(icon: #imageLiteral(resourceName: "logout-icon"), title: "Logout")
                ]
            )
        ]
    )
    
    /// Indicates when duties button was tapped
    let dutiesButtonTap = PublishSubject<Void>()
    
    /// Indicates when settings button was tapped
    let settingsButtonTap = PublishSubject<Void>()
    
    /// Indicates when profile button was tapped
    let profileButtonTap = PublishSubject<Void>()
    
    /// Indicates when switch group button was tapped
    let switchGroupButtonTap = PublishSubject<Void>()
    
    /// Indicates when logout button was tapped
    let logoutButtonTap = PublishSubject<Void>()
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        dutiesButtonTap
            .subscribe(onNext: { [unowned self] _ in
                self.eventTriggered?(.didTapDuties)
            })
            .disposed(by: disposeBag)
        
        settingsButtonTap
            .subscribe(onNext: { [unowned self] _ in
                self.eventTriggered?(.didTapSettings)
            })
            .disposed(by: disposeBag)
        
        profileButtonTap
            .subscribe(onNext: { [unowned self] _ in
                self.eventTriggered?(.didTapProfile)
            })
            .disposed(by: disposeBag)
        
        switchGroupButtonTap
            .subscribe(onNext: { [unowned self] _ in
                self.eventTriggered?(.didTapSwitchGroup)
            })
            .disposed(by: disposeBag)
        
        logoutButtonTap
            .subscribe(onNext: { [unowned self] _ in
                self.dependencies.authenticationService.removeToken()
                self.eventTriggered?(.userLoggedOut)
            })
            .disposed(by: disposeBag)
    }
}

