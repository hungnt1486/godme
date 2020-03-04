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
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
