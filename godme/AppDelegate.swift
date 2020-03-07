//
//  AppDelegate.swift
//  godme
//
//  Created by fcsdev on 2/28/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
    
        // keyborad Manager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        UINavigationBar.appearance().barTintColor = UIColor.clear
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        FirebaseApp.configure()
        self.checkLogin()
        return true
    }
    
    func checkLogin() -> Void {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.FlatColor.Gray.BGColor
        let splash = IntroduceViewController(nibName: "IntroduceViewController", bundle: nil)
        let nav = UINavigationController(rootViewController: splash)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }


}

