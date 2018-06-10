//
//  LoginViewModelSpec.swift
//  DutieSplitTests
//


@testable import DutieSplit
import Quick
import Nimble
import RxSwift
import RxCocoa

internal final class LoginViewModelSpec: QuickSpec {
    
    let disposeBag = DisposeBag()
    var dependencies: MockApplicationDependencies!
    var viewModel: LoginViewModel!
    
    var userLoggedInCalled: Bool!
    var didTapRegisterCalled: Bool!

    override func spec() {
        
        beforeEach {
            self.userLoggedInCalled = false
            self.didTapRegisterCalled = false
            
            self.dependencies = MockApplicationDependencies()
            self.viewModel = LoginViewModel(dependencies: self.dependencies)
            self.viewModel.eventTriggered = { [unowned self] event in
                switch event {
                case .userLoggedIn:
                    self.userLoggedInCalled = true
                case .didTapRegister:
                    self.didTapRegisterCalled = true
                }
            }
            
            MockNetworkService.mockedResponse = (
                json: """
                {
                    "name": "fixture_name",
                    "email": "fixture@email.com",
                    "token" : "fixture_token"
                }
                """,
                statusCode: 200,
                error: nil
            )
        }
    
        describe("when tapping register button") {
            
            it("should not change value before tapping the button") {
                expect(self.didTapRegisterCalled).to(equal(false))
            }
            
            it("should tell flow controller that user tapped sign up button") {
                self.viewModel.registerButtonTap.onNext(())
                expect(self.didTapRegisterCalled).to(equal(true))
            }
        }
        
        describe("when typing inside text fields") {
            
            var emailInput: PublishSubject<String>!
            var passwordInput: PublishSubject<String>!
            
            beforeEach {
                emailInput = PublishSubject<String>()
                passwordInput = PublishSubject<String>()
                emailInput.bind(to: self.viewModel.emailText).disposed(by: self.disposeBag)
                passwordInput.bind(to: self.viewModel.passwordText).disposed(by: self.disposeBag)
            }
            
            it("login button should be disabled when input fields aren't correct") {
                let expectedResults = [false, false, false, false, false, true, false]
                var counter = 0
                self.viewModel.loginButtonEnabled.subscribe(onNext: { event in
                    expect(event) == expectedResults[counter]
                    counter += 1
                }).disposed(by: self.disposeBag)

                emailInput.onNext("abc")
                emailInput.onNext("abc@abc")
                emailInput.onNext("abc@abc.com")
                emailInput.onNext("abc@abc.com")
                passwordInput.onNext("abc")
                emailInput.onNext("")
            }
            
            describe("and trying to login") {
                
                beforeEach {
                    emailInput.onNext("abc@abc.abc")
                    passwordInput.onNext("12345678")
                }
                
                context("with correct credentials") {
                    
                    beforeEach {
                        self.viewModel.loginButtonTap.onNext(())
                    }
                    
                    it("should save passed token") {
                        expect(self.dependencies.authenticationService.token).toEventually(equal("fixture_token"))
                    }
                    
                    it("should tell flow controller that user logged in") {
                        expect(self.userLoggedInCalled).toEventually(equal(true))
                    }
                }
                
                context("with wrong credentials") {
                    
                    beforeEach {
                        MockNetworkService.mockedResponse = (
                            json: """
                            {
                                "status": {
                                    "message": "fixture.error"
                                }
                            }
                            """,
                            statusCode: 400,
                            error: nil
                        )
                        self.viewModel.loginButtonTap.onNext(())
                    }
                    
                    it("should not have token saved") {
                        expect(self.dependencies.authenticationService.token).toEventually(beNil())
                    }
                    
                    it("should show error message") {
                        self.viewModel.errorOccurred.subscribe(onNext: { message in
                            expect(message).toEventually(equal("fixture.error"))
                        }).disposed(by: self.disposeBag)
                        self.viewModel.loginButtonTap.onNext(())
                    }
                }
            }
        }
    }
}
