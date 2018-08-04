//
//  GroupDutiesViewModel.swift
//  DutieSplit
//


import RxSwift

internal final class GroupDutiesViewModel: ViewModel {
    internal typealias Dependencies = HasNetworkService

    private let dependencies: Dependencies

    /// Indicates name of the currently selected group
    let groupName = Variable<String>("")
    
    /// Initialize View model with needed dependencies
    ///
    /// - Parameters:
    ///   - depndencies: Dependencies to use in the class
    init(dependencies: Dependencies) {
        self.dependencies = dependencies

        groupName.value = "White House"
    }
}
