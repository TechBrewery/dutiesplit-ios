//
//  ManageViewModel.swift
//  DutieSplit
//


import RxSwift

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
    
    /// Indicates when logout button was tapped
    let logoutButtonTap = PublishSubject<Void>()
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        logoutButtonTap
            .subscribe(onNext: { [unowned self] _ in
                self.dependencies.authenticationService.removeToken()
                self.eventTriggered?(.userLoggedOut)
            })
            .disposed(by: disposeBag)
    }
}

