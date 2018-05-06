//
//  RegisterViewModel.swift
//  DutieSplit
//


import RxSwift

internal final class RegisterViewModel: ViewModel, BindingsSetupable {
    internal typealias Dependencies = HasNetworkService & HasAuthenticationService
    internal typealias EventCallback = (Event) -> ()
    
    /// Enum describing events that can be triggered
    ///
    /// - userSignedIn: send when user sucessfully created new account
    internal enum Event {
        case userSignedIn
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
    
    /// Indicates when register button was tapped
    let registerButtonTap = PublishSubject<Void>()
    
    /// Variable for binding email text
    let emailText = Variable<String>("")
    
    /// Variable for binding password text
    let passwordText = Variable<String>("")
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        registerButtonTap
            .subscribe(onNext: { [unowned self] _ in
                self.eventTriggered?(.userSignedIn)
            })
            .disposed(by: disposeBag)
    }
}
