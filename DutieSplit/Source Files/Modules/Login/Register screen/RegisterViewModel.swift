//
//  RegisterViewModel.swift
//  DutieSplit
//


import RxSwift

internal final class RegisterViewModel: ViewModel {
    internal typealias Dependencies = HasUserController
    
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

    private let dependencies: Dependencies

    private lazy var isNameValid = nameText.asObservable().map { !$0.isEmpty }

    private lazy var isEmailValid = emailText.asObservable().map { EmailValidator.validate($0) }

    private lazy var isPasswordValid = passwordText.asObservable().map { PasswordValidator.validate($0) }

    /// Initialize View model with needed dependencies
    ///
    /// - Parameters:
    ///   - depndencies: Dependencies to use in the class
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()

        registerButtonTap
            .do(onNext: { [unowned self] in self.isLoading.value = true })
            .withLatestFrom(Observable.combineLatest(
                nameText.asObservable(),
                emailText.asObservable(),
                passwordText.asObservable()
            ))
            .flatMapLatest { [unowned self] in self.dependencies.userController.register(name: $0, email: $1, password: $2) }
            .do(onNext: { [unowned self] _ in self.isLoading.value = false })
            .observeOn(MainScheduler.instance)
            .subscribe( onNext: { [unowned self] error in
                guard let error = error else { return }
                self.errorOccurred.onNext(error.description)
            })
            .disposed(by: disposeBag)
    }
}
