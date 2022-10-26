//
//  SceneDelegate.swift
//  FileManager
//
//  Created by Александр Хмыров on 21.10.2022.
//

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {



        UserDefaults.standard.set(true, forKey: "isTrusted")


        guard let scene = (scene as? UIWindowScene) else { return }

        self.window = UIWindow.init(windowScene: scene)

        guard UserDefaults.standard.bool(forKey: "isTrusted") else {

            let loginViewController = LoginViewController()
            loginViewController.view.backgroundColor = .white
            let navLoginViewController = UINavigationController.init(rootViewController: loginViewController)
            self.window?.rootViewController = navLoginViewController
            self.window?.makeKeyAndVisible()
            return
        }

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


        self.window?.rootViewController = tabBarViewController
        self.window?.makeKeyAndVisible()


    }


    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

