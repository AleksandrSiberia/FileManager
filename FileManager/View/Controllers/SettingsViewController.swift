//
//  SettingsViewController.swift
//  FileManager
//
//  Created by Александр Хмыров on 27.10.2022.
//

import UIKit
import KeychainSwift

class SettingsViewController: UIViewController {

    var delegate: SettingsViewControllerDelegate!

    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
      //  stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()


    private lazy var labelAlphabetical: UILabel = {
        var labelAlphabetical = UILabel()
        labelAlphabetical.text = "Сортировать документы по алфавиту"
        labelAlphabetical.numberOfLines = 0
        return labelAlphabetical
    }()


    private lazy var buttonChangePassword: UIButton = {
        var buttonChangePassword = UIButton()
        buttonChangePassword.backgroundColor = UIColor(named: "myBlue")
        buttonChangePassword.setTitle("  Поменять пароль  ", for: .normal)
        buttonChangePassword.layer.cornerRadius = 12
        buttonChangePassword.translatesAutoresizingMaskIntoConstraints = false

        let action = UIAction { uiAction in
            let loginViewController = LoginViewController()
            loginViewController.buttonTitle = "   Создать новый пароль   "
            loginViewController.view.backgroundColor = .white
            self.present(loginViewController, animated: true)
        }
        
        buttonChangePassword.addAction(action, for: .touchUpInside)
        return buttonChangePassword
    }()



    private lazy var buttonDeletePassword: UIButton = {
        var buttonDeletePassword = UIButton()
        buttonDeletePassword.backgroundColor = UIColor(named: "myBlue")
        buttonDeletePassword.layer.cornerRadius = 12
        buttonDeletePassword.setTitle("Удалить пароль", for: .normal)
        buttonDeletePassword.translatesAutoresizingMaskIntoConstraints = false

        let action = UIAction { _ in
            print("delete")

            let alert = UIAlertController(title: "   Удалить пароль   ", message: nil, preferredStyle: .alert)

            let actionOk = UIAlertAction(title: "Да", style: .destructive) { _ in
                KeychainSwift().delete("password")
            }

            let actionCancel = UIAlertAction(title: "Нет", style: .cancel)
            alert.addAction(actionOk)
            alert.addAction(actionCancel)

            self.present(alert, animated: true)
        }

        buttonDeletePassword.addAction(action, for: .touchUpInside)

        return buttonDeletePassword
    }()



    private lazy var switchAlphabetical: UISwitch = {
        var switchAlphabetical = UISwitch()

        if UserDefaults.standard.bool(forKey: "switchAlphabeticalOff") == true {
            switchAlphabetical.setOn(false, animated: true)
        }
        if UserDefaults.standard.bool(forKey: "switchAlphabeticalOff") == false {
            switchAlphabetical.setOn(true, animated: true)
        }

        let action = UIAction { action in
            if self.switchAlphabetical.isOn {
                UserDefaults.standard.set(false, forKey: "switchAlphabeticalOff")
                self.delegate.reloadTableView(director: self)
                   }
            else {
                UserDefaults.standard.set(true, forKey: "switchAlphabeticalOff")
                self.delegate.reloadTableView(director: self)
            }
        }
        switchAlphabetical.addAction(action, for: .touchUpInside)
        return switchAlphabetical
    }()



    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Настройки"
        self.view.addSubview(stackView)
        self.view.addSubview(buttonChangePassword)
        self.view.addSubview(buttonDeletePassword)

        [labelAlphabetical, switchAlphabetical].forEach { self.stackView.addArrangedSubview($0)}

        NSLayoutConstraint.activate([

            self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -12),

            self.buttonChangePassword.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 30),
            self.buttonChangePassword.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

            self.buttonDeletePassword.topAnchor.constraint(equalTo: self.buttonChangePassword.bottomAnchor, constant: 5),
            self.buttonDeletePassword.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.buttonDeletePassword.leadingAnchor.constraint(equalTo: self.buttonChangePassword.leadingAnchor),
            self.buttonDeletePassword.trailingAnchor.constraint(equalTo: self.buttonChangePassword.trailingAnchor)


        ])
    }
}
