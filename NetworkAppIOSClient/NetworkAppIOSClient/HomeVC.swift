//
//  ViewController.swift
//  NetworkAppIOSClient
//
//  Created by Charlie Tuna on 2019-01-27.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initApp()
    }

    private func initApp() {
        DispatchQueue.main.async {
            if UserDefaults.standard.getIsLoggedIn() {
                let mainVC = MainVC()
                mainVC.title = "Arm Wrestle"
                let nav = UINavigationController(rootViewController: mainVC)
                self.present(nav, animated: false)
            } else {
                let signInVC = SignInVC()
                self.present(signInVC, animated: false)
            }
        }
    }
}

