//
//  UIScrollView+Keyboard.swift
//  Switchboard
//
//  Created by Jaroslaw Gliwinski on 2016-05-15.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit


protocol KeyboardAvoiding {
    func startKeyboardAvoidance()
    func stopKeyboardAvoidance()
    func ensureVisibilityOf(view: UIView)
}


extension UIView {

    var nearestScrollView: UIScrollView? {
        return superview as? UIScrollView ?? superview?.nearestScrollView
    }

    func tryToAvoidKeyboard() {
        nearestScrollView?.ensureVisibilityOf(self)
    }
}


// Only single UIScrollView in at a time is supported, there are no checks for view hierarchy issues
extension UIScrollView: KeyboardAvoiding {

    func startKeyboardAvoidance() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }

    func stopKeyboardAvoidance() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
    }

    func ensureVisibilityOf(view: UIView) {
        guard let _ = view.superview else {
            return assertionFailure("Cannot try ensuring visibility without knowing the superview")
        }

        let viewForComfortableViewing = view.findComfortableView() ?? view
        let frameInSelfCoordinates = convertRect(
            probablyComfortableBoundsOf(viewForComfortableViewing),
            fromView: viewForComfortableViewing
        )

        let yOffset = frameInSelfCoordinates.maxY - bounds.height + currentKeyboardHeight - distanceFromWindowBottom

        UIView.animateWithDuration(0.3) {
            self.contentOffset = CGPointMake(0, max(yOffset, -self.contentInset.top))
        }
    }

    private func probablyComfortableBoundsOf(view: UIView) -> CGRect {
        if let view = view as? ComfortableViewingAreaView {
            return view.comfortableBounds
        }

        return view.bounds
    }
}


private var currentKeyboardHeightKey: UInt8 = 0


extension UIScrollView {

    // MARK: - Keyboard Notifications

    @objc private func keyboardWillChangeFrame(notification: NSNotification) {
        if let userInfo = notification.userInfo,
            let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue().size {
            currentKeyboardHeight = keyboardSize.height

            contentInset = UIEdgeInsets(
                top: contentInset.top,
                left: 0,
                bottom: keyboardSize.height - distanceFromWindowBottom,
                right: 0
            )

            guard let responderView = UIResponder.currentFirstResponder() as? UIView else {
                return
            }

            ensureVisibilityOf(responderView)
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        contentInset = UIEdgeInsets(top: contentInset.top, left: 0, bottom: 0, right: 0)
    }

    // MARK: - Private Helpers

    private var currentKeyboardHeight: CGFloat {
        get {
            guard let number = objc_getAssociatedObject(self, &currentKeyboardHeightKey) as? NSNumber else {
                return 0.0
            }
            return CGFloat(number)
        }
        set {
            objc_setAssociatedObject(
                self,
                &currentKeyboardHeightKey,
                NSNumber(double: Double(newValue)),
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }

    private var distanceFromWindowBottom: CGFloat {
        guard let windowBounds = UIApplication.sharedApplication().delegate?.window??.bounds else {
            assertionFailure("Calculating distance to window without having a window, shouldn't happen")
            return 0.0 // a probable fallback guess
        }
        let frameRelativeToWindow = convertRect(bounds, toView: nil)

        return windowBounds.maxY - frameRelativeToWindow.maxY
    }
}
