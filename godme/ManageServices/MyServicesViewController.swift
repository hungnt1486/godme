//
//  MyServicesViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class MyServicesViewController: BaseViewController {

    @IBOutlet weak var tbvMyServices: CollapseTableView!
    var listBaseService: [BaseServiceModel] = []
    var listAuction:[AuctionServiceModel] = []
    var listEvents: [EventModel] = []
    var modelUser = Settings.ShareInstance.getDictUser()
    let group = DispatchGroup()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupTableView()
        
        self.tbvMyServices.didTapSectionHeaderView = { (sectionIndex, isOpen) in
            debugPrint("sectionIndex \(sectionIndex), isOpen \(isOpen)")
        }
        reloadTableView { [unowned self] in
            self.tbvMyServices.openSection(0, animated: true)
        }
        self.showProgressHub()
        self.callAllServices()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tbvMyServices.reloadData()
    }
    
    func setupTableView(){
        self.tbvMyServices.register(UINib(nibName: "BasicServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "BasicServicesTableViewCell")
        self.tbvMyServices.register(UINib(nibName: "AuctionServices1TableViewCell", bundle: nil), forCellReuseIdentifier: "AuctionServices1TableViewCell")
        self.tbvMyServices.register(UINib(nibName: "EventsTableViewCell", bundle: nil), forCellReuseIdentifier: "EventsTableViewCell")
        

        self.tbvMyServices.delegate = self
        self.tbvMyServices.dataSource = self
        self.tbvMyServices.separatorColor = UIColor.clear
        self.tbvMyServices.separatorInset = UIEdgeInsets.zero
        self.tbvMyServices.estimatedRowHeight = 300
        self.tbvMyServices.rowHeight = UITableView.automaticDimension
        
        self.tbvMyServices.tableFooterView = UIView(frame: .zero)
        self.tbvMyServices.register(UINib.init(nibName: "SectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
    }
    
    func reloadTableView(_ completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            completion()
        })
        self.tbvMyServices.reloadData()
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
        ManageServicesManager.shareManageServicesManager().searchBaseService(createdByUserId: modelUser.userId!, sorts: [["field":"modifiedOn", "order": "desc"]], page: 1, pageSize: 1000) { [unowned self](response) in
            switch response {
                
            case .success(let data):
//                self.hideProgressHub()
                for model in data {
                    self.listBaseService.append(model)
                }
                self.tbvMyServices.reloadData()
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
        ManageServicesManager.shareManageServicesManager().searchAuctionService(createdByUserId: modelUser.userId!, sorts: [["field":"modifiedOn", "order": "desc"]], page: 1, pageSize: 1000) { [unowned self](response) in
            switch response {
                
            case .success(let data):
//                self.hideProgressHub()
                for model in data {
                    self.listAuction.append(model)
                }
                self.tbvMyServices.reloadData()
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
        ManageServicesManager.shareManageServicesManager().searchEventService(createdByUserId: modelUser.userId!, sorts: [["field":"modifiedOn", "order": "desc"]], page: 1, pageSize: 1000) { [unowned self](response) in
            switch response {
                
            case .success(let data):
//                self.hideProgressHub()
                for model in data {
                    self.listEvents.append(model)
                }
                self.tbvMyServices.reloadData()
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

extension MyServicesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.listBaseService.count
        }else if section == 1 {
            return self.listAuction.count
        }else{
            return self.listEvents.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "AuctionServices1TableViewCell") as! AuctionServices1TableViewCell
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
            cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: model.startTime ?? 0.0)
            cell.lbCoin.text = "\(Double(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
            return cell
        }else{
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
            cell.lbName.text = "\(Settings.ShareInstance.translate(key: "label_event_total_register")) \(model.totalOrder ?? 0)/\(model.maxOrder ?? 0)"
            cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: model.startTime ?? 0.0)
            cell.lbCoin.text = "\(Double(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
            return cell
        }
        
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MyServicesTableViewCell") as! MyServicesTableViewCell
//            return cell
//        }else{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MyServicesJoinTableViewCell") as! MyServicesJoinTableViewCell
//            return cell
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let model = listBaseService[indexPath.row]
            let detail = MyServiceDetailViewController()
            detail.modelDetail = model
            detail.indexRow = indexPath.row
            detail.delegate = self
            self.navigationController?.pushViewController(detail, animated: true)
        }else if indexPath.section == 1 {
            let model = listAuction[indexPath.row]
            let detail = MyAuctionServiceDetailViewController()
            detail.delegate = self
            detail.indexRow = indexPath.row
            detail.modelDetail = model
            self.navigationController?.pushViewController(detail, animated: true)
        }else {
            let model = listEvents[indexPath.row]
            let detail = MyEventServiceDetailViewController()
            detail.delegate = self
            detail.indexRow = indexPath.row
            detail.modelDetail = model
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
}

extension MyServicesViewController: MyServiceDetailViewControllerProtocol{
    func didDeleteData(_ index: Int) {
        self.listBaseService.remove(at: index)
        self.tbvMyServices.reloadData()
    }
}

extension MyServicesViewController: MyAuctionServiceDetailViewControllerProtocol {
    func didDeleteAuction(_ index: Int) {
        self.listAuction.remove(at: index)
        self.tbvMyServices.reloadData()
    }
}

extension MyServicesViewController: MyEventServiceDetailViewControllerProtocol {
    func didDeleteEvent(_ index: Int) {
        self.listEvents.remove(at: index)
        self.tbvMyServices.reloadData()
    }
}
