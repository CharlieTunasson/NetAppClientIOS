//
//  gameVC.swift
//  NetworkAppIOSClient
//
//  Created by Charlie Tuna on 2019-01-27.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit
import SnapKit

class GameVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        setConstraints()
    }

    private func setConstraints() {
        self.view.addSubview(self.gameButton)

        self.gameButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

    let gameButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = true
        button.setTitle("PLAY", for: .normal)
        return button
    }()
}
