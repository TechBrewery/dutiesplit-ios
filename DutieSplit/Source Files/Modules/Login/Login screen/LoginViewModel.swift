//
//  LoginViewModel.swift
//  DutieSplit
//


import RxSwift

internal final class LoginViewModel: ViewModel {
    internal typealias Dependencies = HasUserController
    internal typealias EventCallback = (Event) -> ()
    
    /// Enum describing events that can be triggered
    ///
    /// - didTapRegister: send when user tapped register button
    internal enum Event {
        case didTapRegister
    }
    
    /// Callback with triggered event
    var eventTriggered: EventCallback?

    /// Indicates when login button was tapped
    let loginButtonTap = PublishSubject<Void>()

    /// Indicates when register button was tapped
    let registerButtonTap = PublishSubject<Void>()

    /// Variable for binding email text
    let emailText = Variable<String>("")

    /// Variable for binding password text
    let passwordText = Variable<String>("")

    /// Observable for binding login button `isEnabled` state
    lazy var loginButtonEnabled = Observable.combineLatest(isEmailValid, isPasswordValid).map { $0.0 && $0.1 }

    private let dependencies: Dependencies

    private lazy var isEmailValid = emailText.asObservable().map { EmailValidator.validate($0) }

    private lazy var isPasswordValid = passwordText.asObservable().map { PasswordValidator.validate($0) }    
    
    /// Initialize View model with needed dependencies
    ///
    /// - Parameters:
    ///   - depndencies: Dependencies to use in the class
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()

        loginButtonTap
            .do(onNext: { [unowned self] in self.isLoading.value = true })
            .withLatestFrom(Observable.combineLatest(emailText.asObservable(), passwordText.asObservable()))
            .flatMap { [unowned self] in self.dependencies.userController.login(email: $0, password: $1) }
            .do(onNext: { [unowned self] _ in self.isLoading.value = false })
            .observeOn(MainScheduler.instance)
            .subscribe( onNext: { [unowned self] error in
                guard let error = error else { return }
                self.errorOccurred.onNext(error.description)
            })
            .disposed(by: disposeBag)

        registerButtonTap
            .subscribe(onNext: { [unowned self] _ in
                self.eventTriggered?(.didTapRegister)
            })
            .disposed(by: disposeBag)

        viewDidAppear
            .subscribe(onNext: { [unowned self] in
                #if ENV_DEVELOPMENT
                    self.emailText.value = "michal+1@kwiecien.co"
                    self.passwordText.value = "password"
                #endif
            })
            .disposed(by: disposeBag)
    }
}
