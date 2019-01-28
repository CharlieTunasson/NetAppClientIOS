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
        initTargets()
    }

    private func setConstraints() {
        self.view.addSubview(self.gameButton)
        self.view.addSubview(self.textField)
        self.view.addSubview(self.sendButton)

        self.gameButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        self.sendButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-8)
            make.centerX.equalToSuperview()
        }

        self.textField.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.sendButton.snp.top)
            make.centerX.equalToSuperview()
        }
    }

    private func initTargets() {
        self.gameButton.addTarget(self, action: #selector(onGameButtonPressed), for: .touchUpInside)
        self.sendButton.addTarget(self, action: #selector(onSendButtonPressed), for: .touchUpInside)
    }

    @objc func onSendButtonPressed(sender: UIButton) {
        sender.setAsLoading(true, with: .redish)
        if let enemyId = self.textField.text {
            API.RequestMatch.init(enemyId: enemyId).execute(onSuccess: { (response) in
                print("success")
                sender.setAsLoading(false)
            }) { (error) in
                print(error)
                sender.setAsLoading(false)
            }
        } else {
            sender.setAsLoading(false)
            self.presentAlert(title: "Error", message: "Field is empty!")
        }
    }

    @objc func onGameButtonPressed(sender: UIButton) {
        sender.setAsLoading(true, with: .redish)
        API.ListenMatch().execute(onSuccess: { (game) in
            print(game)

            let actualGameVC = ActualGameVC()
            self.navigationController?.pushViewController(actualGameVC, animated: true)

            sender.setAsLoading(false)
        }) { (error) in
            print(error)
            self.presentAlert(title: "Error", message: error.localizedDescription)
            sender.setAsLoading(false)
        }
    }

    let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Opponent" //Localize
        field.autocapitalizationType = .none
        return field
    }()

    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = true
        button.setTitle("Send Request", for: .normal)
        return button
    }()

    let gameButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = true
        button.setTitle("PLAY", for: .normal)
        return button
    }()
}
