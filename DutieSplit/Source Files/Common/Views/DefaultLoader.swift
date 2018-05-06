//
//  DefaultLoader.swift
//  DutieSplit
//


import UIKit

internal class DefaultLoader: Loader {
    
    private let baseView: UIView
    
    private var contentView: UIView?
    
    /// Initialize the loader inside given view
    ///
    /// - Parameter baseView: View to show loader on
    init(inside baseView: UIView) {
        self.baseView = baseView
    }
    
    /// - SeeAlso: Loader.isSpinning
    var isSpinning: Bool {
        return contentView != nil
    }
    
    /// - SeeAlso: Loader.toggle()
    func toggle(_ show: Bool) {
        guard show else {
            contentView?.removeFromSuperview()
            baseView.isUserInteractionEnabled = true
            return
        }
        contentView = makeLoaderView()
        guard let contentView = contentView else { return }
        baseView.addSubview(contentView)
        baseView.bringSubview(toFront: contentView)
        baseView.isUserInteractionEnabled = false
    }
    
    private func makeLoaderView(dimmedBackground: Bool = true, withMessage message: String? = nil) -> UIView {
        let background = UIView().layoutable()
        background.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        background.layer.cornerRadius = 15
        let loader = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge).layoutable()
        loader.startAnimating()
        
        background.addSubview(loader)
        baseView.addSubview(background)
        
        background.constraintCenterToSuperview()
        loader.constraintCenterToSuperview()
        NSLayoutConstraint.activate([
            background.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 0.4),
            background.heightAnchor.constraint(equalTo: background.widthAnchor)
        ])
        return background
    }
}
