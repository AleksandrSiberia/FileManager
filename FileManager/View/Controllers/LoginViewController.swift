//
//  LoginViewController.swift
//  FileManager
//
//  Created by Александр Хмыров on 26.10.2022.
//

import UIKit
import KeychainSwift

class LoginViewController: UIViewController {

    var buttonTitle: String!

    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    private lazy var textFieldPassword: UITextField = {
        var textFieldPassword = UITextField()

        textFieldPassword.clearButtonMode = .whileEditing
        textFieldPassword.backgroundColor = .systemGray6
        textFieldPassword.layer.cornerRadius = 12
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.keyboardType = .namePhonePad
        return textFieldPassword
    }()



    private lazy var buttonAuthorization: UIButton = {
        var buttonAuthorization = UIButton()

        buttonAuthorization.backgroundColor = UIColor(named: "myBlue")
        buttonAuthorization.layer.cornerRadius = 12

        let action = UIAction { uiAction in

            if self.buttonTitle != "Повторите пароль", self.buttonTitle != "   Введите пароль   " {

                guard (self.textFieldPassword.text?.count ?? 0) >= 4 else {
                    let alert = UIAlertController(title: nil , message: "Пароль должен быть минимум из 4 символов", preferredStyle: .alert)

                    let actionOk = UIAlertAction(title: "Ок", style: .cancel) { action in

                    }
                    alert.addAction(actionOk)
                    self.present(alert, animated: true)
                    return
                }
                KeychainSwift().set(self.textFieldPassword.text!, forKey: "password")
                self.buttonAuthorization.setTitle( "  Повторите пароль  ", for: .normal)
                self.buttonTitle = "Повторите пароль"
                self.textFieldPassword.text = ""
                return
            }

            if self.buttonTitle == "Повторите пароль" {
                guard KeychainSwift().get("password") == self.textFieldPassword.text else {

                    var alert = UIAlertController(title: "Пароли не совпадают", message: nil, preferredStyle: .alert)
                    var action = UIAlertAction(title: "ОК", style: .cancel)
                    alert.addAction(action)
                    self.present(alert, animated: true)

                    self.buttonAuthorization.setTitle("   Создать пароль   ", for: .normal)
                    self.buttonTitle = "Создать пароль"
                    return
                }

                self.textFieldPassword.text = ""
                self.navigationController?.pushViewController(TabBarControllerAssembly.createTabBarController(), animated: true)
           //     self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true)
                return
            }

            if self.buttonTitle == "   Введите пароль   " {

                guard KeychainSwift().get("password") == self.textFieldPassword.text else {
                    let alert = UIAlertController(title: "Неверный пароль", message: nil, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ок", style: .cancel)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                    return
                }

                self.textFieldPassword.text = ""
                self.navigationController?.pushViewController(TabBarControllerAssembly.createTabBarController(), animated: true)
                return
            }
        }
        buttonAuthorization.addAction(action, for: .touchUpInside)
        return buttonAuthorization
    }()




    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.addSubview(self.stackView)
        [textFieldPassword, buttonAuthorization].forEach {
            self.stackView.addArrangedSubview($0)
        }
        NSLayoutConstraint.activate([
            self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.buttonAuthorization.setTitle( self.buttonTitle, for: .normal)
    }
}
