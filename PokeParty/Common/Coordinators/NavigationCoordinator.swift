//
//  File.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 06.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

import Foundation


protocol NavigationCoordinator: Coordinator { }


extension NavigationCoordinator {
    
    var navigationController: NavigationController {
        return rootViewController as! NavigationController
    }
}