//
//  DashboardViewModel.swift
//  DutieSplit
//


import RxSwift

internal final class DashboardViewModel: ViewModel, BindingsSetupable {
    internal typealias Dependencies = HasNetworkService
    internal typealias EventCallback = (Event) -> ()
    
    /// Enum describing events that can be triggered
    ///
    /// - didTapDetailedRanking: send when user tapped detailed ranking button
    /// - didTapAllActivities: send when user tapped all activities button
    internal enum Event {
        case didTapDetailedRanking
        case didTapAllActivities
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

