//
//  ServicesInfoBookedDetailViewController.swift
//  godme
//
//  Created by Lê Hùng on 4/17/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

//enum typeCellServicesInfoBookedDetail: Int {
//    case Vote = 0
//    case Description = 1
//    case Confirm = 2
//}

class ServicesInfoBookedDetailAuctionViewController: BaseViewController {

    @IBOutlet weak var tbvServicesInfoBookedDetail: UITableView!
    var listTypeCell: [typeCellServicesInfoBookedDetail] = [.Vote, .Description, .Confirm]
    var modelDetail: [AuctionServiceModel] = []
    var serviceId: Int = 0
    var cellVote: VoteTableViewCell!
    var modelBaseService = RateBaseServiceParamsModel()
    var intVote = 0
    var listAuctionServiceDetail: AuctionServiceInfoBookedModel?
    var modelUser = Settings.ShareInstance.getDictUser()
    var section = 3
    var status = ""
    var strTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showProgressHub()
        self.setupUI()
        self.configButtonBack()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setupUI(){
        if listAuctionServiceDetail?.buyerInfo?.id ?? 0 == self.modelUser.userId {
            if listAuctionServiceDetail?.status == "PENDING" || listAuctionServiceDetail?.status == "REJECT" {
                self.section = 2
                self.status = listAuctionServiceDetail?.status ?? ""
            }
        }
        self.serviceId = listAuctionServiceDetail?.serviceId ?? 0
        self.getDetailBaseService()
    }
    
    func setupTableView(){
        self.tbvServicesInfoBookedDetail.register(UINib(nibName: "ServicesInfoBookedDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ServicesInfoBookedDetailTableViewCell")
    
        self.tbvServicesInfoBookedDetail.register(UINib(nibName: "MyServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "MyServicesTableViewCell")
       self.tbvServicesInfoBookedDetail.register(UINib(nibName: "CompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteTableViewCell")
        self.tbvServicesInfoBookedDetail.register(UINib(nibName: "DescriptionCarTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionCarTableViewCell")
        self.tbvServicesInfoBookedDetail.register(UINib(nibName: "VoteTableViewCell", bundle: nil), forCellReuseIdentifier: "VoteTableViewCell")
        self.tbvServicesInfoBookedDetail.register(UINib(nibName: "BasicServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "BasicServicesTableViewCell")
       

        self.tbvServicesInfoBookedDetail.delegate = self
        self.tbvServicesInfoBookedDetail.dataSource = self
        self.tbvServicesInfoBookedDetail.separatorColor = UIColor.clear
        self.tbvServicesInfoBookedDetail.separatorInset = UIEdgeInsets.zero
        self.tbvServicesInfoBookedDetail.estimatedRowHeight = 300
        self.tbvServicesInfoBookedDetail.rowHeight = UITableView.automaticDimension
    }
    
    func getDetailBaseService(){
        ManageServicesManager.shareManageServicesManager().getDetailAuctionService(id: serviceId) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                self.modelDetail = data
                let model = self.modelDetail[0]
                self.strTitle = model.title ?? ""
                self.navigationItem.title = self.strTitle
                self.tbvServicesInfoBookedDetail.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
//    func getListOrderBaseServiceDetail(){
//        ManageServicesManager.shareManageServicesManager().getListOrderAuctionServiceDetail(serviceId: serviceId) { [unowned self](response) in
//            switch response {
//
//            case .success(let data):
//                self.hideProgressHub()
//                self.listAuctionServiceDetail = data
//                for item in self.listAuctionServiceDetail {
//                    if item.buyerInfo?.id ?? 0 == self.modelUser.userId {
//                        if item.status == "PENDING" || item.status == "REJECT" {
//                            self.section = 2
//                            self.status = item.status ?? ""
//                            break
//                        }
//                    }
//                }
//                self.getDetailBaseService()
//                break
//            case .failure(let message):
//                self.hideProgressHub()
//                Settings.ShareInstance.showAlertView(message: message, vc: self)
//                break
//            }
//        }
//    }
    
    func rateBaseService(model: AddNewRateBaseServiceParams){
        ManageServicesManager.shareManageServicesManager().rateAuctionService(model: model) {[unowned self] (response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: Settings.ShareInstance.translate(key: "label_thank_vote"), vc: self) { [unowned self](str) in
                    self.navigationController?.popViewController(animated: true)
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

extension ServicesInfoBookedDetailAuctionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.section == 2 {
            if section == 0 {
                return self.modelDetail.count
            }else {
                return self.modelDetail.count
            }
        }else {
            if section == 0 {
                return self.modelDetail.count
            }else if section == 1 {
                return self.modelDetail.count
            }else {
                return listTypeCell.count
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.section
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let model = self.modelDetail[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesInfoBookedDetailTableViewCell") as! ServicesInfoBookedDetailTableViewCell
            
            cell.imgAvatar.sd_setImage(with: URL.init(string: model.userInfo?.avatar ?? ""), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
                if error == nil {
                    cell.imgAvatar.image = image
                }
            }
            cell.lbTitle.text = model.userInfo?.fullName
            cell.lbTime.text = model.userInfo?.address ?? ""
            let career = model.userInfo?.career ?? ""
            let arrCareer = career.split(separator: ",")
            var strCareer = ""
            for item in arrCareer {
                for item1 in BaseViewController.arrayJobs {
                    if Int(item) == Int(item1["code"] ?? "0") {
                        if strCareer.count == 0 {
                            strCareer = strCareer + item1["name"]!
                        }else {
                            strCareer = strCareer + ", " + item1["name"]!
                        }
                        break
                    }
                }
            }
            cell.lbCity.text = strCareer
            cell.indexStar = model.userInfo?.totalStar ?? 0.0
            cell.setupUI()
            return cell
        }else if indexPath.section == 1 {
            
            let model = self.modelDetail[indexPath.row]
            if self.status == "PENDING" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyServicesTableViewCell") as! MyServicesTableViewCell
                cell.lbTitle.text = model.title
                let images = model.images
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
                cell.lbCity.text = model.address
                cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: model.startTime ?? 0.0)
                cell.lbCoin.text = "\(Double(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicServicesTableViewCell") as! BasicServicesTableViewCell
            cell.lbTitle.text = model.title
            let images = model.images
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
            cell.lbCity.text = model.address
            cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: model.startTime ?? 0.0)
            cell.lbCoin.text = "\(Double(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
            return cell
        }else{
            let type = listTypeCell[indexPath.row]
            switch type {
                
            case .Vote:
                cellVote = tableView.dequeueReusableCell(withIdentifier: "VoteTableViewCell") as? VoteTableViewCell
                cellVote.delegate = self
                return cellVote
            case .Description:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCarTableViewCell") as! DescriptionCarTableViewCell
                cell.delegate = self
                cell.lbTitle.text = Settings.ShareInstance.translate(key: "label_write_vote")
                return cell
            case .Confirm:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
                cell.btComplete.setTitle(Settings.ShareInstance.translate(key: "label_send_vote"), for: .normal)
                cell.delegate = self
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            let detail = DetailAuctionViewController()
            detail.modelDetail = modelDetail[0]
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
}

extension ServicesInfoBookedDetailAuctionViewController: CompleteTableViewCellProtocol{
    func didComplete() {
        if intVote == 0 {
            Settings.ShareInstance.showAlertView(message: Settings.ShareInstance.translate(key: "label_please_choose_star_for_vote"), vc: self)
            return
        }
        self.showProgressHub()
        let model1 = self.modelDetail[0]
        var model = AddNewRateBaseServiceParams()
        model.point = intVote
        model.sellerId = model1.userInfo?.id ?? 0
        model.serviceId = model1.id ?? 0
        model.comment = self.modelBaseService.comment
        self.rateBaseService(model: model)
//        self.rateBaseService
        
    }
}

extension ServicesInfoBookedDetailAuctionViewController: DescriptionCarTableViewCellProtocol{
    func getDescriptionText(_ string: String) {
        self.modelBaseService.comment = string
    }
}

extension ServicesInfoBookedDetailAuctionViewController: VoteTableViewCellProtocol{
    func didImg1() {
        cellVote.setupStar(index: 1.0)
        cellVote.lbResult.text = Settings.ShareInstance.translate(key: "label_dissatisfaction")
        intVote = 1
    }
    
    func didImg2() {
        cellVote.setupStar(index: 2.0)
        cellVote.lbResult.text = Settings.ShareInstance.translate(key: "label_unsatisfied")
        intVote = 2
    }
    
    func didImg3() {
        cellVote.setupStar(index: 3.0)
        cellVote.lbResult.text = Settings.ShareInstance.translate(key: "label_normal")
        intVote = 3
    }
    
    func didImg4() {
        cellVote.setupStar(index: 4.0)
        cellVote.lbResult.text = Settings.ShareInstance.translate(key: "label_satisfied")
        intVote = 4
    }
    
    func didImg5() {
        cellVote.setupStar(index: 5.0)
        cellVote.lbResult.text = Settings.ShareInstance.translate(key: "label_very_satisfied")
        intVote = 5
    }
}
