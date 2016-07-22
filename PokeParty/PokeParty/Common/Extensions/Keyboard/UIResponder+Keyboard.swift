//
//  UIResponder+Keyboard.swift
//  Switchboard
//
//  Created by Jaroslaw Gliwinski on 2016-05-15.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit


extension UIResponder {
    private weak static var resultFirstResponder: UIResponder? = nil

    public class func currentFirstResponder() -> UIResponder? {
        UIResponder.resultFirstResponder = nil
        UIApplication.sharedApplication().sendAction(#selector(findFirstResponder), to: nil, from: nil, forEvent: nil)
        return UIResponder.resultFirstResponder
    }

    func findFirstResponder(sender: AnyObject) {
        UIResponder.resultFirstResponder = self
    }

    func defaultAccessoryView(selector: Selector? = nil) -> UIView {
        let space = UIBarButtonItem.init(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem.init(
            barButtonSystemItem: .Done,
            target: self,
            action: selector ?? #selector(resignFirstResponder)
        )

        let accessoryToolbar = UIToolbar()
        accessoryToolbar.items = [space, done]
        accessoryToolbar.autoresizingMask = .FlexibleHeight
        accessoryToolbar.translucent = false
        accessoryToolbar.backgroundColor = UIColor.appLightBackgroundColor()

        return accessoryToolbar
    }
}