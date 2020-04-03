//
//  MyAuctionServiceDetailViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/27/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class MyAuctionServiceDetailViewController: BaseViewController {

    @IBOutlet weak var tbvMyAuctionServiceDetail: UITableView!
    
    var modelDetail: AuctionServiceModel?
    var modelUser = Settings.ShareInstance.getDictUser()
    var listOrderAuctionServiceDetail: [AuctionServiceInfoBookedModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showProgressHub()
        self.setupUI()
        self.setupTableView()
        self.configButtonBack()
        self.getDetailOrderAuctionService()
    }
    
    func setupUI(){
        self.navigationItem.title = modelDetail?.title ?? ""
    }
   
    func setupTableView(){
        self.tbvMyAuctionServiceDetail.register(UINib(nibName: "AuctionServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "AuctionServicesTableViewCell")
    
        self.tbvMyAuctionServiceDetail.register(UINib(nibName: "MyAuctionServicesDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "MyAuctionServicesDetailTableViewCell")
       

        self.tbvMyAuctionServiceDetail.delegate = self
        self.tbvMyAuctionServiceDetail.dataSource = self
        self.tbvMyAuctionServiceDetail.separatorColor = UIColor.clear
        self.tbvMyAuctionServiceDetail.separatorInset = UIEdgeInsets.zero
        self.tbvMyAuctionServiceDetail.estimatedRowHeight = 300
        self.tbvMyAuctionServiceDetail.rowHeight = UITableView.automaticDimension
       
        self.tbvMyAuctionServiceDetail.tableFooterView = UIView(frame: .zero)
        self.tbvMyAuctionServiceDetail.register(UINib.init(nibName: "HeaderServicesInfoBook", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderServicesInfoBook")
    }
    
    func getDetailOrderAuctionService(){
        ManageServicesManager.shareManageServicesManager().getListOrderAuctionService(sellerId: modelDetail?.userInfo?.id ?? 0, serviceId: modelDetail?.id ?? 0) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listOrderAuctionServiceDetail.append(model)
                }
                self.tbvMyAuctionServiceDetail.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }

}

extension MyAuctionServiceDetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return listOrderAuctionServiceDetail.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return UIView()
        }
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderServicesInfoBook") as! HeaderServicesInfoBook
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AuctionServicesTableViewCell") as! AuctionServicesTableViewCell
            cell.lbTitle.text = modelDetail?.title
            let images = modelDetail?.images
            let arrImgage = images?.split(separator: ",")
            var linkImg = ""
            if arrImgage!.count > 0 {
                linkImg = String(arrImgage?[0] ?? "")
            }
            cell.imgAvatar.sd_setImage(with: URL.init(string: linkImg), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
                if error == nil {
                    cell.imgAvatar.image = image
                }
            }
            cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.endTime ?? 0.0)
            cell.lbCity.text = "Địa chỉ: \(modelDetail?.address ?? "")"
            cell.lbName.text = modelDetail?.userInfo?.userCategory
            cell.lbCoin.text = "\(modelDetail?.amount ?? "0") Godcoin"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyAuctionServicesDetailTableViewCell") as! MyAuctionServicesDetailTableViewCell
            let model = listOrderAuctionServiceDetail[indexPath.row]
            cell.imgAvatar.sd_setImage(with: URL.init(string: model.buyerInfo?.avatar ?? ""), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
                if error == nil {
                    cell.imgAvatar.image = image
                }
            }
            cell.lbTitle.text = model.buyerInfo?.fullName
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        if indexPath.section == 0 {
//            let model = listBaseService[indexPath.row]
//            let detail = DetailBasicServiceViewController()
//            detail.modelDetail = model
//            self.navigationController?.pushViewController(detail, animated: true)
//        }else if indexPath.section == 1 {
//            let model = listAuction[indexPath.row]
//            let detail = DetailAuctionViewController()
//            detail.modelDetail = model
//            self.navigationController?.pushViewController(detail, animated: true)
//        }else {
//            let model = listEvents[indexPath.row]
//            let detail = DetailEventViewController()
//            detail.modelDetail = model
//            self.navigationController?.pushViewController(detail, animated: true)
//        }
    }
    
    
}
