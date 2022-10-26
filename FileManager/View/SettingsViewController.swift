//
//  SettingsViewController.swift
//  FileManager
//
//  Created by Александр Хмыров on 27.10.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
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
        buttonChangePassword.setTitle("  Поменять пароль", for: .normal)
        buttonChangePassword.layer.cornerRadius = 12
        return buttonChangePassword
    }()

    private lazy var switchAlphabetical: UISwitch = {
        var switchAlphabetical = UISwitch()
        switchAlphabetical.setOn(true, animated: true)

        let action = UIAction { action in
            if self.switchAlphabetical.isOn {
                print("on")
                   }
            else {
                print("off")
            }
        }

        switchAlphabetical.addAction(action, for: .touchUpInside)
        return switchAlphabetical
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Настройки"


        self.view.addSubview(stackView)
        [labelAlphabetical, switchAlphabetical, buttonChangePassword].forEach { self.stackView.addArrangedSubview($0)}


        NSLayoutConstraint.activate([
            self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -12)

        ])

    }
    

}
