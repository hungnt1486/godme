//
//  ServicesInfoBookedViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class ServicesInfoBookedViewController: BaseViewController {

    @IBOutlet weak var tbvServicesInfoBook: CollapseTableView!
    
    var listBaseService: [BaseServiceInfoBookedModel] = []
    var listAuction:[AuctionServiceInfoBookedModel] = []
    var listEvents: [EventServiceInfoBookedModel] = []
    var modelUser = Settings.ShareInstance.getDictUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupTableView()
        
        self.tbvServicesInfoBook.didTapSectionHeaderView = { (sectionIndex, isOpen) in
            debugPrint("sectionIndex \(sectionIndex), isOpen \(isOpen)")
        }
        reloadTableView { [unowned self] in
            self.tbvServicesInfoBook.openSection(0, animated: true)
        }
        
        self.showProgressHub()
        self.getListSearchOrderBaseService()
        self.getListSearchOrderAuctionService()
        self.getListSearchOrderEventService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tbvServicesInfoBook.reloadData()
    }
    
    func setupTableView(){
        self.tbvServicesInfoBook.register(UINib(nibName: "ServicesInfoBookTableViewCell", bundle: nil), forCellReuseIdentifier: "ServicesInfoBookTableViewCell")
        
//        self.tbvServicesInfoBook.register(UINib(nibName: "BasicServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "BasicServicesTableViewCell")
//        self.tbvServicesInfoBook.register(UINib(nibName: "AuctionServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "AuctionServicesTableViewCell")
//        self.tbvServicesInfoBook.register(UINib(nibName: "EventsTableViewCell", bundle: nil), forCellReuseIdentifier: "EventsTableViewCell")

        self.tbvServicesInfoBook.delegate = self
        self.tbvServicesInfoBook.dataSource = self
        self.tbvServicesInfoBook.separatorColor = UIColor.clear
        self.tbvServicesInfoBook.separatorInset = UIEdgeInsets.zero
        self.tbvServicesInfoBook.estimatedRowHeight = 300
        self.tbvServicesInfoBook.rowHeight = UITableView.automaticDimension
        
        self.tbvServicesInfoBook.tableFooterView = UIView(frame: .zero)
        self.tbvServicesInfoBook.register(UINib.init(nibName: "SectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
    }
    
    func reloadTableView(_ completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            completion()
        })
        self.tbvServicesInfoBook.reloadData()
        CATransaction.commit()
    }
    
    func getListSearchOrderBaseService(){
        ManageServicesManager.shareManageServicesManager().searchOrderBaseService(buyerId: modelUser.userId!, sorts: [["field":"modifiedOn", "order": "desc"]], page: 1, pageSize: 1000) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listBaseService.append(model)
                }
                self.tbvServicesInfoBook.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func getListSearchOrderAuctionService(){
        ManageServicesManager.shareManageServicesManager().searchOrderAuctionService(buyerId: modelUser.userId!, sorts: [["field":"modifiedOn", "order": "desc"]], page: 1, pageSize: 1000) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listAuction.append(model)
                }
                self.tbvServicesInfoBook.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func getListSearchOrderEventService(){
        ManageServicesManager.shareManageServicesManager().searchOrderEventService(buyerId: modelUser.userId!, sorts: [["field":"modifiedOn", "order": "desc"]], page: 1, pageSize: 1000) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listEvents.append(model)
                }
                self.tbvServicesInfoBook.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
}

extension ServicesInfoBookedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return listBaseService.count
        }else if section == 1 {
            return listAuction.count
        }else{
            return listEvents.count
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesInfoBookTableViewCell") as! ServicesInfoBookTableViewCell
            let model = listBaseService[indexPath.row]
            cell.lbTitle.text = model.serviceTitle ?? ""
            cell.lbCoinResult.text = "\(Double(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
            cell.lbStatusResult.text = Settings.ShareInstance.translate(key: model.status ?? "")
            cell.lbTimeResult.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: model.createdOn ?? 0.0)
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesInfoBookTableViewCell") as! ServicesInfoBookTableViewCell
            let model = listAuction[indexPath.row]
            cell.lbTitle.text = model.serviceTitle ?? ""
            cell.lbCoinResult.text = "\(Double(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
            cell.lbStatusResult.text = Settings.ShareInstance.translate(key: model.status ?? "")
            cell.lbTimeResult.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: model.createdOn ?? 0.0)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesInfoBookTableViewCell") as! ServicesInfoBookTableViewCell
            let model = listEvents[indexPath.row]
            cell.lbTitle.text = model.serviceTitle ?? ""
            cell.lbCoinResult.text = "\(Double(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
            cell.lbStatusResult.text = Settings.ShareInstance.translate(key: model.status ?? "")
            cell.lbTimeResult.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: model.createdOn ?? 0.0)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let model = listBaseService[indexPath.row]
            let service = ServicesInfoBookedDetailViewController()
            service.listBaseServiceDetail = model
            self.navigationController?.pushViewController(service, animated: true)
        } else if indexPath.section == 1 {
            let model = listAuction[indexPath.row]
            let service = ServicesInfoBookedDetailAuctionViewController()
//            service.serviceId = model.serviceId ?? 0
            service.listAuctionServiceDetail = model
            self.navigationController?.pushViewController(service, animated: true)
        } else{
            let model = listEvents[indexPath.row]
            let service = ServicesInfoBookedDetailEventViewController()
//            service.serviceId = model.serviceId ?? 0
            service.listEventServiceDetail = model
            self.navigationController?.pushViewController(service, animated: true)
        }
    }
    
    
}
