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
import GoogleMaps
import GooglePlaces
import AWSS3

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // google map
        GMSServices.provideAPIKey("AIzaSyD5ez9nRucb2cwrjnraxAw49GnEujn32uA")
        GMSPlacesClient.provideAPIKey("AIzaSyDSj2djntN0lRFgEjojMDi5V5vsjUiXxDo")
    
        // keyborad Manager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        UINavigationBar.appearance().barTintColor = UIColor.clear
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        FirebaseApp.configure()
        // init AWS
        self.initializeS3()
        self.checkLogin()
        return true
    }
    
    func initializeS3() {
        let poolId = "AKIAT4P2FWA5FP5WODNQ" // 3-1
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .USWest1, identityPoolId: poolId)//3-2
        let configuration = AWSServiceConfiguration(region: .USWest1, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        
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

