//
//  LoginViewModel.swift
//  DutieSplit
//


internal final class LoginViewModel: ViewModel, BindingsSetupable {
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
    
    /// Initialize View model with needed dependencies
    ///
    /// - Parameters:
    ///   - depndencies: Dependencies to use in the class
//    init() {
//
//    }
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        print("LoginViewModel setup called")
    }
}
