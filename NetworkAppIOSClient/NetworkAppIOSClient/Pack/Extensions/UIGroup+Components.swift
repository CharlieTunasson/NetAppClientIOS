//
//  UIGroup+Components.swift
//  NetworkAppIOSClient
//
//  Created by Charlie Tuna on 2019-01-27.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit

extension UIButton {
    static func dismissButton() -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "icon-cancel"), for: .normal)
        button.tintColor = .red
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }
}

extension UINavigationController {
    static func plainStyledNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.barTintColor = UIColor.white
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }
}
