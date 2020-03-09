//
//  FinanceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import Localize_Swift

enum typeCellFinance: Int {
    case Title = 0
    case Button1 = 1
    case Button2 = 2
    case Button3 = 3
    case Button4 = 4
}

class FinanceViewController: BaseViewController {

    @IBOutlet weak var tbvFinance: UITableView!
    var listTypeCell: [typeCellFinance] = [.Title, .Button1, .Button2, .Button3, .Button4]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.configButtonBack()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "wallet_finance".localized()
    }
    
    func setupUI(){
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setupTableView(){
        self.tbvFinance.register(UINib(nibName: "FinanceTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceTitleTableViewCell")
        self.tbvFinance.register(UINib(nibName: "FinanceOrangesButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceOrangesButtonTableViewCell")
        self.tbvFinance.register(UINib(nibName: "FinanceBlueButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceBlueButtonTableViewCell")

        self.tbvFinance.delegate = self
        self.tbvFinance.dataSource = self
        self.tbvFinance.allowsSelection = false
        self.tbvFinance.separatorColor = UIColor.clear
        self.tbvFinance.separatorInset = UIEdgeInsets.zero

    }
}

extension FinanceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let typeCell = listTypeCell[indexPath.row]
        switch typeCell {
            
        case .Title:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceTitleTableViewCell") as! FinanceTitleTableViewCell
            
            return cell
        case .Button1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceOrangesButtonTableViewCell") as! FinanceOrangesButtonTableViewCell
            cell.btOranges.setTitle("input_godcoin".localized(), for: .normal)
            cell.btOranges.tag = indexPath.row
            cell.delegate = self
            return cell
        case .Button2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceBlueButtonTableViewCell") as! FinanceBlueButtonTableViewCell
            cell.btBlue.setTitle("withdraw".localized(), for: .normal)
            cell.btBlue.tag = indexPath.row
            cell.delegate = self
            return cell
        case .Button3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceOrangesButtonTableViewCell") as! FinanceOrangesButtonTableViewCell
            cell.btOranges.setTitle("find_history".localized(), for: .normal)
            cell.btOranges.tag = indexPath.row
            cell.delegate = self
            return cell
        case .Button4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceBlueButtonTableViewCell") as! FinanceBlueButtonTableViewCell
            cell.btBlue.setTitle("follow_table".localized(), for: .normal)
            cell.btBlue.tag = indexPath.row
            cell.delegate = self
            return cell
        }
    }
}

extension FinanceViewController: FinanceBlueButtonTableViewCellProtocol{
    func didButtonBlue(type: typeCellFinance) {
        switch type {
        case .Button2:
            let withDraw = WithdrawViewController()
            self.navigationController?.pushViewController(withDraw, animated: true)
            break
        case .Button4:
            let follow = FollowTableViewController()
            self.navigationController?.pushViewController(follow, animated: true)
            break
        case .Title:
            break
        case .Button1:
            break
        case .Button3:
            break
        }
    }
}

extension FinanceViewController: FinanceOrangesButtonTableViewCellProtocol{
    func didButtonOranges(type: typeCellFinance) {
        switch type {
        case .Button1:
            let inputGodCoin = InputGodcoinViewController()
            self.navigationController?.pushViewController(inputGodCoin, animated: true)
            break
        case .Button3:
            let history = HistoryViewController()
            self.navigationController?.pushViewController(history, animated: true)
            break
        case .Title:
            break
        case .Button2:
            break
        case .Button4:
            break
        }
    }
    
}
