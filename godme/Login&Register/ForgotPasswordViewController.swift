//
//  ForgotPasswordViewController.swift
//  godme
//
//  Created by Lê Hùng on 4/14/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

@objc enum typeCellForGot: Int {
    case Email = 0
    case PasswordNew = 1
    case ConfirmPassword = 2
    case OTP = 3
    case Complete = 4
}

class ForgotPasswordViewController: BaseViewController {

    @IBOutlet weak var tbvForgotPassword: UITableView!
    var listTypeCell: [typeCellForGot] = [.Email, .PasswordNew, .ConfirmPassword, .OTP, .Complete]
    var email: String = ""
    var modelForgot = ForgotPasswordParamsModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        modelForgot.username = email
        self.configButtonBack()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "label_reset_password")
    }
    
    func setupTableView(){
        self.tbvForgotPassword.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        self.tbvForgotPassword.register(UINib.init(nibName: "CompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteTableViewCell")
        self.tbvForgotPassword.delegate = self
        self.tbvForgotPassword.dataSource = self
        self.tbvForgotPassword.allowsSelection = false
        self.tbvForgotPassword.separatorColor = UIColor.clear
        self.tbvForgotPassword.separatorInset = UIEdgeInsets.zero
        
        self.tbvForgotPassword.rowHeight = UITableView.automaticDimension
        self.tbvForgotPassword.estimatedRowHeight = 300
    }
    
    func forgotPassword(model: forgotPasswordParams){
        UserManager.shareUserManager().forgotPassword(model: model) { [unowned self](response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: Settings.ShareInstance.translate(key: "label_change_password_successful"), vc: self) {[unowned self] (str) in
                    self.navigationController?.popViewController(animated: true)
                }
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
}

extension ForgotPasswordViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = listTypeCell[indexPath.row]
        switch type {
            
        case .Email:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.delegate = self
            cell.tfInput.tag = indexPath.row
            cell.tfInput.isUserInteractionEnabled = false
            cell.tfInput.text = modelForgot.username
            cell.lbTitle.text = "Email"
            return cell
        case .PasswordNew:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.tfInput.tag = indexPath.row
            cell.lbTitle.text = Settings.ShareInstance.translate(key: "label_new_password")
            cell.tfInput.placeholder = Settings.ShareInstance.translate(key: "label_new_password")
            cell.tfInput.isSecureTextEntry = true
            cell.delegate = self
            return cell
        case .ConfirmPassword:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.tfInput.tag = indexPath.row
            cell.delegate = self
            cell.lbTitle.text = Settings.ShareInstance.translate(key: "label_confirm_new_password")
            cell.tfInput.placeholder = Settings.ShareInstance.translate(key: "label_confirm_new_password")
            cell.tfInput.isSecureTextEntry = true
            return cell
        case .OTP:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.tfInput.tag = indexPath.row
            cell.lbTitle.text = Settings.ShareInstance.translate(key: "label_verify_otp")
            cell.tfInput.placeholder = Settings.ShareInstance.translate(key: "label_verify_otp")
            cell.delegate = self
            return cell
        case .Complete:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
            cell.delegate = self
            cell.btComplete.setTitle(Settings.ShareInstance.translate(key: "label_change"), for: .normal)
            return cell
        }
    }
}

extension ForgotPasswordViewController: TitleTableViewCellProtocol{
    func getTextForgotPassword(_ str: String, type: typeCellForGot) {
        switch type {
            
        case .Email:
            break
        case .PasswordNew:
            modelForgot.newPassword = str
            break
        case .ConfirmPassword:
            modelForgot.confirmPassword = str
            break
        case .OTP:
            modelForgot.codeOTP = str
            break
        case .Complete:
            break
        }
    }
}

extension ForgotPasswordViewController: CompleteTableViewCellProtocol{
    func didComplete() {
        if self.modelForgot.codeOTP.isEmpty ||
            self.modelForgot.newPassword.isEmpty ||
            self.modelForgot.username.isEmpty ||
            self.modelForgot.confirmPassword != self.modelForgot.newPassword {
            Settings.ShareInstance.showAlertView(message: Settings.ShareInstance.translate(key: "label_please_fill_in_full"), vc: self)
            return
        }
        self.showProgressHub()
        var model = forgotPasswordParams()
        model.codeOTP = self.modelForgot.codeOTP
        model.newPassword = self.modelForgot.newPassword
        model.username = self.modelForgot.username
        self.forgotPassword(model: model)
    }
}
