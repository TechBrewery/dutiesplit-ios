//
//  RegisterViewModelSpec.swift
//  DutieSplitTests
//


@testable import DutieSplit
import Quick
import Nimble
import RxSwift
import RxCocoa

internal final class RegisterViewModelSpec: QuickSpec {
    
    let disposeBag = DisposeBag()
    var dependencies: MockApplicationDependencies!
    var viewModel: RegisterViewModel!
    
    override func spec() {
        
        beforeEach {
            self.dependencies = MockApplicationDependencies()
            self.viewModel = RegisterViewModel(dependencies: self.dependencies)
            
            MockNetworSession.mockedResponse = (
                json: MockNetworSession.jsonFrom(filename: "LoginSuccess"),
                statusCode: 200,
                error: nil
            )
        }
        
        describe("when typing inside text fields") {
            
            var nameInput: PublishSubject<String>!
            var emailInput: PublishSubject<String>!
            var passwordInput: PublishSubject<String>!
            
            beforeEach {
                nameInput = PublishSubject<String>()
                emailInput = PublishSubject<String>()
                passwordInput = PublishSubject<String>()
                emailInput.bind(to: self.viewModel.emailText).disposed(by: self.disposeBag)
                passwordInput.bind(to: self.viewModel.passwordText).disposed(by: self.disposeBag)
            }
            
            it("login button should be disabled when input fields aren't correct") {
                let expectedResults = [false, false, false, false, false, true, false]
                var counter = 0
                self.viewModel.registerButtonEnabled.subscribe(onNext: { event in
                    print(event)
                    expect(event) == expectedResults[counter]
                    counter += 1
                }).disposed(by: self.disposeBag)
                
                nameInput.onNext("name")
                emailInput.onNext("abc")
                emailInput.onNext("abc@abc")
                emailInput.onNext("abc@abc.com")
                passwordInput.onNext("abc")
                nameInput.onNext("")
            }
            
            describe("and trying to login") {
                
                beforeEach {
                    nameInput.onNext("name")
                    emailInput.onNext("abc@abc.abc")
                    passwordInput.onNext("12345678")
                }
                
                context("with correct credentials") {
                    
                    beforeEach {
                        self.viewModel.registerButtonTap.onNext(())
                    }
                    
                    it("should save passed token") {
                        expect(self.dependencies.authenticationService.token.value).toEventually(equal("fixture_token"))
                    }
                }
                
                context("with wrong credentials") {
                    
                    beforeEach {
                        MockNetworSession.mockedResponse = (
                            json: MockNetworSession.jsonFrom(filename: "LoginFailure"),
                            statusCode: 400,
                            error: nil
                        )
                        self.viewModel.registerButtonTap.onNext(())
                    }
                    
                    it("should not have token saved") {
                        expect(self.dependencies.authenticationService.token.value).toEventually(beNil())
                    }
                    
                    it("should show error message") {
                        self.viewModel.errorOccurred.subscribe(onNext: { message in
                            expect(message).toEventually(equal("fixture.error"))
                        }).disposed(by: self.disposeBag)
                        self.viewModel.registerButtonTap.onNext(())
                    }
                }
            }
        }
    }
}

