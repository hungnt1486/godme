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
//        GMSServices.provideAPIKey("AIzaSyDFBrKG4FZ1jSDOuTHHh87w5ZDdqep_uvA")
        
//        print("key = \(GMSServices.provideAPIKey("AIzaSyDFBrKG4FZ1jSDOuTHHh87w5ZDdqep_uvA"))")
        
//        GMSServices.provideAPIKey("AIzaSyDSj2djntN0lRFgEjojMDi5V5vsjUiXxDo")
//        GMSPlacesClient.provideAPIKey("AIzaSyDSj2djntN0lRFgEjojMDi5V5vsjUiXxDo")
    
        // config Notification
        registerForPushNotifications()
        // keyborad Manager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        UINavigationBar.appearance().barTintColor = UIColor.clear
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
//        if GMSServices.provideAPIKey("AIzaSyDFBrKG4FZ1jSDOuTHHh87w5ZDdqep_uvA") {
//            print("good provided keys correctly")
//        }
//        else {
//            print("key didn't provided")
//        }
        GMSServices.provideAPIKey("AIzaSyBVVFTLZlEwbYwCFvL68MG23sTyJu4biYk")
        GMSPlacesClient.provideAPIKey("AIzaSyBVVFTLZlEwbYwCFvL68MG23sTyJu4biYk")
        let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")!
        let options = FirebaseOptions(contentsOfFile: filePath)
        FirebaseApp.configure(options: options!)
//        FirebaseApp.configure()
        // init AWS
        self.initializeS3()
        self.checkLogin()
        return true
    }
    
    func initializeS3() {
        let poolId = "ap-southeast-1:67a74c76-8eed-4494-9133-70839255dbcb" // 3-1
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .APSoutheast1, identityPoolId: poolId)//3-2
        let configuration = AWSServiceConfiguration(region: .APSoutheast1, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        // Initialize the Amazon Cognito credentials provider

//        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.APSoutheast1,
//           identityPoolId:"ap-southeast-1:67a74c76-8eed-4494-9133-70839255dbcb")
//
//        let configuration = AWSServiceConfiguration(region:.APSoutheast1, credentialsProvider:credentialsProvider)
//
//        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = configuration
        
        
    }
    
    func checkLogin() -> Void {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.FlatColor.Gray.BGColor
        let splash = IntroduceViewController(nibName: "IntroduceViewController", bundle: nil)
        let nav = UINavigationController(rootViewController: splash)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current() // 1
            .requestAuthorization(options: [.alert, .sound, .badge]) { // 2
                granted, error in
                print("Permission granted: \(granted)") // 3
                guard granted else { return }
                self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        if Auth.auth().canHandleNotification(userInfo) {
            completionHandler(.noData)
            return
        }
        
        completionHandler(.newData)
        print(userInfo)
        
        if application.applicationState == .inactive {
            
        } else if application.applicationState == .active {
            
        }  else {
            
        }

    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%.2hhx", $0) }.joined()
        print("token = \(token)")
        Settings.ShareInstance.deviceToken = token
        Auth.auth().setAPNSToken(deviceToken, type: .unknown)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }


}

