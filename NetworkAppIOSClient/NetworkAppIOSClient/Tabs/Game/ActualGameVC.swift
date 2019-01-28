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

    var gameId: Int!

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
        API.GameTouch.init(gameId: gameId).execute(onSuccess: { (game) in
            if let result = game.result {
                var winnerId: String
                if result == 1 {
                    winnerId = game.player1.id!
                } else if result == 2 {
                    winnerId = game.player2.id!
                } else {
                    self.presentAlert(title: "Error", message: "Something went wrong!") {
                        self.navigationController?.popViewController(animated: true)
                    }
                    return
                }
                self.presentAlert(title: winnerId, message: "Has won the game!") {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                self.presentAlert(title: "Error", message: "Something went wrong!") {
                    self.navigationController?.popViewController(animated: true)
                }
                return
            }
        }) { (error) in
            self.presentAlert(title: "Error", message: error.localizedDescription) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    let bigLabel: UILabel = {
        let label = UILabel()
        label.text = "fist-raised" //Localize
        label.font = UIFont.init(name: FontNames.FAPro_solid, size: 100)
        label.textColor = .yellowish
        label.textAlignment = .center
        label.backgroundColor = .blackish
        label.isUserInteractionEnabled = true
        return label
    }()
}
