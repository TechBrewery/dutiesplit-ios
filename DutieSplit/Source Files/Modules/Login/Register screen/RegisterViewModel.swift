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
    /// - userRegistered: send when user sucessfully created new account
    internal enum Event {
        case userRegistered
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
    lazy var registerButtonEnabled = Observable
        .combineLatest(isNameValid, isEmailValid, isPasswordValid)
        .map { $0.0 && $0.1 && $0.2 }
    
    private lazy var isNameValid = nameText.asObservable().map { !$0.isEmpty }
    
    private lazy var isEmailValid = emailText.asObservable().map { EmailValidator.validate($0) }
    
    private lazy var isPasswordValid = passwordText.asObservable().map { PasswordValidator.validate($0) }
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        registerButtonTap
            .do(onNext: { [unowned self] in self.isLoading.value = true })
            .withLatestFrom(Observable.combineLatest(
                nameText.asObservable(),
                emailText.asObservable(),
                passwordText.asObservable()
            ))
            .map { RegisterRequest(name: $0, email: $1, password: $2) }
            .flatMapLatest { [unowned self] in self.dependencies.networkService.perform(request: $0) }
            .do(onNext: { [unowned self] _ in self.isLoading.value = false })
            .observeOn(MainScheduler.instance)
            .subscribe( onNext: { [unowned self] response in
                switch response {
                case .success(let response):
                    self.dependencies.authenticationService.save(token: response.token)
                    self.eventTriggered?(.userRegistered)
                case .failure(let error):
                    self.errorOccurred.onNext(error.description)
                }
            })
            .disposed(by: disposeBag)
    }
}
