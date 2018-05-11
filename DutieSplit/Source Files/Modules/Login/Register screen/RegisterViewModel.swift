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
    
    /// Variable for binding name text
    let nameText = Variable<String>("")
    
    /// Variable for binding email text
    let emailText = Variable<String>("")
    
    /// Variable for binding password text
    let passwordText = Variable<String>("")
    
    /// Observable for binding register button `isEnabled` state
    lazy var registerButtonEnabled = Observable.combineLatest(isNameValid, isEmailValid, isPasswordValid).map { $0.0 && $0.1 && $0.2 }
    
    private lazy var isNameValid = emailText.asObservable().map { !$0.isEmpty }
    
    private lazy var isEmailValid = emailText.asObservable().map { EmailValidator.validate($0) }
    
    private lazy var isPasswordValid = passwordText.asObservable().map { PasswordValidator.validate($0) }
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        registerButtonTap
            .subscribe(onNext: { [unowned self] _ in
                self.eventTriggered?(.userSignedIn)
            })
            .disposed(by: disposeBag)
    }
}
