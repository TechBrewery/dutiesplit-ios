//
//  LoginViewModel.swift
//  DutieSplit
//


import RxSwift

internal final class LoginViewModel: ViewModel, BindingsSetupable {
    internal typealias Dependencies = HasNetworkService & HasAuthenticationService
    internal typealias EventCallback = (Event) -> ()
    
    /// Enum describing events that can be triggered
    ///
    /// - userLoggedIn: send when user sucessfully logged in
    /// - didTapRegister: send when user tapped register button
    internal enum Event {
        case userLoggedIn
        case didTapRegister
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
    
    /// Indicates when login button was tapped
    let loginButtonTap = PublishSubject<Void>()
    
    /// Indicates when register button was tapped
    let registerButtonTap = PublishSubject<Void>()
    
    /// Variable for binding email text
    let emailText = Variable<String>("")
    
    /// Variable for binding password text
    let passwordText = Variable<String>("")
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        loginButtonTap
            .do(onNext: { [unowned self] in self.isLoading.value = true })
            .withLatestFrom(Observable.combineLatest(emailText.asObservable(), passwordText.asObservable()))
            .map { LoginRequest(email: $0, password: $1) }
            .flatMapLatest { [unowned self] in self.dependencies.networkService.perform(request: $0) }
            .do(onNext: { [unowned self] _ in self.isLoading.value = false })
            .subscribe( onNext: { [unowned self] response in
                switch response {
                case .success(let response):
                    self.dependencies.authenticationService.save(token: response.token)
                    self.eventTriggered?(.userLoggedIn)
                case .failure(let error):
                    self.errorOccurred.onNext(error.description)
                }
            })
            .disposed(by: disposeBag)
        
        registerButtonTap
            .subscribe(onNext: { [unowned self] _ in
                self.eventTriggered?(.didTapRegister)
            })
            .disposed(by: disposeBag)
    }
}
