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
    let group = DispatchGroup()
    
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
        self.callAllServices()
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
    
    func callAllServices(){
        self.getListSearchBaseService()
        self.getListSearchAuctionService()
        self.getListSearchEventService()
        group.notify(queue: DispatchQueue.global(qos: .background)) {
            DispatchQueue.main.async {
                self.hideProgressHub()
            }
        }
    }
    
    func getListSearchBaseService(){
        group.enter()
        ManageServicesManager.shareManageServicesManager().searchBaseService(createdByUserId: modelDetail?.id ?? 0, sorts: [["field":"modifiedOn", "order": "desc"]], page: 1, pageSize: 1000) { [unowned self](response) in
            switch response {
                
            case .success(let data):
//                self.hideProgressHub()
                for model in data {
                    self.listBaseService.append(model)
                }
                self.tbvServices.reloadData()
                self.group.leave()
                break
            case .failure(let message):
//                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                self.group.leave()
                break
            }
        }
    }
    
    func getListSearchAuctionService(){
        group.enter()
        ManageServicesManager.shareManageServicesManager().searchAuctionService(createdByUserId: modelDetail?.id ?? 0, sorts: [["field":"modifiedOn", "order": "desc"]], page: 1, pageSize: 1000) { [unowned self](response) in
            switch response {
                
            case .success(let data):
//                self.hideProgressHub()
                for model in data {
                    self.listAuction.append(model)
                }
                self.tbvServices.reloadData()
                self.group.leave()
                break
            case .failure(let message):
//                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                self.group.leave()
                break
            }
        }
    }
    
    func getListSearchEventService(){
        group.enter()
        ManageServicesManager.shareManageServicesManager().searchEventService(createdByUserId: modelDetail?.id ?? 0, sorts: [["field":"modifiedOn", "order": "desc"]], page: 1, pageSize: 1000) { [unowned self](response) in
            switch response {
                
            case .success(let data):
//                self.hideProgressHub()
                for model in data {
                    self.listEvents.append(model)
                }
                self.tbvServices.reloadData()
                self.group.leave()
                break
            case .failure(let message):
//                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                self.group.leave()
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
            cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: model.dateTime1 ?? 0.0)
            cell.lbCoin.text = "\(Double(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
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
//            if isGodcoin {
                cell.lbCity.text = "Bước giá: \(Double(model.priceStep ?? "0")?.formatnumber() ?? "0") Godcoin"
                cell.lbName.text = "Giá hiện tại: \(Double(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
//            }else{
//                cell.lbCity.text = "Bước giá: \(Settings.ShareInstance.formatCurrency(Value: "\((Double(model.priceStep ?? "0") ?? 0)*1000)"))"
//                cell.lbName.text = "Giá hiện tại: \(Settings.ShareInstance.formatCurrency(Value: "\((Double(model.amount ?? "0") ?? 0)*1000)"))"
//            }
            cell.lbCoin.text = "Số lệnh đã đấu giá: \(model.totalOrder ?? 0)"
            cell.dateTime = Settings.ShareInstance.convertTimeIntervalToDateTimeForCountDown(timeInterval: model.endTime ?? 0.0)
            cell.countDown()
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
            cell.lbName.text = "Số người đã đăng ký: \(model.totalOrder ?? 0)/\(model.maxOrder ?? 0)"
            cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: model.startTime ?? 0.0)
            cell.lbCoin.text = "\(Double(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderView") as! SectionHeaderView
        if section == 0 {
            view.lbTitle.text = Settings.ShareInstance.translate(key: "label_service_basic")
        }else if section == 1 {
            view.lbTitle.text = Settings.ShareInstance.translate(key: "label_service_auction")
        }else{
            view.lbTitle.text = Settings.ShareInstance.translate(key: "label_event")
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
