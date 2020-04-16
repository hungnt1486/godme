//
//  ChangePasswordViewController.swift
//  godme
//
//  Created by Lê Hùng on 4/16/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

@objc enum typeCellChangePassword: Int {
    case PasswordOld = 0
    case PasswordNew = 1
    case PasswordConfirm = 2
    case Confirm = 3
}

class ChangePasswordViewController: BaseViewController {

    @IBOutlet weak var tbvChangePassword: UITableView!
    var listTypeCell: [typeCellChangePassword] = [.PasswordOld, .PasswordNew, .PasswordConfirm, .Confirm]
    var changePasswordModel = ChangePasswordParamsModel()
    var modelUser = Settings.ShareInstance.getDictUser()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configButtonBack()
        self.setupUI()
        self.setupTableView()
    }
    
    func setupUI(){
        self.navigationItem.title = Settings.ShareInstance.translate(key: "change_password")
    }
    
    func setupTableView(){
        self.tbvChangePassword.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        self.tbvChangePassword.register(UINib(nibName: "CompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteTableViewCell")

        self.tbvChangePassword.delegate = self
        self.tbvChangePassword.dataSource = self
        self.tbvChangePassword.separatorColor = UIColor.clear
        self.tbvChangePassword.separatorInset = UIEdgeInsets.zero
        
        self.tbvChangePassword.rowHeight = UITableView.automaticDimension
        self.tbvChangePassword.estimatedRowHeight = 300
    }
    
    func changePassword(model: changePasswordParams){
        UserManager.shareUserManager().changePassword(model: model) { [unowned self](response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: "Mật khẩu của bạn đã thay đổi thành công", vc: self) {[unowned self] (str) in
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

extension ChangePasswordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = listTypeCell[indexPath.row]
        switch type {
            
        case .PasswordOld:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.delegate = self
            cell.lbTitle.text = "Mật khẩu cũ"
            cell.tfInput.placeholder = "Mật khẩu cũ"
            cell.tfInput.tag = indexPath.row
            cell.tfInput.isSecureTextEntry = true
            return cell
        case .PasswordNew:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.delegate = self
            cell.lbTitle.text = "Mật khẩu mới"
            cell.tfInput.placeholder = "Mật khẩu mới"
            cell.tfInput.tag = indexPath.row
            cell.tfInput.isSecureTextEntry = true
            return cell
        case .PasswordConfirm:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.delegate = self
            cell.lbTitle.text = "Nhập lại mật khẩu mới"
            cell.tfInput.placeholder = "Nhập lại mật khẩu mới"
            cell.tfInput.tag = indexPath.row
            cell.tfInput.isSecureTextEntry = true
            return cell
        case .Confirm:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
            cell.delegate = self
            cell.btComplete.setTitle("Thay đổi", for: .normal)
            return cell
        }
    }
}

extension ChangePasswordViewController: TitleTableViewCellProtocol{
    func getTextChangePassword(_ str: String, type: typeCellChangePassword) {
        switch type {
            
        case .PasswordOld:
            self.changePasswordModel.oldPassword = str
            break
        case .PasswordNew:
            self.changePasswordModel.newPassword = str
            break
        case .PasswordConfirm:
            self.changePasswordModel.confirmPassword = str
            break
        case .Confirm:
            break
        }
    }
}

extension ChangePasswordViewController: CompleteTableViewCellProtocol{
    func didComplete() {
        if self.changePasswordModel.oldPassword.isEmpty ||
            self.changePasswordModel.newPassword.isEmpty ||
            self.changePasswordModel.confirmPassword.isEmpty ||
            self.changePasswordModel.newPassword != self.changePasswordModel.confirmPassword {
            Settings.ShareInstance.showAlertView(message: "Vui lòng điền đầy đủ thông tin", vc: self)
            return
        }
        var model = changePasswordParams()
        model.username = modelUser.userName
        model.newPassword = self.changePasswordModel.newPassword
        model.password = self.changePasswordModel.oldPassword
        self.showProgressHub()
        self.changePassword(model: model)
    }
}
