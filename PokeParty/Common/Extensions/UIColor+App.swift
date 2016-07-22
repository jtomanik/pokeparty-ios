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
            case .Instinct:
                return appInstinctColor()
            case .Mystic:
                return appMysticColor()
            case .Valor:
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
        return UIColor(red: 245.0 / 255.0, green: 245.0 / 255.0, blue: 248.0 / 255.0, alpha: 1.0)
    }

}