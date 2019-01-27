//
//  SignUpVC.swift
//  NetworkAppIOSClient
//
//  Created by Charlie Tuna on 2019-01-27.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setButtonsForPlainNavigationBarStyle(with: .redish)
        self.setHideKeyboardOnTap()

        initUI()
    }

    fileprivate func initUI() {
        DispatchQueue.main.async {

            self.createAccountForm.delegate = self

            self.view.addSubview(self.createAccountForm)
            NSLayoutConstraint.activate([
                self.createAccountForm.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                self.createAccountForm.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.createAccountForm.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.createAccountForm.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
                ])
        }
    }

    //Components
    let createAccountForm = CreateAccountFormView()
}

//For CreateAccountFormView delegation.
extension SignUpVC: CreateAccountFormViewDelegate {
    func onConfirmPressed(sender: UIButton) {
        sender.setAsLoading(true)
        if self.inputsValid() {
            API.SignUp.init(params: ["id":createAccountForm.usernameField.textField.text!,
                                     "email":createAccountForm.emailField.textField.text!,
                                     "password":createAccountForm.passwordField.textField.text!])
                .execute(onSuccess: { (player) in
                print(player)
                sender.setAsLoading(false)
                self.navigationController?.pushViewController(AccountCreationConfirmedVC(), animated: true)
            }) { (error) in
                print(error)
                sender.setAsLoading(false)
                self.presentAlert(title: "Error", message: error.localizedDescription)
            }
        } else {
            sender.setAsLoading(false)
            self.presentAlert(title: "Error", message: "Fields could not be validated.")
        }
    }
}

//Validation before continue
extension SignUpVC {
    private func inputsValid() -> Bool {
        if let fieldViews = self.createAccountForm.fieldViews {
            for fieldView in fieldViews {
                if !fieldView.hasValidInput() {
                    fieldView.bottomLine.alpha = 1.0
                    fieldView.bottomLine.backgroundColor = .redish
                    return false
                }
            }
        } else {
            print("No fields found.")
            return false
        }
        //Should not be located here. Try to keep rule logic outside of VC
        if self.createAccountForm.passwordField.textField.text
            != self.createAccountForm.confirmPasswordField.textField.text {
            self.createAccountForm.confirmPasswordField.bottomLine.backgroundColor = .redish
            self.presentAlert(title: "Error", message: "Passwords do not match!")//Localize
            return false
        }
        return true
    }
}

