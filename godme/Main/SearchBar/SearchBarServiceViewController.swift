//
//  SearchBarServiceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/12/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class SearchBarServiceViewController: BaseViewController {
    @IBOutlet weak var tbvServices: CollapseTableView!
    var modelDetail: UserRegisterReturnModel?
    var listBaseService: [BaseServiceModel] = []
    var listAuction:[AuctionServiceModel] = []
    var listEvents: [EventModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        self.setupTableView()
        
        self.tbvServices.didTapSectionHeaderView = { (sectionIndex, isOpen) in
            debugPrint("sectionIndex \(sectionIndex), isOpen \(isOpen)")
        }
        reloadTableView { [unowned self] in
            self.tbvServices.openSection(0, animated: true)
        }
        self.showProgressHub()
        self.getListSearchBaseService()
        self.getListSearchAuctionService()
        self.getListSearchEventService()
    }
    
    func setupTableView(){
        self.tbvServices.register(UINib(nibName: "BasicServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "BasicServicesTableViewCell")
        self.tbvServices.register(UINib(nibName: "AuctionServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "AuctionServicesTableViewCell")
        self.tbvServices.register(UINib(nibName: "EventsTableViewCell", bundle: nil), forCellReuseIdentifier: "EventsTableViewCell")
        self.tbvServices.register(UINib(nibName: "DefaultTableViewCell", bundle: nil), forCellReuseIdentifier: "DefaultTableViewCell")

        self.tbvServices.delegate = self
        self.tbvServices.dataSource = self
        self.tbvServices.separatorColor = UIColor.clear
        self.tbvServices.separatorInset = UIEdgeInsets.zero
        self.tbvServices.estimatedRowHeight = 300
        self.tbvServices.rowHeight = UITableView.automaticDimension
        
        self.tbvServices.tableFooterView = UIView(frame: .zero)
        self.tbvServices.register(UINib.init(nibName: "SectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
    }
    
    func reloadTableView(_ completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            completion()
        })
        self.tbvServices.reloadData()
        CATransaction.commit()
    }
    
    func getListSearchBaseService(){
        ManageServicesManager.shareManageServicesManager().searchBaseService(createdByUserId: modelDetail?.id ?? 0, sorts: [["field":"modifiedOn", "order": "desc"]], page: 1, pageSize: 1000) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listBaseService.append(model)
                }
                self.tbvServices.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func getListSearchAuctionService(){
        ManageServicesManager.shareManageServicesManager().searchAuctionService(createdByUserId: modelDetail?.id ?? 0, sorts: [["field":"modifiedOn", "order": "desc"]], page: 1, pageSize: 1000) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listAuction.append(model)
                }
                self.tbvServices.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func getListSearchEventService(){
        ManageServicesManager.shareManageServicesManager().searchEventService(createdByUserId: modelDetail?.id ?? 0, sorts: [["field":"modifiedOn", "order": "desc"]], page: 1, pageSize: 1000) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listEvents.append(model)
                }
                self.tbvServices.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }

}

extension SearchBarServiceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if self.listBaseService.count == 0 {
                return 1
            }
            return self.listBaseService.count
        }else if section == 1 {
            if self.listAuction.count == 0 {
                return 1
            }
            return self.listAuction.count
        }else{
            if self.listEvents.count == 0 {
                return 1
            }
            return self.listEvents.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if self.listBaseService.count == 0 {
                let cell  = tableView.dequeueReusableCell(withIdentifier: "DefaultTableViewCell") as! DefaultTableViewCell
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicServicesTableViewCell") as! BasicServicesTableViewCell
            let model = listBaseService[indexPath.row]
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
            cell.lbName.text = model.userInfo?.userCategory
            cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: model.dateTime1 ?? 0.0)
            cell.lbCoin.text = "\(Int(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
            return cell
        }else if indexPath.section == 1 {
            if listAuction.count == 0 {
                let cell  = tableView.dequeueReusableCell(withIdentifier: "DefaultTableViewCell") as! DefaultTableViewCell
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "AuctionServicesTableViewCell") as! AuctionServicesTableViewCell
            let model = listAuction[indexPath.row]
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
            cell.lbName.text = model.userInfo?.userCategory
            cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: model.startTime ?? 0.0)
            cell.lbCoin.text = "\(Int(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
            return cell
        }else{
            if listEvents.count == 0 {
                let cell  = tableView.dequeueReusableCell(withIdentifier: "DefaultTableViewCell") as! DefaultTableViewCell
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventsTableViewCell") as! EventsTableViewCell
            let model = listEvents[indexPath.row]
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
            cell.lbName.text = model.userInfo?.userCategory
            cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: model.startTime ?? 0.0)
            cell.lbCoin.text = "\(Int(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderView") as! SectionHeaderView
        if section == 0 {
            view.lbTitle.text = "Dịch vụ cơ bản"
        }else if section == 1 {
            view.lbTitle.text = "Đấu giá dịch vụ"
        }else{
            view.lbTitle.text = "Sự kiện"
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if listBaseService.count == 0 {
                return
            }
            let model = listBaseService[indexPath.row]
            let detail = DetailBasicServiceViewController()
            detail.modelDetail = model
            self.navigationController?.pushViewController(detail, animated: true)
        }else if indexPath.section == 1 {
            if listAuction.count == 0 {
                return
            }
            let model = listAuction[indexPath.row]
            let detail = DetailAuctionViewController()
            detail.modelDetail = model
            self.navigationController?.pushViewController(detail, animated: true)
        }else {
            if listEvents.count == 0 {
                return
            }
            let model = listEvents[indexPath.row]
            let detail = DetailEventViewController()
            detail.modelDetail = model
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
    
    
}
