//
//  SignUpVC+FormScroll.swift
//  NetworkAppIOSClient
//
//  Created by Charlie Tuna on 2019-01-27.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit

protocol CreateAccountFormViewDelegate {
    func onConfirmPressed(sender: UIButton)
}

//TODO: Turn this into a generic UIComponent.
class CreateAccountFormView: UIView {

    var delegate: CreateAccountFormViewDelegate?
    var fieldViews: [FormTextFieldView]?

    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false

        //List of fields within this form.
        fieldViews = [self.usernameField, self.emailField, self.passwordField, self.confirmPasswordField]

        self.setConstraints()
        self.initTargets()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setConstraints() {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true

        self.addSubview(scrollView)
        scrollView.addSubview(self.labelCreateAnAccount)
        scrollView.addSubview(self.stackView)

        [self.usernameField,
         self.emailField,
         self.passwordField,
         self.confirmPasswordField]
            .forEach({self.stackView.addArrangedSubview($0)})

        scrollView.addSubview(self.confirmButton)


        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.labelCreateAnAccount.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            self.labelCreateAnAccount.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.labelCreateAnAccount.bottomAnchor, constant: 30),
            self.stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            self.stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 80),
            self.confirmButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            self.confirmButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.7),
            self.confirmButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            self.confirmButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -25)
            ])
    }

    private func initTargets() {
        DispatchQueue.main.async {
            self.confirmButton.button.addTarget(self, action: #selector(self.onConfirmPressed), for: .touchUpInside)
        }
    }

    @objc func onConfirmPressed(sender: UIButton) {
        delegate?.onConfirmPressed(sender: sender)
    }

    //Components
    let labelCreateAnAccount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create an account" //Localize
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .blackish
        label.textAlignment = .center
        return label
    }()

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()

    let usernameField = FormTextFieldView.init(placeholder: "Name", icon: #imageLiteral(resourceName: "person-solid"), iconSize: 20, tintColor: .redish) //Localize
    let emailField = FormTextFieldView.init(type: .email, placeholder: "Email", icon: #imageLiteral(resourceName: "email-solid"), iconSize: 20, tintColor: .redish) //Localize
    let passwordField = FormTextFieldView.init(type: .password, placeholder: "Password", icon: #imageLiteral(resourceName: "lock-solid"), iconSize: 20, tintColor: .redish) //Localize
    let confirmPasswordField = FormTextFieldView.init(type: .password, placeholder: "Confirm password", icon: nil, iconSize: 20, tintColor: .redish) //Localize

    let confirmButton = RoundedButtonView(title: "Confirm", backgroundColor: .redish) //Localize
}
