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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
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
    }
    
    @IBAction func touchForgotPassword(_ sender: Any) {
    }
    
    @IBAction func touchLogin(_ sender: Any) {
    }
}
