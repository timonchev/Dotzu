//
//  LogTabBarViewController.swift
//  exampleWindow
//
//  Created by Remi Robert on 20/01/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import UIKit

class LogTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [UIStoryboard(name: "Logs", bundle: Bundle(for: Dotzu.self)).instantiateInitialViewController()!,
                           UIStoryboard(name: "Application", bundle: Bundle(for: Dotzu.self)).instantiateInitialViewController()!,
                           UIStoryboard(name: "Settings", bundle: Bundle(for: Dotzu.self)).instantiateInitialViewController()!]
        tabBar.tintColor = Color.mainGreen
        if tabBar.items?.count ?? 0 > 2 && LogViewNotification.countCrash > 0 {
            tabBar.items?[1].badgeValue = "\(LogViewNotification.countCrash) crashes"
        }
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        item.badgeValue = nil
    }
}
