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


        let fileManagerViewController = FileManagerAssembly.giveMeFileManagerViewController()
        fileManagerViewController.view.backgroundColor = .white
        fileManagerViewController.navigationItem.title = "Documents"
        fileManagerViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "doc.on.doc" ), tag: 1)
        let navFileManagerViewController = UINavigationController(rootViewController: fileManagerViewController)
      


        let settingViewController = SettingsViewController()
        let navSettingViewController = UINavigationController(rootViewController: settingViewController)
        navSettingViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "gearshape"), tag: 2)
        navSettingViewController.view.backgroundColor = .white
        settingViewController.delegate = fileManagerViewController


        let tabBarViewController = UITabBarController()
        tabBarViewController.viewControllers = [navFileManagerViewController, navSettingViewController]
        tabBarViewController.tabBar.backgroundColor = .white



        return tabBarViewController

    }
}
