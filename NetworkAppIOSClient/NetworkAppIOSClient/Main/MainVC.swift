//
//  MainVC.swift
//  NetworkAppIOSClient
//
//  Created by Charlie Tuna on 2019-01-28.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit
import SnapKit

class MainVC: UIViewController {

    static var sideMenuOpen = Box<Bool>.init(false)

    override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.scrollView.delegate = self

        MainVC.sideMenuOpen.bind { (isOpen) in
            if isOpen {
                self.scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
            } else {
                self.scrollView.setContentOffset(CGPoint(x:UIScreen.main.bounds.width*0.8, y:0), animated: true)
            }
        }

        self.sideMenuVC.delegate = self

        setConstraints()
    }

    private func setConstraints() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.sideMenuVC.view)
        self.scrollView.addSubview(self.mainTabBarVC.view)
        self.scrollView.addSubview(self.shadeView)

        self.sideMenuVC.didMove(toParent: self)
        self.mainTabBarVC.didMove(toParent: self)

        self.scrollView.snp.makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalTo(self.view)
        }

        self.sideMenuVC.view.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview()
            make.height.equalTo(self.scrollView.snp.height)
            make.width.equalTo(UIScreen.main.bounds.width*0.8)
        }

        self.mainTabBarVC.view.snp.makeConstraints { (make) in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(self.sideMenuVC.view.snp.trailing)
            make.width.equalTo(UIScreen.main.bounds.width)
        }

        self.shadeView.snp.makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalTo(self.mainTabBarVC.view)
        }
    }

    private func onLogOutPressed() {
        UserDefaults.standard.reset()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = SignInVC()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.setContentOffset(CGPoint(x:UIScreen.main.bounds.width*0.8, y:0), animated: false)
    }

    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.isPagingEnabled = true
        view.bounces = false
        return view
    }()

    let shadeView: UIView = { //TODO: Shade
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()

    let sideMenuVC = SideMenuVC()
    let mainTabBarVC = MainTabBarVC()
}

extension MainVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sideMenuWidth = UIScreen.main.bounds.width*0.8
        let xValue = ["shadeValue":scrollView.contentOffset.x/sideMenuWidth]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DidScroll"),
                                        object: nil,
                                        userInfo: xValue)
        self.shadeView.alpha = -scrollView.contentOffset.x/(sideMenuWidth*2) + 1/2
    }
}

extension MainVC: SideMenuVCDelegate {
    func sideMenuVC(didSelect rowAt: Int) {
        switch rowAt {
        case 1:
            self.onLogOutPressed()
        case 0:
            API.MeInfo().execute(onSuccess: { (player) in
                let message = "Wins:\(player.wins)\nLosses:\(player.losses)\nELO:\(player.elo)"

                self.presentAlert(title: "Personal Stats", message: message)
            }) { (error) in
                self.presentAlert(title: "Error", message: "Something went wrong, try again later.")
            }
        default:
            print("Something went horribly wrong.")
        }
    }
}
