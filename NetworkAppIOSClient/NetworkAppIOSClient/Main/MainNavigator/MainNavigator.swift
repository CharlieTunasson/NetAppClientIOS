//
//  MainVC.swift
//  NetworkAppIOSClient
//
//  Created by Charlie Tuna on 2019-01-27.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        self.viewControllers = [self.statsVC, self.gameVC].map({
            UINavigationController(rootViewController: $0)
        })
    }

    let gameVC: GameVC = {
        let vc = GameVC()
        vc.title = "Find Match" //Todo: Localize
        vc.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "dashboard"), tag: 0)
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return vc
    }()

    let statsVC: StatsVC = {
        let vc = StatsVC()
        vc.title = "Stats" //Todo: Localize
        vc.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "house"), tag: 1)
        vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return vc
    }()
}
