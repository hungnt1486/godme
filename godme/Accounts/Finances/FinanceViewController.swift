//
//  FinanceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

//enum typeCellFinance: Int {
//    case Title = 0
//    case Button1 = 1
//    case Button2 = 2
//    case Button3 = 3
//    case Button4 = 4
//}

class FinanceViewController: BaseViewController {

//    @IBOutlet weak var tbvFinance: UITableView!
//    var listTypeCell: [typeCellFinance] = [.Title, .Button1, .Button2, .Button3, .Button4]
    @IBOutlet weak var vMain: UIView!
    @IBOutlet weak var lbCoin: UILabel!
    @IBOutlet weak var lbInputCoin: UILabel!
    @IBOutlet weak var lbWithDraw: UILabel!
    @IBOutlet weak var lbHistory: UILabel!
    var myWallet: MyWalletModel?
    @IBOutlet weak var tbvFollow: CollapseTableView!
    var listMonthYear: [String] = []
    var History:HistoryModel?
    var HistoryCurrentDate:HistoryModel?
    var strCurrentDate: String = ""
    var sectionIndexOpen: Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yyyy"
        let date = Date.init()
        strCurrentDate = formatter.string(from: date)
        let arr = strCurrentDate.split(separator: "/")
        let month = Int(String(arr[0]))
        let year = Int(String(arr[1]))
        for i in 1..<12 {
            
            if (month! - i) <= 0{
                print(month! - i + 12)
                self.listMonthYear.append("\(month! - i + 12)/\(year! - 1)")
            }else{
                print(month! - i)
                self.listMonthYear.append("\(month! - i)/\(year!)")
            }
        }
        print(self.listMonthYear)
        

        // Do any additional setup after loading the view.
        self.showProgressHub()
        self.setupUI()
        self.setupTableview()
        
        self.tbvFollow.didTapSectionHeaderView = {[unowned self] (sectionIndex, isOpen) in
//            debugPrint("sectionIndex \(sectionIndex), isOpen \(isOpen)")

            if sectionIndex >= 2 {
                if self.sectionIndexOpen != -1 {
                    self.tbvFollow.closeSection(self.sectionIndexOpen, animated: false)
                    self.sectionIndexOpen = sectionIndex
                }else{
                    self.sectionIndexOpen = sectionIndex
                }
                let str = self.listMonthYear[sectionIndex - 2]
                let arr = str.split(separator: "/")
                let month = Int(String(arr[0]))
                let year = Int(String(arr[1]))
                self.getListHistory(month: month!, year: year!)
            }else{
                let arr = self.strCurrentDate.split(separator: "/")
                let month = Int(String(arr[0]))
                let year = Int(String(arr[1]))
                self.getListHistory(month: month!, year: year!, isCurrentDate: true)
            }
        }
        reloadTableView { [unowned self] in
            self.tbvFollow.openSection(0, animated: true)
            self.tbvFollow.openSection(1, animated: true)
        }
        
        self.configButtonBack()
        self.getMyWallet()
        self.getListHistory(month: month!, year: year!, isCurrentDate: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "wallet_finance")
    }
    
    func reloadTableView(_ completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            completion()
        })
        self.tbvFollow.reloadData()
        CATransaction.commit()
    }
    
    func setupUI(){
        self.tabBarController?.tabBar.isHidden = true
        self.vMain = Settings.ShareInstance.setupView(v: self.vMain)
        self.lbCoin = Settings.ShareInstance.setupBTLabelView(v: self.lbCoin)
        self.lbInputCoin.text = Settings.ShareInstance.translate(key: "input_godcoin")
        self.lbWithDraw.text = Settings.ShareInstance.translate(key: "withdraw")
        self.lbHistory.text = Settings.ShareInstance.translate(key: "find_history")
        
        let right = UIBarButtonItem.init(title: "đ<->Godcoin", style: .plain, target: self, action: #selector(touchRight))
        right.tintColor = UIColor.FlatColor.Oranges.BGColor
        self.navigationItem.rightBarButtonItem = right
    }
    
    func setupTableview(){
        self.tbvFollow.register(UINib(nibName: "FollowTableViewCell", bundle: nil), forCellReuseIdentifier: "FollowTableViewCell")
        self.tbvFollow.register(UINib.init(nibName: "SectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
        self.tbvFollow.register(UINib.init(nibName: "HeaderMyServices", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderMyServices")
        self.tbvFollow.delegate = self
        self.tbvFollow.dataSource = self
        self.tbvFollow.allowsSelection = false
        self.tbvFollow.estimatedRowHeight = 100
        self.tbvFollow.rowHeight = UITableView.automaticDimension
    }
    
    @objc func touchRight(){
        if (self.lbCoin.text?.contains("Godcoin"))! {
            self.lbCoin.text = Settings.ShareInstance.formatCurrency(Value: "\((Double(myWallet?.amount ?? "0") ?? 0)*1000)")
        }else{
            self.lbCoin.text = "\(Double(myWallet?.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
        }
        self.tbvFollow.reloadData()
    }
    
    func getMyWallet(){
        UserManager.shareUserManager().getMyWallet { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                self.myWallet = data[0]
                self.lbCoin.text = "\(Double(self.myWallet?.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    @IBAction func touchInputCoin(_ sender: Any) {
        let inputGodCoin = InputGodcoinViewController()
        self.navigationController?.pushViewController(inputGodCoin, animated: true)
    }
    
    @IBAction func touchWithDraw(_ sender: Any) {
        let withDraw = WithdrawViewController()
        self.navigationController?.pushViewController(withDraw, animated: true)
    }
    
    @IBAction func touchHistory(_ sender: Any) {
        let history = HistoryViewController()
        self.navigationController?.pushViewController(history, animated: true)
    }
    
    func getListHistory(month: Int, year: Int, isCurrentDate: Bool = false){
        UserManager.shareUserManager().getListHistory(month: month, year: year) {[unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                if isCurrentDate {
                    self.HistoryCurrentDate = data
                }else {
                    self.History = data
                }
                self.tbvFollow.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    
}

extension FinanceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listMonthYear.count + 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderView") as! SectionHeaderView
        view.vSub.backgroundColor = UIColor.white
        if section == 0 {
            view.vSub.backgroundColor = UIColor.FlatColor.Gray.BGColor
            view.lbTitle.text = "Tuần này"
        } else if section == 1 {
            view.vSub.backgroundColor = UIColor.FlatColor.Gray.BGColor
            view.lbTitle.text = "Tháng này"
        } else if section >= 2 {
            switch (section - 2) {
            case 0:
                view.lbTitle.text = self.listMonthYear[section - 2]
                break
            case 1:
                view.lbTitle.text = self.listMonthYear[section - 2]
                break
            case 2:
                view.lbTitle.text = self.listMonthYear[section - 2]
                break
            case 3:
                view.lbTitle.text = self.listMonthYear[section - 2]
                break
            case 4:
                view.lbTitle.text = self.listMonthYear[section - 2]
                break
            case 5:
                view.lbTitle.text = self.listMonthYear[section - 2]
                break
            case 6:
                view.lbTitle.text = self.listMonthYear[section - 2]
                break
            case 7:
                view.lbTitle.text = self.listMonthYear[section - 2]
                break
            case 8:
                view.lbTitle.text = self.listMonthYear[section - 2]
                break
            case 9:
                view.lbTitle.text = self.listMonthYear[section - 2]
                break
            case 10:
                view.lbTitle.text = self.listMonthYear[section - 2]
                break
            default:
                break
            }
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowTableViewCell") as! FollowTableViewCell
        cell.lbService.text = "0 Godcoin"
        cell.lbAuction.text = "0 Godcoin"
        cell.lbEvent.text = "0 Godcoin"
        cell.lbRelationShip.text = "0 Godcoin"
        cell.lbConnect.text = "0 Godcoin"
        if indexPath.section == 0 {
            let weeks = self.HistoryCurrentDate?.historyInWeek
            for item in weeks ?? [] {
                if item.serviceType == "BASIC" {
                    cell.lbService.text = item.totalAmount
                    if (cell.lbService.text?.contains("Godcoin"))! {
                        cell.lbService.text = Settings.ShareInstance.formatCurrency(Value: "\((Double(item.totalAmount ?? "0") ?? 0)*1000)")
                    }else{
                        cell.lbService.text = "\(Double(item.totalAmount ?? "0")?.formatnumber() ?? "0") Godcoin"
                    }
                    break
                }
            }
            return cell
        }else if indexPath.section == 1 {
            let months = self.HistoryCurrentDate?.historyInMonth
            for item in months ?? [] {
                if item.serviceType == "BASIC" {
                    cell.lbService.text = item.totalAmount
                    if (cell.lbService.text?.contains("Godcoin"))! {
                        cell.lbService.text = Settings.ShareInstance.formatCurrency(Value: "\((Double(item.totalAmount ?? "0") ?? 0)*1000)")
                    }else{
                        cell.lbService.text = "\(Double(item.totalAmount ?? "0")?.formatnumber() ?? "0") Godcoin"
                    }
                    break
                }
            }
            return cell
        }else if indexPath.section == 2 {
            let months = self.History?.historyInMonth
            for item in months ?? [] {
                if item.serviceType == "BASIC" {
                    cell.lbService.text = item.totalAmount
                    if (cell.lbService.text?.contains("Godcoin"))! {
                        cell.lbService.text = Settings.ShareInstance.formatCurrency(Value: "\((Double(item.totalAmount ?? "0") ?? 0)*1000)")
                    }else{
                        cell.lbService.text = "\(Double(item.totalAmount ?? "0")?.formatnumber() ?? "0") Godcoin"
                    }
                    break
                }
            }
            return cell
        }else if indexPath.section == 3 {
            let months = self.History?.historyInMonth
            for item in months ?? [] {
                if item.serviceType == "BASIC" {
                    cell.lbService.text = item.totalAmount
                    if (cell.lbService.text?.contains("Godcoin"))! {
                        cell.lbService.text = Settings.ShareInstance.formatCurrency(Value: "\((Double(item.totalAmount ?? "0") ?? 0)*1000)")
                    }else{
                        cell.lbService.text = "\(Double(item.totalAmount ?? "0")?.formatnumber() ?? "0") Godcoin"
                    }
                    break
                }
            }
            return cell
        }else if indexPath.section == 4 {
            let months = self.History?.historyInMonth
            for item in months ?? [] {
                if item.serviceType == "BASIC" {
                    cell.lbService.text = item.totalAmount
                    if (cell.lbService.text?.contains("Godcoin"))! {
                        cell.lbService.text = Settings.ShareInstance.formatCurrency(Value: "\((Double(item.totalAmount ?? "0") ?? 0)*1000)")
                    }else{
                        cell.lbService.text = "\(Double(item.totalAmount ?? "0")?.formatnumber() ?? "0") Godcoin"
                    }
                    break
                }
            }
            return cell
        }else if indexPath.section == 5 {
            let months = self.History?.historyInMonth
            for item in months ?? [] {
                if item.serviceType == "BASIC" {
                    cell.lbService.text = item.totalAmount
                    if (cell.lbService.text?.contains("Godcoin"))! {
                        cell.lbService.text = Settings.ShareInstance.formatCurrency(Value: "\((Double(item.totalAmount ?? "0") ?? 0)*1000)")
                    }else{
                        cell.lbService.text = "\(Double(item.totalAmount ?? "0")?.formatnumber() ?? "0") Godcoin"
                    }
                    break
                }
            }
            return cell
        }else if indexPath.section == 6 {
            let months = self.History?.historyInMonth
            for item in months ?? [] {
                if item.serviceType == "BASIC" {
                    cell.lbService.text = item.totalAmount
                    if (cell.lbService.text?.contains("Godcoin"))! {
                        cell.lbService.text = Settings.ShareInstance.formatCurrency(Value: "\((Double(item.totalAmount ?? "0") ?? 0)*1000)")
                    }else{
                        cell.lbService.text = "\(Double(item.totalAmount ?? "0")?.formatnumber() ?? "0") Godcoin"
                    }
                    break
                }
            }
            return cell
        }else if indexPath.section == 7 {
            let months = self.History?.historyInMonth
            for item in months ?? [] {
                if item.serviceType == "BASIC" {
                    cell.lbService.text = item.totalAmount
                    if (cell.lbService.text?.contains("Godcoin"))! {
                        cell.lbService.text = Settings.ShareInstance.formatCurrency(Value: "\((Double(item.totalAmount ?? "0") ?? 0)*1000)")
                    }else{
                        cell.lbService.text = "\(Double(item.totalAmount ?? "0")?.formatnumber() ?? "0") Godcoin"
                    }
                    break
                }
            }
            return cell
        }else if indexPath.section == 8 {
            let months = self.History?.historyInMonth
            for item in months ?? [] {
                if item.serviceType == "BASIC" {
                    cell.lbService.text = item.totalAmount
                    if (cell.lbService.text?.contains("Godcoin"))! {
                        cell.lbService.text = Settings.ShareInstance.formatCurrency(Value: "\((Double(item.totalAmount ?? "0") ?? 0)*1000)")
                    }else{
                        cell.lbService.text = "\(Double(item.totalAmount ?? "0")?.formatnumber() ?? "0") Godcoin"
                    }
                    break
                }
            }
            return cell
        }else if indexPath.section == 9 {
            let months = self.History?.historyInMonth
            for item in months ?? [] {
                if item.serviceType == "BASIC" {
                    cell.lbService.text = item.totalAmount
                    if (cell.lbService.text?.contains("Godcoin"))! {
                        cell.lbService.text = Settings.ShareInstance.formatCurrency(Value: "\((Double(item.totalAmount ?? "0") ?? 0)*1000)")
                    }else{
                        cell.lbService.text = "\(Double(item.totalAmount ?? "0")?.formatnumber() ?? "0") Godcoin"
                    }
                    break
                }
            }
            return cell
        }else if indexPath.section == 10 {
            let months = self.History?.historyInMonth
            for item in months ?? [] {
                if item.serviceType == "BASIC" {
                    cell.lbService.text = item.totalAmount
                    if (cell.lbService.text?.contains("Godcoin"))! {
                        cell.lbService.text = Settings.ShareInstance.formatCurrency(Value: "\((Double(item.totalAmount ?? "0") ?? 0)*1000)")
                    }else{
                        cell.lbService.text = "\(Double(item.totalAmount ?? "0")?.formatnumber() ?? "0") Godcoin"
                    }
                    break
                }
            }
            return cell
        }else if indexPath.section == 11 {
            let months = self.History?.historyInMonth
            for item in months ?? [] {
                if item.serviceType == "BASIC" {
                    cell.lbService.text = item.totalAmount
                    if (cell.lbService.text?.contains("Godcoin"))! {
                        cell.lbService.text = Settings.ShareInstance.formatCurrency(Value: "\((Double(item.totalAmount ?? "0") ?? 0)*1000)")
                    }else{
                        cell.lbService.text = "\(Double(item.totalAmount ?? "0")?.formatnumber() ?? "0") Godcoin"
                    }
                    break
                }
            }
            return cell
        }else{
            let months = self.History?.historyInMonth
            for item in months ?? [] {
                if item.serviceType == "BASIC" {
                    cell.lbService.text = item.totalAmount
                    if (cell.lbService.text?.contains("Godcoin"))! {
                        cell.lbService.text = Settings.ShareInstance.formatCurrency(Value: "\((Double(item.totalAmount ?? "0") ?? 0)*1000)")
                    }else{
                        cell.lbService.text = "\(Double(item.totalAmount ?? "0")?.formatnumber() ?? "0") Godcoin"
                    }
                    break
                }
            }
            return cell
        }
    }
    
    
}

//extension FinanceViewController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listTypeCell.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let typeCell = listTypeCell[indexPath.row]
//        switch typeCell {
//
//        case .Title:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceTitleTableViewCell") as! FinanceTitleTableViewCell
//
//            return cell
//        case .Button1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceOrangesButtonTableViewCell") as! FinanceOrangesButtonTableViewCell
//            cell.btOranges.setTitle(Settings.ShareInstance.translate(key: "input_godcoin"), for: .normal)
//            cell.btOranges.tag = indexPath.row
//            cell.delegate = self
//            return cell
//        case .Button2:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceBlueButtonTableViewCell") as! FinanceBlueButtonTableViewCell
//            cell.btBlue.setTitle(Settings.ShareInstance.translate(key: "withdraw"), for: .normal)
//            cell.btBlue.tag = indexPath.row
//            cell.delegate = self
//            return cell
//        case .Button3:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceOrangesButtonTableViewCell") as! FinanceOrangesButtonTableViewCell
//            cell.btOranges.setTitle(Settings.ShareInstance.translate(key: "find_history"), for: .normal)
//            cell.btOranges.tag = indexPath.row
//            cell.delegate = self
//            return cell
//        case .Button4:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceBlueButtonTableViewCell") as! FinanceBlueButtonTableViewCell
//            cell.btBlue.setTitle(Settings.ShareInstance.translate(key: "follow_table"), for: .normal)
//            cell.btBlue.tag = indexPath.row
//            cell.delegate = self
//            return cell
//        }
//    }
//}
//
//extension FinanceViewController: FinanceBlueButtonTableViewCellProtocol{
//    func didButtonBlue(type: typeCellFinance) {
//        switch type {
//        case .Button2:
//            let withDraw = WithdrawViewController()
//            self.navigationController?.pushViewController(withDraw, animated: true)
//            break
//        case .Button4:
//            let follow = FollowTableViewController()
//            self.navigationController?.pushViewController(follow, animated: true)
//            break
//        case .Title:
//            break
//        case .Button1:
//            break
//        case .Button3:
//            break
//        }
//    }
//}
//
//extension FinanceViewController: FinanceOrangesButtonTableViewCellProtocol{
//    func didButtonOranges(type: typeCellFinance) {
//        switch type {
//        case .Button1:
//            let inputGodCoin = InputGodcoinViewController()
//            self.navigationController?.pushViewController(inputGodCoin, animated: true)
//            break
//        case .Button3:
//            let history = HistoryViewController()
//            self.navigationController?.pushViewController(history, animated: true)
//            break
//        case .Title:
//            break
//        case .Button2:
//            break
//        case .Button4:
//            break
//        }
//    }
//
//}
