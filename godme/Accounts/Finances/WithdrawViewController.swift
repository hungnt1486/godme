//
//  WithdrawViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

enum typeCellWithDraw: Int{
    case Label1 = 0
    case Label2 = 1
    case Label3 = 2
    case Label4 = 3
    case Label5 = 4
    case Button6 = 5
}

class WithdrawViewController: BaseViewController {

    @IBOutlet weak var tbvWithDraw: UITableView!
    var listTypeCell: [typeCellWithDraw] = [.Label1, .Label2, .Label3, .Label4, .Label5, .Button6]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupTableView()
        self.configButtonBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "label_withdraw")
    }
    
    func setupTableView(){
        self.tbvWithDraw.register(UINib(nibName: "WithDraw1TableViewCell", bundle: nil), forCellReuseIdentifier: "WithDraw1TableViewCell")
        self.tbvWithDraw.register(UINib(nibName: "WithDrawLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "WithDrawLabelTableViewCell")
        self.tbvWithDraw.register(UINib(nibName: "WithDrawButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "WithDrawButtonTableViewCell")

        self.tbvWithDraw.delegate = self
        self.tbvWithDraw.dataSource = self
        self.tbvWithDraw.allowsSelection = false
        self.tbvWithDraw.separatorColor = UIColor.clear
        self.tbvWithDraw.separatorInset = UIEdgeInsets.zero
        self.tbvWithDraw.estimatedRowHeight = 100
        self.tbvWithDraw.rowHeight = UITableView.automaticDimension
    }
    
}

extension WithdrawViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let typeCell = listTypeCell[indexPath.row]
        switch typeCell {
        
        case .Label1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WithDraw1TableViewCell") as! WithDraw1TableViewCell
            cell.tfInput.tag = indexPath.row
            cell.lbTitle.text = Settings.ShareInstance.translate(key: "withdraw_money")
            cell.tfInput.placeholder = Settings.ShareInstance.translate(key: "withdraw_money")
            cell.delegate = self
            return cell
        case .Label2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WithDraw1TableViewCell") as! WithDraw1TableViewCell
            cell.tfInput.tag = indexPath.row
            cell.lbTitle.text = Settings.ShareInstance.translate(key: "bank_name")
            cell.tfInput.placeholder = Settings.ShareInstance.translate(key: "bank_name")
            cell.delegate = self
            return cell
        case .Label3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WithDraw1TableViewCell") as! WithDraw1TableViewCell
            cell.tfInput.tag = indexPath.row
            cell.lbTitle.text = Settings.ShareInstance.translate(key: "branch")
            cell.tfInput.placeholder = Settings.ShareInstance.translate(key: "branch")
            cell.delegate = self
            return cell
        case .Label4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WithDraw1TableViewCell") as! WithDraw1TableViewCell
            cell.tfInput.tag = indexPath.row
            cell.lbTitle.text = Settings.ShareInstance.translate(key: "account_name")
            cell.tfInput.placeholder = Settings.ShareInstance.translate(key: "account_name")
            cell.delegate = self
            return cell
        case .Label5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WithDrawLabelTableViewCell") as! WithDrawLabelTableViewCell
            cell.lbTitle.text = Settings.ShareInstance.translate(key: "label_withdraw_warning")
            return cell
        case .Button6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WithDrawButtonTableViewCell") as! WithDrawButtonTableViewCell
            cell.btConfirm.tag = indexPath.row
            cell.btConfirm.setTitle(Settings.ShareInstance.translate(key: "confirm"), for: .normal)
            cell.delegate = self
            return cell
        }
    }
}

extension WithdrawViewController: WithDraw1TableViewCellProtocol{
    func getTextWithDraw(_ text: String, type: typeCellWithDraw) {
        switch type {
        case .Label1:
            break
        case .Label2:
            break
        case .Label3:
            break
        case .Label4:
            break
        case .Label5:
            break
        case .Button6:
            break
        }
    }
    
    
}

extension WithdrawViewController: WithDrawButtonTableViewCellProtocol{
    func didConfirm(type: typeCellWithDraw) {
        switch type {
            
        case .Label1:
            break
        case .Label2:
            break
        case .Label3:
            break
        case .Label4:
            break
        case .Label5:
            break
        case .Button6:
            Settings.ShareInstance.showAlertView(message: "Thành công", vc: self)
            break
        }
    }
    
    
}


