//
//  BaseViewController.swift
//  cityBus
//
//  Created by Lê Hùng on 5/31/19.
//  Copyright © 2019 Lê Hùng. All rights reserved.
//

import UIKit

import UIKit
import Alamofire
import MBProgressHUD
//import RxSwift
//import RxCocoa

class BaseViewController: UIViewController {
    
    //    var disposeBag = DisposeBag()
    
    var tabbarController: UITabBarController = UITabBarController()
    let delegateApp = UIApplication.shared.delegate as! AppDelegate
    
    public static var accessToken = String()
    
    public static var deviceToken = String()
    
    public static var headers: HTTPHeaders = [:]
    
    public static var Lat = Double()
    public static var Lng = Double()
    public static var Current_Lat = Double()
    public static var Current_Lng = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        // Do any additional setup after loading the view.
        configToken()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "ic_bg_nav"), for: .default)
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configToken() {
        BaseViewController.headers = ["TokenLogin": BaseViewController.accessToken, "Accept": "application/json"]
//        BaseViewController.deviceToken = "gewgewg"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showProgressHub() -> Void {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideProgressHub() -> Void {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func loginSuccess() -> Void {
        
        let accounts = AccountsViewController()
        accounts.tabBarItem.tag = 1
        accounts.tabBarItem.image = UIImage.init(named: "ic_home")
        accounts.tabBarItem.selectedImage = UIImage.init(named: "ic_home_active")?.withRenderingMode(.alwaysOriginal)
        let navAccounts = UINavigationController.init(rootViewController: accounts)
        
        let servicesManage = ServicesManageViewController()
        servicesManage.tabBarItem.tag = 2
        servicesManage.tabBarItem.image = UIImage.init(named: "ic_home")
        servicesManage.tabBarItem.selectedImage = UIImage.init(named: "ic_home_active")?.withRenderingMode(.alwaysOriginal)
        let navServicesManage = UINavigationController.init(rootViewController: servicesManage)
        
        let main = MainViewController()
        main.tabBarItem.tag = 3
        main.tabBarItem.image = UIImage.init(named: "ic_home")
        main.tabBarItem.selectedImage = UIImage.init(named: "ic_home_active")?.withRenderingMode(.alwaysOriginal)
        let navMain = UINavigationController.init(rootViewController: main)
        
        let relationship = RelationshipsViewController()
        relationship.tabBarItem.tag = 4
        relationship.tabBarItem.image = UIImage.init(named: "ic_home")
        relationship.tabBarItem.selectedImage = UIImage.init(named: "ic_home_active")?.withRenderingMode(.alwaysOriginal)
        let navRelationship = UINavigationController.init(rootViewController: relationship)
        
        let maps = MapsViewController()
        maps.tabBarItem.tag = 5
        maps.tabBarItem.image = UIImage.init(named: "ic_home")
        maps.tabBarItem.selectedImage = UIImage.init(named: "ic_home_active")?.withRenderingMode(.alwaysOriginal)
        let navMaps = UINavigationController.init(rootViewController: maps)
        
        tabbarController.setViewControllers([navAccounts, navServicesManage, navMain, navRelationship, navMaps], animated: true)
        delegateApp.window?.rootViewController = tabbarController
        delegateApp.window?.makeKeyAndVisible()
    }
        
        
        func logoutSuccess() -> Void {
            UserDefaults.standard.removeObject(forKey: information_login)
            UserDefaults.standard.synchronize()
            
            self.tabbarController.selectedIndex = 0
            let login = LoginViewController(nibName: "LoginViewController", bundle: nil)
            let nav = UINavigationController(rootViewController: login)
            delegateApp.window?.rootViewController = nav
            delegateApp.window?.makeKeyAndVisible()
        }
    
}
