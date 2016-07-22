//
//  UIApplication+TopViewController.swift
//  Switchboard
//
//  Created by Sebastian Osiński on 26/06/16.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit

extension UIApplication {
    
    var topViewController: UIViewController? {
        let delegate = self.delegate as? AppDelegate
        
        var viewController = delegate?.window?.rootViewController
        
        while let nextViewController = viewController?.presentedViewController {
            viewController = nextViewController
        }
        
        return viewController
    }
}