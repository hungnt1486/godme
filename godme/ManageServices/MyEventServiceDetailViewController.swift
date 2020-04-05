//
//  MyEventServiceDetailViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/27/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class MyEventServiceDetailViewController: BaseViewController {

    @IBOutlet weak var tbvMyEventServiceDetail: UITableView!
    
    var modelDetail: EventModel?
    var modelUser = Settings.ShareInstance.getDictUser()
    var listOrderEventServiceDetail: [EventServiceInfoBookedModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showProgressHub()
        self.setupTableView()
        self.configButtonBack()
        self.getDetailOrderEventService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupUI()
    }
    
    func setupUI(){
         self.navigationItem.title = modelDetail?.title ?? ""
     }
    
     func setupTableView(){
         self.tbvMyEventServiceDetail.register(UINib(nibName: "EventsTableViewCell", bundle: nil), forCellReuseIdentifier: "EventsTableViewCell")
     
         self.tbvMyEventServiceDetail.register(UINib(nibName: "MyEventServicesDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "MyEventServicesDetailTableViewCell")
        self.tbvMyEventServiceDetail.register(UINib(nibName: "DefaultTableViewCell", bundle: nil), forCellReuseIdentifier: "DefaultTableViewCell")
        

         self.tbvMyEventServiceDetail.delegate = self
         self.tbvMyEventServiceDetail.dataSource = self
         self.tbvMyEventServiceDetail.separatorColor = UIColor.clear
         self.tbvMyEventServiceDetail.separatorInset = UIEdgeInsets.zero
         self.tbvMyEventServiceDetail.estimatedRowHeight = 300
         self.tbvMyEventServiceDetail.rowHeight = UITableView.automaticDimension
        
         self.tbvMyEventServiceDetail.tableFooterView = UIView(frame: .zero)
         self.tbvMyEventServiceDetail.register(UINib.init(nibName: "HeaderServicesInfoBook", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderServicesInfoBook")
     }
     
     func getDetailOrderEventService(){
         ManageServicesManager.shareManageServicesManager().getListOrderEventService(sellerId: modelDetail?.userInfo?.id ?? 0, serviceId: modelDetail?.id ?? 0) { [unowned self](response) in
             switch response {
                 
             case .success(let data):
                 self.hideProgressHub()
                 for model in data {
                     self.listOrderEventServiceDetail.append(model)
                 }
                 self.tbvMyEventServiceDetail.reloadData()
                 break
             case .failure(let message):
                 self.hideProgressHub()
                 Settings.ShareInstance.showAlertView(message: message, vc: self)
                 break
             }
         }
     }

}

extension MyEventServiceDetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return listOrderEventServiceDetail.count
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
        if section == 1 {
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventsTableViewCell") as! EventsTableViewCell
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
            cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.startTime ?? 0.0)
            cell.lbCity.text = modelDetail?.address
            cell.lbCoin.text = "\(Int(modelDetail?.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
            cell.lbName.text = "Số người đăng ký: \(modelDetail?.totalOrder ?? 0)/\(modelDetail?.maxOrder ?? 0)"
            return cell
        }else{
            if listOrderEventServiceDetail.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultTableViewCell") as! DefaultTableViewCell
                cell.lbTitle.text = "Chưa có người đăng ký tham gia"
                return cell
                
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyEventServicesDetailTableViewCell") as! MyEventServicesDetailTableViewCell
            let model = listOrderEventServiceDetail[indexPath.row]
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
        if indexPath.section == 0 {
            let detail = DetailEventViewController()
            detail.modelDetail = modelDetail
            self.navigationController?.pushViewController(detail, animated: true)
        }else {
            let model = self.listOrderEventServiceDetail[indexPath.row]
            let searchBarDetail = SearchBarDetailViewController()
            searchBarDetail.userId = model.buyerId ?? 0
            self.navigationController?.pushViewController(searchBarDetail, animated: true)
        }
    }
    
    
}
