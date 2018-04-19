//
//  ViewController.swift
//  DutieSplit
//


import UIKit
import RxSwift

/// Base class for view controllers with given custom `View` and `ViewModel`
internal class ViewController<View: UIView, ControllerViewModel: ViewModel>: TypedViewController<View>, AlertPresentable {
    
    /// DisposeBag of the controller
    let disposeBag = DisposeBag()
    
    /// View Model of the controller
    let viewModel: ControllerViewModel
    
    /// Initializes view controller with given View Model
    ///
    /// - Parameter viewModel: View Model to use with controller
    init(viewModel: ControllerViewModel, viewMaker: @escaping @autoclosure () -> View) {
        self.viewModel = viewModel
        super.init(viewMaker: viewMaker())
        setupBaseBindings()
        (self as? BindingsSetupable)?.setupBindings()
    }
    
    /// - SeeAlso: UIViewController.viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad.onNext(())
    }
    
    /// - SeeAlso: UIViewController.viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear.onNext(())
    }
    
    /// - SeeAlso: UIViewController.viewDidAppear()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear.onNext(())
    }
    
    /// - SeeAlso: UIViewController.viewWillDisappear()
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisappear.onNext(())
    }
    
    /// Set ups base bindings usefull for all view controllers
    /// Override only if wanna change default base bindings
    internal func setupBaseBindings() {
        viewModel
            .isLoading
            .asDriver()
            .skip(1)
            .drive(onNext: { isLoading in
                UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
            })
            .disposed(by: disposeBag)
        
        viewModel
            .errorOccurred
            .asDriver(onErrorJustReturn: Localizable.Error.unknownErrorOccurred)
            .drive(onNext: { [unowned self] errorMessage in
                self.showAlert(withMessage: errorMessage, title: Localizable.Error.title)
            })
            .disposed(by: disposeBag)
    }
}
