//
//  ViewModel.swift
//  DutieSplit
//


import RxSwift
import RxCocoa

/// Base View Model to remove boilerplate for custom View Models
internal class ViewModel {
    
    /// Dispose bag of the View Model
    let disposeBag = DisposeBag()
    
    /// Indicates if there is ongoing loading
    let isLoading: Variable<Bool> = Variable(false)
    
    /// Called when error has occurred
    let errorOccurred: PublishSubject<String> = PublishSubject()
    
    /// Called when view controller called `viewDidLoad`
    let viewDidLoad: PublishSubject<()> = PublishSubject()
    
    /// Called when view controller called `viewWillAppear`
    let viewWillAppear: PublishSubject<()> = PublishSubject()
    
    /// Called when view controller called `viewDidAppear`
    let viewDidAppear: PublishSubject<()> = PublishSubject()
    
    /// Called when view controller called `viewWillDisappear`
    let viewWillDisappear: PublishSubject<()> = PublishSubject()
}
