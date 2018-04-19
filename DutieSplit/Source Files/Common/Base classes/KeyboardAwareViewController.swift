//
//  KeyboardAwareViewController.swift
//  DutieSplit
//


import UIKit

/// Simple View controller class with helper methods for keyboard management
internal class KeyboardAwareViewController: UIViewController {
    
    /// Closure triggered when keyboard will show up
    var keyboardWillShow: (_ height: CGFloat, _ animationDuration: TimeInterval) -> () = { _, _ in }
    
    /// Closure triggered when keyboard will hide
    var keyboardWillHide: (_ animationDuration: TimeInterval) -> () = { _ in }
    
    /// - SeeAlso: UIViewController.viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowSelector), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideSelector), name: .UIKeyboardWillHide, object: nil)
    }

    @objc private func keyboardWillShowSelector(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)
        let keyboardAnimation: TimeInterval? = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        guard let keyboardRect = keyboardFrame?.cgRectValue, let keyboardAnimationDuration = keyboardAnimation else { return }
        let convertedKeyboardRect = view.convert(keyboardRect, from: nil)
        let height = convertedKeyboardRect.size.height
        keyboardWillShow(height, keyboardAnimationDuration)
    }
    
    @objc private func keyboardWillHideSelector(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardAnimation: TimeInterval? = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        guard let keyboardAnimationDuration = keyboardAnimation else { return }
        keyboardWillHide(keyboardAnimationDuration)
    }
}
