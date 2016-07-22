//
//  TabBarCoordinator.swift
//  Switchboard
//
//  Created by Sebastian Osiński on 25/05/16.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import UIKit

protocol TabBarCoordinator: Coordinator { }


extension TabBarCoordinator {
    
    var tabBarController: UITabBarController {
        return rootViewController as! UITabBarController
    }
}
