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
    }
    
    func setupTableView(){
        self.tbvAuctionService.register(UINib(nibName: "AuctionServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "AuctionServicesTableViewCell")
        self.tbvAuctionService.delegate = self
        self.tbvAuctionService.dataSource = self
        self.tbvAuctionService.separatorColor = UIColor.clear
        self.tbvAuctionService.separatorInset = UIEdgeInsets.zero
        self.tbvAuctionService.estimatedRowHeight = 300
        self.tbvAuctionService.rowHeight = UITableView.automaticDimension
    }
    
    func getListAuctionService(){
        ManageServicesManager.shareManageServicesManager().getListAuctionService { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
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
        cell.lbCity.text = model.address
        cell.lbName.text = model.userInfo?.userCategory
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
    
    
}
