//
//  TabBarControllerAssembly.swift
//  FileManager
//
//  Created by Александр Хмыров on 27.10.2022.
//

import Foundation
import UIKit

class TabBarControllerAssembly {

    
    static func createTabBarController() -> UITabBarController {

        let settingViewController = SettingsViewController()

        let navSettingViewController = UINavigationController(rootViewController: settingViewController)
        navSettingViewController.view.backgroundColor = .white


        let fileManagerViewController = FileManagerAssembly.giveMeFileManagerViewController()
        fileManagerViewController.view.backgroundColor = .white
        fileManagerViewController.navigationItem.title = "Documents"
        fileManagerViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "doc.on.doc" ), tag: 1)
        let navFileManagerViewController = UINavigationController(rootViewController: fileManagerViewController)
        navSettingViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "gearshape"), tag: 2)


        let tabBarViewController = UITabBarController()
        tabBarViewController.viewControllers = [navFileManagerViewController, navSettingViewController]
        tabBarViewController.tabBar.backgroundColor = .white

        return tabBarViewController

    }
}
