//
//  StatsVC.swift
//  NetworkAppIOSClient
//
//  Created by Charlie Tuna on 2019-01-27.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit
import SnapKit

class StatsVC: UIViewController {

    lazy var box = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        self.setConstraints()
    }

    private func setConstraints() {
        self.view.addSubview(self.box)

        self.box.backgroundColor = .purple

        self.box.snp.makeConstraints { (make) in
            make.height.width.equalTo(200)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
