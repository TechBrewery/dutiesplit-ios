//
//  HomeTabBarController.swift
//  DutieSplit
//


import UIKit
import RxSwift

/// Customized main tab bar controller
internal final class HomeTabBarController: UITabBarController, UITabBarControllerDelegate, ViewSetupable, BindingsSetupable {
    internal typealias EventCallback = (Event) -> ()
    
    private let disposeBag = DisposeBag()
    
    /// Enum describing events that can be triggered
    ///
    /// - didTapAddActivity: send when user tapped the center add activity button
    internal enum Event {
        case didTapAddActivity
    }
    
    /// Callback with triggered event
    var eventTriggered: EventCallback?
    
    private lazy var centerButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(#imageLiteral(resourceName: "add-icon"), for: .normal)
        return button.layoutable()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupViews()
        setupBindings()
    }

    /// - SeeAlso: ViewSetupable
    func setupViewHierarchy() {
        view.addSubview(centerButton)
    }
    
    /// - SeeAlso: ViewSetupable
    func setupConstraints() {
        centerButton.constraintToConstant(.init(width: 58, height: 58))
        NSLayoutConstraint.activate([
            centerButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            centerButton.centerYAnchor.constraint(equalTo: tabBar.centerYAnchor, constant: -8)
        ])
    }
    
    /// - SeeAlso: ViewSetupable
    func setupProperties() {
        tabBar.tintColor = .dsRed
        tabBar.unselectedItemTintColor = .dsGray
    }
    
    /// - SeeAlso: BindingsSetupable
    func setupBindings() {
        centerButton.rx.tap
            .subscribe(onNext: { [unowned self] in self.eventTriggered?(.didTapAddActivity) })
            .disposed(by: disposeBag)
    }
    
    /// - SeeAlso: UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let viewControllers = viewControllers, viewController != viewControllers[1] else { return false }
        return true
    }
}
