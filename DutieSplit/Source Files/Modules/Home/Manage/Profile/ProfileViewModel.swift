//
//  ProfileViewModel.swift
//  DutieSplit
//


import RxSwift

internal final class ProfileViewModel: ViewModel {
    internal typealias Dependencies = HasNetworkService
    
    private let dependencies: Dependencies
    
    /// Initialize View model with needed dependencies
    ///
    /// - Parameters:
    ///   - depndencies: Dependencies to use in the class
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}
