//
//  UIImage+WithColors.swift
//  Switchboard
//
//  Created by Sebastian Osiński on 09/05/16.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func withColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
}