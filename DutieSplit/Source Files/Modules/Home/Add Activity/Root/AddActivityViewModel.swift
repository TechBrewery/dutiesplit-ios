//
//  AddActivityViewModel.swift
//  DutieSplit
//


import RxSwift

internal final class AddActivityViewModel: ViewModel, BindingsSetupable {
    internal typealias Dependencies = HasNetworkService
    internal typealias EventCallback = (Event) -> ()
    
    /// Enum describing events that can be triggered
    ///
    /// - didTapCancel: send when user canceled adding activity
    internal enum Event {
        case didTapCancel
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
    
    /// Indicates when cancel button was tapped
    let cancelButtonTap = PublishSubject<Void>()
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        cancelButtonTap
            .subscribe(onNext: { [unowned self] _ in
                self.eventTriggered?(.didTapCancel)
            })
            .disposed(by: disposeBag)
    }
}

