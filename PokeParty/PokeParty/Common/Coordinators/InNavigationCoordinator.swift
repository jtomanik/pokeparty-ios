//
//  InNavigationCoordinator.swift
//  Switchboard
//
//  Created by Jakub Warchoł on 06.05.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

protocol InNavigationCoordinator: Coordinator {
    var navigationController: NavigationController { get }
}