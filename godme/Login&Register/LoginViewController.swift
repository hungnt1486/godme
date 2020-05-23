//
//  LoginViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/4/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import FirebaseUI

class LoginViewController: BaseViewController {

    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btForgotPassword: UIButton!
    @IBOutlet weak var btLogin: UIButton!
    @IBOutlet weak var lbRegister: UILabel!
    var status = ""
    var type = 0
    var alertController = UIAlertController()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        if status == "" {
            self.getListJobsMain()
        }
        self.configButtonBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "login")
        if status == "logout" {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem()
            self.status = ""
        }
    }
    
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = UIColor.FlatColor.Gray.BGColor
        self.btForgotPassword.setTitle(Settings.ShareInstance.translate(key: "label_forgot_password"), for: .normal)
        self.btLogin.setTitle(Settings.ShareInstance.translate(key: "label_sign_in"), for: .normal)
        
        self.tfUserName = Settings.ShareInstance.setupTextField(textField: self.tfUserName, isLeftView: true)
        self.tfUserName.ShadowTextField()
        
        self.tfPassword = Settings.ShareInstance.setupTextField(textField: self.tfPassword, isLeftView: true)
        self.tfPassword.ShadowTextField()
        
        self.btLogin.backgroundColor = UIColor.FlatColor.Oranges.BGColor
        self.btLogin = Settings.ShareInstance.setupButton(button: self.btLogin)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(touchRegister))
        self.lbRegister.isUserInteractionEnabled = true
        self.lbRegister.addGestureRecognizer(tap)
        
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Roboto-regular", size: 18.0), NSAttributedString.Key.foregroundColor : UIColor.FlatColor.Blue.BGColor]
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Roboto-regular", size: 17.0), NSAttributedString.Key.foregroundColor : UIColor.black]
        let str = Settings.ShareInstance.translate(key: "you_dont_account")
        let arr = str.split(separator: "?")
        let attr1 = NSMutableAttributedString(string: String(arr[1]), attributes: attrs1 as [NSAttributedString.Key : Any])
        let attr2 = NSMutableAttributedString(string: String(arr[0] + "?"), attributes: attrs2 as [NSAttributedString.Key : Any])
        attr2.append(attr1)
        self.lbRegister.attributedText = attr2
//        self.tfUserName.text = "0913571105"//"+84admin"
//        self.tfPassword.text = "Toan1789"//"1234567890"
    }
    
    @IBAction func touchForgotPassword(_ sender: Any) {
        alertController = UIAlertController.init(title: Settings.ShareInstance.translate(key: "label_reset_password"), message: "", preferredStyle: .alert)
                alertController.addTextField { (textField) in
                    textField.placeholder = "Email"
                }
            
        let actionOk = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_ok"), style: .default) { [unowned self](action) in
                    self.alertController.dismiss(animated: true, completion: nil)
                    let firstTextField = self.alertController.textFields![0] as UITextField
                    if firstTextField.text!.isEmpty {
                        Settings.ShareInstance.showAlertView(message: Settings.ShareInstance.translate(key: "label_please_input_email"), vc: self)
                        
                    }else{
//                        let otpPhone = OTPPhone(target: self)
//                        otpPhone.signInPhone(phone: firstTextField.text ?? "")
                        self.showProgressHub()
                        self.sendOTPForgotPassword(email: firstTextField.text ?? "")
                    }
                }
        let actionCancel = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_cancel"), style: .cancel) {[unowned self] (action) in
                    self.alertController.dismiss(animated: true, completion: nil)
                }
                alertController.addAction(actionOk)
                alertController.addAction(actionCancel)
                self.present(alertController, animated: true, completion: nil)
    }
    
    func sendOTPForgotPassword(email: String){
        UserManager.shareUserManager().sendOTPForgotPassword(email: email) { (response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                let forgot = ForgotPasswordViewController()
                forgot.email = email
                self.navigationController?.pushViewController(forgot, animated: true)
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func touchLogin(){
        let myNSRange = NSRange(location: 0, length: 1)
        var strUserName = self.tfUserName.text?.replacingOccurrences(of: "0", with: "+84", options: .literal, range: Range.init(myNSRange, in: self.tfUserName.text ?? ""))
        if !(strUserName?.contains("+84"))! {
           strUserName = "+84\(strUserName ?? "")"
        }
        UserManager.shareUserManager().loginUser(username: strUserName ?? "", password: self.tfPassword.text!) { [unowned self](response) in
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
//        let register = RegisterViewController()
//        self.navigationController?.pushViewController(register, animated: true)
        self.type = 1
        let otpPhone = OTPPhone(target: self)
        otpPhone.signInPhone(phone: "")
    }
    
    @IBAction func touchLogin(_ sender: Any) {
        self.showProgressHub()
        self.touchLogin()
//        self.loginSuccess()
    }
}

extension LoginViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if error == nil {
            let phoneNumber = user?.phoneNumber
            // for case forgot password
            if self.type == 0 {
                if let phoneNum = phoneNumber?.replacingOccurrences(of: "+84", with: "0"), !phoneNum.isEmpty{
                    self.dismiss(animated: true, completion: nil)
//                    self.configProgressUploadAndGetInfor(uiView: self.view)
//                    BaseViewController.spinner.startAnimating()
//                    let password = self.alertController.textFields![1] as UITextField
//                    UserManager.shareUserManager().userResetPassword(Phone: phoneNum, Password: password.text ?? "") { (response) in
//                        switch response {
//
//                        case .success(let data):
//                            self.stopProgressUploadAndGetInfor()
//                            Singleton.shared.showAlertView(message: "Chúc mừng bạn đã tạo mật khẩu mới thành công", vc: self) { [unowned self] (nil) in
//                                Singleton.shared.setDictUser(data: data)
//
//                                let model = Singleton.shared.getDictUser()
//                                BaseViewController.accessToken = model.Token ?? ""
//                                UserManager.shareUserManager().autoLogin { (response) in
//                                    switch response {
//
//                                    case .success(let data):
//                                        self.stopProgressUploadAndGetInfor()
//                                        data.Udid = Singleton.shared.getUDIDString()
//                                        Singleton.shared.setDictUser(data: data)
//                                        self.loginSuccess()
//                                        break
//                                    case .failure(let message):
//                                        self.stopProgressUploadAndGetInfor()
//                                        Singleton.shared.showAlertView(message: message, vc: self)
//                                        break
//                                    }
//                                }
//                            }
//                            break
//                        case .failure(let message):
//                            BaseViewController.spinner.stopAnimating()
//                            Singleton.shared.showAlertView(message: message, vc: self)
//                            break
//                        }
//                    }
                }
            }else {
                if !(phoneNumber?.isEmpty ?? true){
                    self.dismiss(animated: true, completion: nil)
                    let register = RegisterViewController()
                    register.phoneNumber = phoneNumber ?? ""
                    self.navigationController?.pushViewController(register, animated: true)
//                    UserManager.shareUserManager().registerUser(UserName: "", Phone: phoneNum, FullName: self.tfFullName.text ?? "", Password: self.tfPassword.text ?? "", Language: "vi") { [unowned self] (response) in
//                        switch response {
//
//
//                        case .success(let data):
//                            self.stopProgressUploadAndGetInfor()
//                            Singleton.shared.showAlertView(message: "Chúc mừng bạn đã đăng ký thành công", vc: self) { [unowned self] (nil) in
//                                data.Udid = Singleton.shared.getUDIDString()
//                                Singleton.shared.setDictUser(data: data)
//                                self.loginSuccess()
//                            }
//                            break
//                        case .failure(let error):
//                            self.stopProgressUploadAndGetInfor()
//                            Singleton.shared.showAlertView(message: error, vc: self)
//                            break
//                        }
//                    }
                }
            }
        }
    }
}
