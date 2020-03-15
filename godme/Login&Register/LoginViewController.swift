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
        if status == "logout" {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        }
    }
    
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = UIColor.FlatColor.Gray.BGColor
        self.tfUserName = Settings.ShareInstance.setupTextField(textField: self.tfUserName)
        self.tfUserName.ShadowTextField()
        
        self.tfPassword = Settings.ShareInstance.setupTextField(textField: self.tfPassword)
        self.tfPassword.ShadowTextField()
        
        self.btLogin.backgroundColor = UIColor.FlatColor.Oranges.BGColor
        self.btLogin = Settings.ShareInstance.setupButton(button: self.btLogin)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(touchRegister))
        self.lbRegister.isUserInteractionEnabled = true
        self.lbRegister.addGestureRecognizer(tap)
    }
    
    @IBAction func touchForgotPassword(_ sender: Any) {
        
    }
    
    @objc func touchRegister(){
        let register = RegisterViewController()
        self.navigationController?.pushViewController(register, animated: true)
    }
    
    @IBAction func touchLogin(_ sender: Any) {
        
        self.loginSuccess()
    }
}
