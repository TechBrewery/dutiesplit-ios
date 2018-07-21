//
//  GroupSettingsViewModel.swift
//  DutieSplit
//


import RxSwift

internal final class GroupSettingsViewModel: ViewModel, BindingsSetupable {
    internal typealias Dependencies = HasNetworkService
    
    private let dependencies: Dependencies

    /// Indicates name of the currently selected group
    let groupName = Variable<String>("")

    /// Indicating if change name button was tapped
    let editNameTapped = PublishSubject<Void>()
    
    /// Initialize View model with needed dependencies
    ///
    /// - Parameters:
    ///   - depndencies: Dependencies to use in the class
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        groupName.value = "White House"
        editNameTapped
            .subscribe(onNext: {
                print("Edit name tap")
            })
            .disposed(by: disposeBag)
    }
}
