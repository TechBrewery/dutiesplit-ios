//
//  SwitchGroupViewModel.swift
//  DutieSplit
//


import RxSwift

internal final class SwitchGroupViewModel: ViewModel, BindingsSetupable {
    internal typealias Dependencies = HasNetworkService
    internal typealias EventCallback = (Event) -> ()
    
    /// Enum describing events that can be triggered
    ///
    /// - didSelectGroup: send when user selected group
    internal enum Event {
        case didSelectGroup
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
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        
    }
}
