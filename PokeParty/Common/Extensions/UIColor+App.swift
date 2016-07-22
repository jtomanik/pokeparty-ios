//
//  UIColor+App.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 09.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit


extension UIColor {
    
    // MARK: - Plain colors
    
    class func appSalmonColor() -> UIColor {
        return UIColor(red: 244.0 / 255.0, green: 113.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)
    }
    
    class func appDarkColor() -> UIColor {
        return UIColor(red: 37.0 / 255.0, green: 47.0 / 255.0, blue: 64.0 / 255.0, alpha: 1.0)
    }
    
    class func appTealishColor() -> UIColor {
        return UIColor(red: 44.0 / 255.0, green: 214.0 / 255.0, blue: 175.0 / 255.0, alpha: 1.0)
    }
    
    class func appSilverColor() -> UIColor {
        return UIColor(red: 204.0 / 255.0, green: 208.0 / 255.0, blue: 217.0 / 255.0, alpha: 1.0)
    }
    
    class func appDodgerBlueColor() -> UIColor {
        return UIColor(red: 55.0 / 255.0, green: 134.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
    }
    
    class func appDodgerBlueTwoColor() -> UIColor {
        return UIColor(red: 65.0 / 255.0, green: 140.0 / 255.0, blue: 251.0 / 255.0, alpha: 1.0)
    }
    
    class func appDarkSkyBlueColor() -> UIColor {
        return UIColor(red: 53.0 / 255.0, green: 126.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
    }
    
    class func appBattleshipGreyColor() -> UIColor {
        return UIColor(red: 97.0 / 255.0, green: 111.0 / 255.0, blue: 127.0 / 255.0, alpha: 1.0)
    }
    
    class func appCharcoalGreyColor() -> UIColor {
        return UIColor(red: 65.0 / 255.0, green: 71.0 / 255.0, blue: 81.0 / 255.0, alpha: 1.0)
    }
    
    class func appDarkBlueGreyColor() -> UIColor {
        return UIColor(red: 23.0 / 255.0, green: 20.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0)
    }
    
    class func appSteelColor() -> UIColor {
        return UIColor(red: 124.0 / 255.0, green: 130.0 / 255.0, blue: 140.0 / 255.0, alpha: 1.0)
    }
    
    class func appCoolGreyColor() -> UIColor {
        return UIColor(red: 174.0 / 255.0, green: 180.0 / 255.0, blue: 193.0 / 255.0, alpha: 1.0)
    }
    
    class func appSkyBlueColor() -> UIColor {
        return UIColor(red: 75.0 / 255.0, green: 196.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
    
    class func appWeirdGreenColor() -> UIColor {
        return UIColor(red: 48.0 / 255.0, green: 233.0 / 255.0, blue: 129.0 / 255.0, alpha: 1.0)
    }
    
    class func appWarmPinkColor() -> UIColor {
        return UIColor(red: 255.0 / 255.0, green: 84.0 / 255.0, blue: 122.0 / 255.0, alpha: 1.0)
    }
    
    class func appSunflowerYellowColor() -> UIColor {
        return UIColor(red: 255.0 / 255.0, green: 220.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    // MARK: - Text colors
    
    class func appTextColor100Alpha() -> UIColor {
        return UIColor.appDarkColor()
    }
    
    class func appTextColor60Alpha() -> UIColor {
        return UIColor.appDarkColor().colorWithAlphaComponent(0.6)
    }
    
    class func appTextColor40Alpha() -> UIColor {
        return UIColor.appDarkColor().colorWithAlphaComponent(0.4)
    }

    class func appTextColor35Alpha() -> UIColor {
        return UIColor.appDarkBlueGreyColor().colorWithAlphaComponent(0.35)
    }
    
    class func appTextColor25Alpha() -> UIColor {
        return UIColor.appDarkBlueGreyColor().colorWithAlphaComponent(0.25)
    }

    class func appTextColor20Alpha() -> UIColor {
        return UIColor.appDarkColor().colorWithAlphaComponent(0.2)
    }

    // MARK: - Separator colors

    class func appLightSeparatorColor() -> UIColor {
        return appDarkBlueGreyColor().colorWithAlphaComponent(0.05)
    }
    
    class func appDarkSeparatorColor() -> UIColor {
        return UIColor.blackColor().colorWithAlphaComponent(0.1)
    }

    // MARK: - Border Colors

    class func appLightBorderColor() -> UIColor {
        return UIColor(red: 151.0 / 255.0, green: 151.0 / 255.0, blue: 151.0 / 255.0, alpha: 0.08)
    }
    
    class func appDarkBorderColor() -> UIColor {
        return UIColor(red: 151.0 / 255.0, green: 151.0 / 255.0, blue: 151.0 / 255.0, alpha: 0.16)
    }

    // MARK: - Background colors

    class func appDarkBackgroundColor() -> UIColor {
        return UIColor(red: 238.0 / 255.0, green: 238.0 / 255.0, blue: 243.0 / 255.0, alpha: 1.0)
    }
    
    class func appLightBackgroundColor() -> UIColor {
        return UIColor(red: 245.0 / 255.0, green: 245.0 / 255.0, blue: 248.0 / 255.0, alpha: 1.0)
    }

    // MARK: - Other

    class func appShadowColor() -> UIColor {
        return UIColor.blackColor().colorWithAlphaComponent(0.05)
    }

    class func appSelectedOptionsColor() -> UIColor {
        return UIColor.appDarkColor().colorWithAlphaComponent(0.05)
    }

    class func appOnboardingSeparatorColor() -> UIColor {
        return UIColor.appDarkColor().colorWithAlphaComponent(0.1)
    }
}