//
//  AppDelegate.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let listCoordinator = ListCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController(rootViewController: listCoordinator.viewController)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.targetBullseyeRedColor]
        navController.navigationBar.barTintColor = .targetStarkWhiteColor
        navController.navigationBar.backgroundColor = .targetStarkWhiteColor
        navController.navigationBar.tintColor = .targetBullseyeRedColor
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}


}

