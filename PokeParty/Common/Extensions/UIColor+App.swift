//
//  UIColor+App.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 09.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit


extension UIColor {

    class func appTeamColor() -> UIColor {
        guard let team = AccountDataProviderFactory.userDefaultsAccountDataProvider().userTeam else {
            return appValorColor()
        }

        switch team {
            case .instinct:
                return appInstinctColor()
            case .mystic:
                return appMysticColor()
            case .valor:
                return appValorColor()
        }
    }

    class func appValorColor() -> UIColor {
        return UIColor(red: 252.0 / 255.0, green: 80.0 / 255.0, blue: 40.0 / 255.0, alpha: 1.0)
    }

    class func appMysticColor() -> UIColor {
        return UIColor(red: 73.0 / 255.0, green: 120.0 / 255.0, blue: 220.0 / 255.0, alpha: 1.0)
    }

    class func appInstinctColor() -> UIColor {
        return UIColor(red: 255.0 / 255.0, green: 218.0 / 255.0, blue: 26.0 / 255.0, alpha: 1.0)
    }

    class func appLightBackgorundColor() -> UIColor {
        return UIColor(red: 238.0 / 255.0, green: 238.0 / 255.0, blue: 243.0 / 255.0, alpha: 1.0)
    }

    class func appButtonBorderYellowColor() -> UIColor {
        return UIColor(red: 255.0 / 255.0, green: 203.0 / 255.0, blue: 5.0 / 255.0, alpha: 1.0)
    }

    class func appButtonBackgroundBlueColor() -> UIColor {
        return UIColor(red: 51.0 / 255.0, green: 103.0 / 255.0, blue: 176.0 / 255.0, alpha: 1.0)
    }

    class func appSplashScreenBackgroundColor() -> UIColor {
        return UIColor(red: 29.0 / 255.0, green: 44.0 / 255.0, blue: 94.0 / 255.0, alpha: 1.0)
    }

}