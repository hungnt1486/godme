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
        return listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let typeCell = listTypeCell[indexPath.row]
        
        switch typeCell {
            
        case .Avatar:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageDetailAuctionTableViewCell") as! ImageDetailAuctionTableViewCell
            cell.arrImageBanner = ["ic_logo"]
            cell.delegate = self
            if cell.arrImageBanner.count > 0 {
                cell.crollViewImage()
                cell.configCrollView()
            }
            return cell
        case .Auction:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoAuctionTableViewCell") as! InfoAuctionTableViewCell
            return cell
        case .Address:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeAddressTableViewCell") as! TimeAddressTableViewCell
            return cell
        case .Detail:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoDetailTableViewCell") as! InfoDetailTableViewCell
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
