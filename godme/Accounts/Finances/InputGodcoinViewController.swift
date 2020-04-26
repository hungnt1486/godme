//
//  InputGodcoinViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

enum cellTypeInputGodcoid: Int{
    case Label1 = 0
    case Label2 = 1
}

class InputGodcoinViewController: BaseViewController {

    @IBOutlet weak var tbvInputGodcoin: UITableView!
    var listTypeCell:[cellTypeInputGodcoid] = [.Label1, .Label2]
    var modelUser = Settings.ShareInstance.getDictUser()
    
    var imageBank = [["icon":"ic_vcb", "bank_name": "Vietcombank", "fullname": "NGUYEN HUU TOAN", "number": "0021000347653", "branch" : "Hà nội"],
                     ["icon":"ic_acb", "bank_name": "ACB", "fullname": "NGUYEN HUU TOAN", "number": "7366517", "branch" : "Hồ Chí Minh"],
                     ["icon":"ic_vietinbank", "bank_name": "Vietinbank", "fullname": "NGUYEN HUU TOAN", "number": "103000488420", "branch" : "Chương Dương, Hà Nội"],
                     ["icon":"ic_techcombank", "bank_name": "Techcombank", "fullname": "NGUYEN HUU TOAN", "number": "19033992025014", "branch" : "Hồ Chí Minh"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupTableView()
        self.configButtonBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "label_deposit")
    }
    
    func setupTableView(){
        self.tbvInputGodcoin.register(UINib(nibName: "InputGodcoinLabel1TableViewCell", bundle: nil), forCellReuseIdentifier: "InputGodcoinLabel1TableViewCell")
        self.tbvInputGodcoin.register(UINib(nibName: "InputGodcoinLabel2TableViewCell", bundle: nil), forCellReuseIdentifier: "InputGodcoinLabel2TableViewCell")
        self.tbvInputGodcoin.register(UINib(nibName: "CompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteTableViewCell")
        self.tbvInputGodcoin.register(UINib(nibName: "BankTableViewCell", bundle: nil), forCellReuseIdentifier: "BankTableViewCell")

        self.tbvInputGodcoin.delegate = self
        self.tbvInputGodcoin.dataSource = self
        self.tbvInputGodcoin.allowsSelection = false
        self.tbvInputGodcoin.separatorColor = UIColor.clear
        self.tbvInputGodcoin.separatorInset = UIEdgeInsets.zero
        self.tbvInputGodcoin.estimatedRowHeight = 100
        self.tbvInputGodcoin.rowHeight = UITableView.automaticDimension
    }
    
    func createRequestPayin(){
        UserManager.shareUserManager().createRequestPayIn { [unowned self](response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: Settings.ShareInstance.translate(key: "msg_request_withdraw_success"), vc: self)
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }

}

extension InputGodcoinViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return listTypeCell.count
        }else if section == 1 {
            return imageBank.count
        }else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let typeCell = listTypeCell[indexPath.row]
            switch typeCell {
            case .Label1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InputGodcoinLabel1TableViewCell") as! InputGodcoinLabel1TableViewCell
                cell.lbCode.text = "NAP \(modelUser.userName ?? "")"
                return cell
            
            case .Label2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InputGodcoinLabel2TableViewCell") as! InputGodcoinLabel2TableViewCell
                return cell
            }
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BankTableViewCell") as! BankTableViewCell
            let model = imageBank[indexPath.row]
            cell.imgAvatar.image = UIImage.init(named: model["icon"]!)
            cell.lbTitle.text = "\(Settings.ShareInstance.translate(key: "account_name")): \(model["fullname"] ?? "")"
            cell.lbTime.text = "\(Settings.ShareInstance.translate(key: "bank_name")): \(model["bank_name"] ?? "")"
            cell.lbCity.text = "\(Settings.ShareInstance.translate(key: "account_number")): \(model["number"] ?? "")"
            cell.lbName.text = "\(Settings.ShareInstance.translate(key: "branch")): \(model["branch"] ?? "")"
            cell.lbCoin.text = "\(Settings.ShareInstance.translate(key: "label_content")): NAP \(modelUser.userName ?? "")"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
            cell.delegate = self
            cell.btComplete.setTitle(Settings.ShareInstance.translate(key: "msg_request_send_recharge_godcoin_success"), for: .normal)
            return cell

        }
    }
}

extension InputGodcoinViewController: CompleteTableViewCellProtocol{
    func didComplete() {
        self.showProgressHub()
        self.createRequestPayin()
    }
}
