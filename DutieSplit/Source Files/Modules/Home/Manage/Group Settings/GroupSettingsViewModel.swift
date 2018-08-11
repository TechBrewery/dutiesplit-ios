//
//  GroupSettingsViewModel.swift
//  DutieSplit
//


import RxSwift

internal final class GroupSettingsViewModel: ViewModel  {
    internal typealias Dependencies = HasNetworkService
    
    private let dependencies: Dependencies

    /// Indicates name of the currently selected group.
    let groupName = Variable<String>("")

    /// Indicating if change name button was tapped.
    let editNameTapped = PublishSubject<Void>()

    /// Indicating moment of showing the edit name alert with it's prefilled textfield.
    var showEditNameAlert: ((_ prefilledName: String) -> ())?

    /// Initialize View model with needed dependencies.
    ///
    /// - Parameters:
    ///   - depndencies: Dependencies to use in the class.
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()

        groupName.value = "White House"
        editNameTapped
            .subscribe(onNext: { [unowned self] in
                self.showEditNameAlert?(self.groupName.value)
            })
            .disposed(by: disposeBag)
    }

    /// Changes the group name.
    ///
    /// - Parameter groupName: Group name to be set.
    func changeGroupName(to groupName: String?) {
        guard let groupName = groupName, !groupName.isEmpty else {
            errorOccurred.onNext(Localizable.GroupSettingsScreen.Error.emptyGroupName)
            return
        }
        // TODO: Call proper API endpoint instead of chaning value
        self.groupName.value = groupName
    }

    /// Adds user to the group.
    ///
    /// - Parameter email: Email of the user that should be added.
    func addToGroup(email: String?) {
        guard let email = email, !email.isEmpty else {
            errorOccurred.onNext(Localizable.GroupSettingsScreen.Error.emptyEmail)
            return
        }
        // TODO: Call proper API endpoint
    }
}
