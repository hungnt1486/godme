//
//  LoginViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/4/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btForgotPassword: UIButton!
    @IBOutlet weak var btLogin: UIButton!
    @IBOutlet weak var lbRegister: UILabel!
    var status = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.configButtonBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "login")
        if status == "logout" {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        }
    }
    
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = UIColor.FlatColor.Gray.BGColor
        self.tfUserName = Settings.ShareInstance.setupTextField(textField: self.tfUserName, isLeftView: true)
        self.tfUserName.ShadowTextField()
        
        self.tfPassword = Settings.ShareInstance.setupTextField(textField: self.tfPassword, isLeftView: true)
        self.tfPassword.ShadowTextField()
        
        self.btLogin.backgroundColor = UIColor.FlatColor.Oranges.BGColor
        self.btLogin = Settings.ShareInstance.setupButton(button: self.btLogin)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(touchRegister))
        self.lbRegister.isUserInteractionEnabled = true
        self.lbRegister.addGestureRecognizer(tap)
        
        self.tfUserName.text = "+84admin"
        self.tfPassword.text = "1234567890"
    }
    
    @IBAction func touchForgotPassword(_ sender: Any) {
        
    }
    
    func touchLogin(){
        UserManager.shareUserManager().loginUser(username: self.tfUserName.text!, password: self.tfPassword.text!) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                print("data = \(data)")
                Settings.ShareInstance.setDictUser(data: data)
                self.loginSuccess()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
//        UserManager.shareUserManager().loginUser(Phone: tfPhone.text!, Password: tfPassword.text!) { (response) in
//            switch response{
//            case .success(let data):
//                self.stopProgressUploadAndGetInfor()
//                data.Udid = Singleton.shared.getUDIDString()
//                Singleton.shared.setDictUser(data: data)
//                self.loginSuccess()
//
//                break
//            case .failure(let error):
//                self.stopProgressUploadAndGetInfor()
//                Singleton.shared.showAlertView(message: error, vc: self)
//                break
//            }
//        }
    }
    
    @objc func touchRegister(){
        let register = RegisterViewController()
        self.navigationController?.pushViewController(register, animated: true)
    }
    
    @IBAction func touchLogin(_ sender: Any) {
        self.showProgressHub()
        self.touchLogin()
//        self.loginSuccess()
    }
}
