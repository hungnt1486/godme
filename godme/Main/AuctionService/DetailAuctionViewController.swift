//
//  DetailAuctionViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/10/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

enum typeCellDetailAuction: Int {
    case Avatar = 0
    case Auction = 1
    case Address = 2
    case Detail = 3
//    case Book = 3
}

class DetailAuctionViewController: BaseViewController {

    @IBOutlet weak var tbvDetailAuction: UITableView!
    var listTypeCell: [typeCellDetailAuction] = [.Avatar, .Auction, .Address, .Detail]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupTableView()
        self.configButtonBack()
    }
    
    func setupUI(){
        
    }
    
    func setupTableView(){
        self.tbvDetailAuction.register(UINib(nibName: "ImageDetailAuctionTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageDetailAuctionTableViewCell")
        self.tbvDetailAuction.register(UINib(nibName: "InfoAuctionTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoAuctionTableViewCell")
        self.tbvDetailAuction.register(UINib(nibName: "TimeAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "TimeAddressTableViewCell")
        self.tbvDetailAuction.register(UINib(nibName: "InfoDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoDetailTableViewCell")
        self.tbvDetailAuction.register(UINib(nibName: "Main1TableViewCell", bundle: nil), forCellReuseIdentifier: "Main1TableViewCell")
        self.tbvDetailAuction.register(UINib.init(nibName: "HeaderSubMain", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderSubMain")
        self.tbvDetailAuction.delegate = self
        self.tbvDetailAuction.dataSource = self
        self.tbvDetailAuction.separatorColor = UIColor.clear
        self.tbvDetailAuction.separatorInset = UIEdgeInsets.zero
        self.tbvDetailAuction.estimatedRowHeight = 300
        self.tbvDetailAuction.rowHeight = UITableView.automaticDimension
    }
}

extension DetailAuctionViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return listTypeCell.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 130
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderSubMain") as! HeaderSubMain
            header.backgroundColor = UIColor.FlatColor.Gray.BGColor
            header.btMore.isHidden = true
            header.lbTitle.text = "Các đấu giá khác"
            return header
        }
        return UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let typeCell = listTypeCell[indexPath.row]
            
            switch typeCell {
                
            case .Avatar:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ImageDetailAuctionTableViewCell") as! ImageDetailAuctionTableViewCell
                cell.arrImageBanner = ["ic_banner_default"]
                cell.delegate = self
                if cell.arrImageBanner.count > 0 {
                    cell.crollViewImage()
                    cell.configCrollView()
                }
                return cell
            case .Auction:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InfoAuctionTableViewCell") as! InfoAuctionTableViewCell
                cell.delegate = self
                return cell
            case .Address:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TimeAddressTableViewCell") as! TimeAddressTableViewCell
                return cell
            case .Detail:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InfoDetailTableViewCell") as! InfoDetailTableViewCell
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Main1TableViewCell") as! Main1TableViewCell
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension DetailAuctionViewController: ImageDetailAuctionTableViewCellProtocol{
    func didShowMoreAuction() {
        let alertControl = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let action2 = UIAlertAction.init(title: "Tạo đấu giá dịch vụ của bạn", style: .default) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        let action3 = UIAlertAction.init(title: "Báo xấu", style: .default) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction.init(title: "Huỷ", style: .cancel) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        
        alertControl.addAction(action2)
        alertControl.addAction(action3)
        alertControl.addAction(actionCancel)
        self.navigationController?.present(alertControl, animated: true, completion: nil)
    }
    
    
}

extension DetailAuctionViewController: Main1TableViewCellProtocol{
    func didCellMain1(index: Int) {
        print("index1 = ", index)
        let detailAuction = DetailAuctionViewController()
        self.navigationController?.pushViewController(detailAuction, animated: true)
    }
}

extension DetailAuctionViewController: InfoAuctionTableViewCellProtocol{
    func didAuction() {
        Settings.ShareInstance.showAlertViewWithOkCancel(message: "Bạn có chắc chắn đấu giá dịch vụ?", vc: self) { (str) in
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
}
