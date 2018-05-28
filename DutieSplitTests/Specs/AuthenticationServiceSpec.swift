//
//  AuthenticationServiceSpec.swift
//  DutieSplitTests
//


@testable import DutieSplit
import Quick
import Nimble

internal final class AuthenticationServiceSpec: QuickSpec {
    
    var secureStorageMock: MockSecureStorageService!
    var sut: AuthenticationService!
    
    override func spec() {
        
        beforeEach {
            self.secureStorageMock = MockSecureStorageService()
            self.sut = DefaultAuthenticationService(secureStorageService: self.secureStorageMock)
        }
        
        it("should return nil when there's no token set") {
            expect(self.sut.token).to(beNil())
        }
        
        context("when token was saved before") {
            
            beforeEach {
                self.sut.save(token: "fixture.token")
            }
            
            it("should save the token savef") {
                expect(self.secureStorageMock.savedToken).to(equal("fixture.token"))
            }
            
            it("should retrieve the token") {
                expect(self.secureStorageMock.savedToken).to(equal("fixture.token"))
                expect(self.sut.token).to(equal("fixture.token"))
            }
            
            context("and removed later") {
                
                beforeEach {
                    self.sut.removeToken()
                }
                
                it("should has the token removed") {
                    expect(self.secureStorageMock.savedToken).to(beNil())
                }
                
                it("should return nil when trying to get the token") {
                    expect(self.secureStorageMock.savedToken).to(beNil())
                    expect(self.sut.token).to(beNil())
                }
            }
        }
    }
}
