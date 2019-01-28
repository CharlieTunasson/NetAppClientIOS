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
    var players: [Player] = [Player]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        self.setConstraints()
        self.initComponents()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.getData()
    }

    private func setConstraints() {
        self.view.addSubview(self.label)
        self.view.addSubview(self.tableView)

        self.label.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(-8)
            make.centerX.equalToSuperview()
        }

        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.label.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

    private func getData() {
        API.LeaderBoard().execute(onSuccess: { (leaderBoard) in
            self.players = leaderBoard
            self.tableView.reloadData()
        }) { (error) in
            print(error)
            self.presentAlert(title: "Error", message: error.localizedDescription)
        }
    }

    private func initComponents() {
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }

    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    let label: UILabel = {
        let label = UILabel()
        label.text = "Leaderboard" //Localize
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .blackish
        label.textAlignment = .center
        return label
    }()
}


extension StatsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        let player = self.players[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row+1). \(player.player_id!) elo:\(player.elo)"
        return cell
    }
}
