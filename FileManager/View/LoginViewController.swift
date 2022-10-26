//
//  LoginViewController.swift
//  FileManager
//
//  Created by Александр Хмыров on 26.10.2022.
//

import UIKit

class LoginViewController: UIViewController {

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
        textFieldPassword.placeholder = "   Введите пароль"
        textFieldPassword.clearButtonMode = .whileEditing
        textFieldPassword.backgroundColor = .systemGray6
        textFieldPassword.layer.cornerRadius = 12


        return textFieldPassword
    }()

    private lazy var buttonAuthorization: UIButton = {
        var buttonAuthorization = UIButton()
        buttonAuthorization.setTitle("   Зарегистрироваться   ", for: .normal)
        buttonAuthorization.backgroundColor = UIColor(named: "myBlue")
        buttonAuthorization.layer.cornerRadius = 12

        let action = UIAction { uiAction in

            guard (self.textFieldPassword.text?.count ?? 0) >= 4 else {
                let alert = UIAlertController(title: nil , message: "Пароль должен быть минимум из 4 символов", preferredStyle: .alert)

                let actionOk = UIAlertAction(title: "Ок", style: .cancel) { action in

                }
                alert.addAction(actionOk)
                self.present(alert, animated: true)
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

    @objc func dismissAction() {
        print("gesture")
        self.dismiss(animated: true)
    }
    

}
