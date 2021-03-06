//
//  SideMenuCell.swift
//  NetworkAppIOSClient
//
//  Created by Charlie Tuna on 2019-01-28.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit
import SnapKit

class SideMenuCell: UITableViewCell {

    var title: String! {
        didSet {
            initUI()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConstraints() {
        self.addSubview(self.iconLabel)
        self.addSubview(self.titleLabel)

        self.iconLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }

        self.titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.iconLabel.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
    }

    private func initUI() {
        titleLabel.text = title
        switch self.title {
        case "Dashboard":
            iconLabel.text = "tachometer"
        case "Rooms":
            iconLabel.text = "home"
        case "Log out":
            iconLabel.text = "sign-out"
        case "About":
            iconLabel.text = "info-circle"
        case "Personal stats":
            iconLabel.text = "chart-pie"
        default:
            print("ERROR")
        }
    }

    let iconLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: FontNames.FAPro_solid, size: 20)
        label.textColor = .blackish
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .blackish
        return label
    }()
}
