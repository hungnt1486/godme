//
//  AuctionServiceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/9/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import SDWebImage

class AuctionServiceViewController: BaseViewController {

    @IBOutlet weak var tbvAuctionService: UITableView!
    var listAuction:[AuctionServiceModel] = []
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.gray
        
        return refreshControl
    }()
    var isLoadMore: Bool = true
    var currentPage: Int = 1
    var pageSize: Int = 10
    
    var isGodcoin = true
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupTableView()
        self.configButtonBack()
        self.showProgressHub()
        self.getListAuctionService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "auction_service")
    }
    
    func setupUI(){
        self.tabBarController?.tabBar.isHidden = true
        let right = UIBarButtonItem.init(title: "đ<->Godcoin", style: .plain, target: self, action: #selector(touchRight))
        right.tintColor = UIColor.FlatColor.Oranges.BGColor
        self.navigationItem.rightBarButtonItem = right
    }
    
    func setupTableView(){
        self.tbvAuctionService.register(UINib(nibName: "AuctionServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "AuctionServicesTableViewCell")
        self.tbvAuctionService.delegate = self
        self.tbvAuctionService.dataSource = self
        self.tbvAuctionService.separatorColor = UIColor.clear
        self.tbvAuctionService.separatorInset = UIEdgeInsets.zero
        self.tbvAuctionService.estimatedRowHeight = 300
        self.tbvAuctionService.rowHeight = UITableView.automaticDimension
        self.tbvAuctionService.addSubview(refreshControl)
    }
    
    @objc func touchRight(){
        isGodcoin = !isGodcoin
        self.tbvAuctionService.reloadData()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        currentPage = 1
        self.getListAuctionService()
        refreshControl.endRefreshing()
    }
    
    func getListAuctionService(){
        ManageServicesManager.shareManageServicesManager().getListAuctionService(page: currentPage, pageSize: pageSize, sorts: [["field":"createdOn", "order": "desc"]], ge: [["field": "endTime", "value": "\(Int(Settings.ShareInstance.convertDateToTimeInterval(date: Date())))"]]) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                if self.currentPage == 1 {
                    self.isLoadMore = true
                    self.listAuction.removeAll()
                    self.listAuction = [AuctionServiceModel]()
                }
                if data.count < self.pageSize {
                    self.isLoadMore = false
                }
                for model in data {
                    self.listAuction.append(model)
                }
                self.tbvAuctionService.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
}

extension AuctionServiceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listAuction.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuctionServicesTableViewCell") as! AuctionServicesTableViewCell
        let model = listAuction[indexPath.row]
        let images = model.images
        let arrImgage = images?.split(separator: ",")
        var linkImg = ""
        if arrImgage!.count > 0 {
            linkImg = String(arrImgage?[0] ?? "")
        }
        cell.lbTitle.text = model.title
        cell.imgAvatar.sd_setImage(with: URL.init(string: linkImg), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
            if error == nil {
                cell.imgAvatar.image = image
            }
        }
        if isGodcoin {
            cell.lbCity.text = "Bước giá: \(Double(model.priceStep ?? "0")?.formatnumber() ?? "0") Godcoin"
            cell.lbName.text = "Giá hiện tại: \(Double(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
        }else{
            cell.lbCity.text = "Bước giá: \(Settings.ShareInstance.formatCurrency(Value: "\((Double(model.priceStep ?? "0") ?? 0)*1000)"))"
            cell.lbName.text = "Giá hiện tại: \(Settings.ShareInstance.formatCurrency(Value: "\((Double(model.amount ?? "0") ?? 0)*1000)"))"
        }
        cell.lbCoin.text = "Số lệnh đã đấu giá: \(model.totalOrder ?? 0)"
        cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: model.startTime ?? 0.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = listAuction[indexPath.row]
        let detail = DetailAuctionViewController()
        detail.modelDetail = model
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLoadMore {
            if indexPath.row == listAuction.count - 3 {
                currentPage = currentPage + 1
                self.getListAuctionService()
            }
        }
    }
    
}
