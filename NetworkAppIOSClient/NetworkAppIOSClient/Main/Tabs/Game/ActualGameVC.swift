//
//  ActualGameVC.swift
//  NetworkAppIOSClient
//
//  Created by Charlie Tuna on 2019-01-28.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit
import SnapKit

class ActualGameVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraints()
        initTargets()
    }

    private func setConstraints() {
        self.view.addSubview(bigLabel)

        self.bigLabel.snp.makeConstraints { (make) in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }

    private func initTargets() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(self.onBigLabelPressed))
        tap.cancelsTouchesInView = false
        self.bigLabel.addGestureRecognizer(tap)
    }

    @objc func onBigLabelPressed() {
        
    }

    let bigLabel: UILabel = {
        let label = UILabel()
        label.text = "TRY NOT TO TOUCH!" //Localize
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .blackish
        label.textAlignment = .center
        label.backgroundColor = .redish
        label.isUserInteractionEnabled = true
        return label
    }()
}
