//
//  MyServiceDetailViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/27/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class MyServiceDetailViewController: BaseViewController {

    @IBOutlet weak var tbvMyServiceDetail: UITableView!
    var modelDetail: BaseServiceModel?
    var modelUser = Settings.ShareInstance.getDictUser()
    var listOrderBaseServiceDetail: [BaseServiceInfoBookedModel] = []
    var arrayJobs: [JobModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        self.showProgressHub()
        self.setupUI()
        self.configButtonBack()
        self.setupTableView()
//        self.getListJobs()
        self.getDetailOrderBaseService()
    }
    
    func setupUI(){
        self.navigationItem.title = modelDetail?.title ?? ""
    }
    
    func setupTableView(){
        self.tbvMyServiceDetail.register(UINib(nibName: "MyBaseServiceDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "MyBaseServiceDetailTableViewCell")
        self.tbvMyServiceDetail.register(UINib(nibName: "MyBaseService1DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "MyBaseService1DetailTableViewCell")
        self.tbvMyServiceDetail.register(UINib(nibName: "BasicServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "BasicServicesTableViewCell")
        self.tbvMyServiceDetail.register(UINib(nibName: "MyBaseService2DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "MyBaseService2DetailTableViewCell")
        

        self.tbvMyServiceDetail.delegate = self
        self.tbvMyServiceDetail.dataSource = self
        self.tbvMyServiceDetail.separatorColor = UIColor.clear
        self.tbvMyServiceDetail.separatorInset = UIEdgeInsets.zero
        self.tbvMyServiceDetail.estimatedRowHeight = 300
        self.tbvMyServiceDetail.rowHeight = UITableView.automaticDimension
        
        self.tbvMyServiceDetail.tableFooterView = UIView(frame: .zero)
        self.tbvMyServiceDetail.register(UINib.init(nibName: "HeaderServicesInfoBook", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderServicesInfoBook")
    }
    
    func getDetailOrderBaseService(){
        ManageServicesManager.shareManageServicesManager().getListOrderBaseService(sellerId: modelDetail?.userInfo?.id ?? 0, serviceId: modelDetail?.id ?? 0) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listOrderBaseServiceDetail.append(model)
                }
                self.tbvMyServiceDetail.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func getListJobs(){
        UserManager.shareUserManager().getListJobs {[unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                self.arrayJobs = data
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
}

extension MyServiceDetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return listOrderBaseServiceDetail.count
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicServicesTableViewCell") as! BasicServicesTableViewCell
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
            cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.dateTime1 ?? 0.0)
            cell.lbCity.text = "Địa chỉ: \(modelDetail?.address ?? "")"
            cell.lbName.text = modelDetail?.userInfo?.userCategory
            cell.lbCoin.text = "\(modelDetail?.amount ?? "0") Godcoin"
            return cell
        }else{
            let model = listOrderBaseServiceDetail[indexPath.row]
            if model.status == "PENDING" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyBaseService1DetailTableViewCell") as! MyBaseService1DetailTableViewCell
                cell.lbTitle.text = "\(model.buyerInfo?.fullName ?? "") đã đặt dịch vụ \(modelDetail?.title ?? "")"
                cell.lbStatus.text = model.buyerInfo?.address ?? ""
                let career = model.buyerInfo?.career
                let arrCareer = career?.split(separator: ",")
                var strCareer = ""
                for item in arrCareer! {
                    for item1 in self.arrayJobs {
                        if Int(item) == item1.id {
                            if strCareer.count == 0 {
                                strCareer = strCareer + item1.name!
                            }else {
                                strCareer = strCareer + ", " + item1.name!
                            }
                        }
                    }
                }
                cell.btCancel.tag = indexPath.row
                cell.btConfirm.tag = indexPath.row
                cell.lbTime.text = strCareer
                cell.delegate = self
                return cell
            }else if model.status == "ACCEPT" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyBaseService2DetailTableViewCell") as! MyBaseService2DetailTableViewCell
                cell.lbTitle.text = "\(model.buyerInfo?.fullName ?? "") đã đặt dịch vụ \(modelDetail?.title ?? "")"
                cell.lbStatus.text = model.buyerInfo?.address ?? ""
                let career = model.buyerInfo?.career
                let arrCareer = career?.split(separator: ",")
                var strCareer = ""
                for item in arrCareer! {
                    for item1 in self.arrayJobs {
                        if Int(item) == item1.id {
                            if strCareer.count == 0 {
                                strCareer = strCareer + item1.name!
                            }else {
                                strCareer = strCareer + ", " + item1.name!
                            }
                        }
                    }
                }
                cell.btConfirm.tag = indexPath.row
                cell.lbTime.text = strCareer
                cell.delegate = self
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyBaseServiceDetailTableViewCell") as! MyBaseServiceDetailTableViewCell
                cell.lbTitle.text = "\(model.buyerInfo?.fullName ?? "") đã đặt dịch vụ \(modelDetail?.title ?? "")"
                cell.lbStatus.text = model.buyerInfo?.address ?? ""
                let career = model.buyerInfo?.career
                let arrCareer = career?.split(separator: ",")
                var strCareer = ""
                for item in arrCareer! {
                    for item1 in BaseViewController.arrayJobs {
                        if Int(item) == Int(item1["code"]!) {
                            if strCareer.count == 0 {
                                strCareer = strCareer + (item1["name"] ?? "")
                            }else {
                                strCareer = strCareer + ", " + (item1["name"] ?? "")
                            }
                        }
                    }
                }
                cell.lbTime.text = strCareer
                return cell
            }
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

extension MyServiceDetailViewController: MyBaseService1DetailTableViewCellProtocol{
    func didConfirm(_ index: Int) {
        let model = listOrderBaseServiceDetail[index]
        ManageServicesManager.shareManageServicesManager().confirmOrderBaseService(id: model.id ?? 0, status: "ACCEPT") { [unowned self](response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: "Bạn đã xác nhận dịch vụ", vc: self) { [unowned self] (str) in
//                    self.navigationController?.popViewController(animated: true)
                    self.showProgressHub()
                    self.getDetailOrderBaseService()
                }
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func didCancel(_ index: Int) {
        let model = listOrderBaseServiceDetail[index]
                ManageServicesManager.shareManageServicesManager().confirmOrderBaseService(id: model.id ?? 0, status: "REJECT") { [unowned self](response) in
                    switch response {
                        
                    case .success(_):
                        self.hideProgressHub()
                        Settings.ShareInstance.showAlertView(message: "Bạn đã từ chối dịch vụ", vc: self) { [unowned self] (str) in
//                            self.navigationController?.popViewController(animated: true)
                            self.showProgressHub()
                            self.getDetailOrderBaseService()
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

extension MyServiceDetailViewController: MyBaseService2DetailTableViewCellProtocol{
    func didDone(_ index: Int) {
        let model = listOrderBaseServiceDetail[index]
        ManageServicesManager.shareManageServicesManager().confirmOrderBaseService(id: model.id ?? 0, status: "DONE") { [unowned self](response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: "Chúc mừng bạn đã hoàn tất dịch vụ", vc: self) { [unowned self](str) in
//                    self.navigationController?.popViewController(animated: true)
                    self.showProgressHub()
                    self.getDetailOrderBaseService()
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
