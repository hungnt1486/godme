//
//  DetailBasicServiceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/9/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

enum typeCellDetailEvent: Int {
    case Avatar = 0
    case Address = 1
    case Detail = 2
    case Book = 3
}

class DetailEventViewController: BaseViewController {

    @IBOutlet weak var tbvDetailBasicService: UITableView!
    var listTypeCell: [typeCellDetailEvent] = [.Avatar, .Address, .Detail, .Book]
    var modelDetail: EventModel?
    var listEvents: [EventModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showProgressHub()
        self.setupUI()
        self.setupTableView()
        self.configButtonBack()
        self.getListEventServiceByCurrentService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = modelDetail?.title ?? ""
    }
    
    func setupUI(){
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setupTableView(){
        self.tbvDetailBasicService.register(UINib(nibName: "ImageDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageDetailTableViewCell")
        self.tbvDetailBasicService.register(UINib(nibName: "TimeAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "TimeAddressTableViewCell")
        self.tbvDetailBasicService.register(UINib(nibName: "InfoDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoDetailTableViewCell")
        self.tbvDetailBasicService.register(UINib(nibName: "BookServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "BookServiceTableViewCell")
        self.tbvDetailBasicService.register(UINib(nibName: "Main2TableViewCell", bundle: nil), forCellReuseIdentifier: "Main2TableViewCell")
        self.tbvDetailBasicService.register(UINib.init(nibName: "HeaderSubMain", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderSubMain")
        self.tbvDetailBasicService.delegate = self
        self.tbvDetailBasicService.dataSource = self
        self.tbvDetailBasicService.separatorColor = UIColor.clear
        self.tbvDetailBasicService.separatorInset = UIEdgeInsets.zero
        self.tbvDetailBasicService.estimatedRowHeight = 300
        self.tbvDetailBasicService.rowHeight = UITableView.automaticDimension
    }
    
    func getListEventServiceByCurrentService(){
        ManageServicesManager.shareManageServicesManager().getListEventServiceByCurrentService(currentServiceId: modelDetail?.id ?? 0, page: 1, pageSize: 1000) { [unowned self](response) in
            switch response {
                case .success(let data):
                    self.hideProgressHub()
                    for model in data {
                        self.listEvents.append(model)
                    }
                    self.tbvDetailBasicService.reloadData()
                    break
                case .failure(let message):
                    self.hideProgressHub()
                    Settings.ShareInstance.showAlertView(message: message, vc: self)
                    break
            }
        }
    }
}

extension DetailEventViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return listTypeCell.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 290
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderSubMain") as! HeaderSubMain
            header.backgroundColor = UIColor.FlatColor.Gray.BGColor
            header.btMore.isHidden = true
            header.lbTitle.text = "Các đấu giá khác"
            return header
        }
        return UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let typeCell = listTypeCell[indexPath.row]
            
            switch typeCell {
                
            case .Avatar:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ImageDetailTableViewCell") as! ImageDetailTableViewCell
                let images = modelDetail?.images
                let arrImgage = images?.split(separator: ",")
                var arrImg: [String] = []
                if let arrImgage = arrImgage {
                    for item in arrImgage {
                        arrImg.append(String(item))
                    }
                }
                cell.arrImageBanner = arrImg
                cell.delegate = self
                if cell.arrImageBanner.count > 0 {
                    cell.crollViewImage()
                    cell.configCrollView()
                }
                cell.imgAvatar.sd_setImage(with: URL.init(string: modelDetail?.userInfo?.avatar ?? ""), placeholderImage: UIImage.init(named: "ic_avatar"), options: .lowPriority) { (image, error, nil, link) in
                    if error == nil {
                        cell.imgAvatar.image = image
                    }
                }
                cell.lbFullName.text = modelDetail?.userInfo?.fullName
                cell.lbJob.text = modelDetail?.title
                cell.lbCoin.text = "\(Int(modelDetail?.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
                return cell
            case .Address:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TimeAddressTableViewCell") as! TimeAddressTableViewCell
                cell.contraintHeightV1.constant = 0
                cell.v1.isHidden = true
                cell.lbAddress.text = modelDetail?.address
                cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.startTime ?? 0.0) + " - " + Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.endTime ?? 0.0)
                 cell.lbLanguages.text = modelDetail?.language
                return cell
            case .Detail:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InfoDetailTableViewCell") as! InfoDetailTableViewCell
                cell.lbDetail.text = modelDetail?.description
                return cell
            case .Book:
                let cell = tableView.dequeueReusableCell(withIdentifier: "BookServiceTableViewCell") as! BookServiceTableViewCell
                cell.btBookService.setTitle("Tham gia sự kiện", for: .normal)
                cell.delegate = self
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Main2TableViewCell") as! Main2TableViewCell
            cell.delegate = self
            cell.listEvents = self.listEvents
            cell.collectionView.reloadData()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension DetailEventViewController: BookServiceTableViewCellProtocol{
    func didBookService() {
        Settings.ShareInstance.showAlertViewWithOkCancel(message: "Bạn có chắc chắn tham gia sự kiện?", vc: self) { (str) in
            let modelUser = Settings.ShareInstance.getDictUser()
            var model = AddNewConfirmBasicServiceParams()
            model.amount = Int(self.modelDetail?.amount ?? "0")
            model.buyerId = modelUser.userId ?? 0
            model.sellerId = self.modelDetail?.userInfo?.id
            model.serviceId = self.modelDetail?.id
            ManageServicesManager.shareManageServicesManager().createOrderEventSave(model: model) { [unowned self] (response) in
                switch response {
                    
                case .success(let data):
                    self.hideProgressHub()
                    print("data = \(data)")
                    Settings.ShareInstance.showAlertView(message: data.MessageInfo, vc: self)
                    break
                case .failure(let message):
                    self.hideProgressHub()
                    Settings.ShareInstance.showAlertView(message: message, vc: self)
                    break
                }
            }
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

extension DetailEventViewController: ImageDetailTableViewCellProtocol{
    func didShowMore() {
        let alertControl = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let action2 = UIAlertAction.init(title: "Tạo sự kiện của bạn", style: .default) {[unowned self] (action) in
            alertControl.dismiss(animated: true, completion: nil)
            let createEvent = CreateEventViewController()
            self.navigationController?.pushViewController(createEvent, animated: true)
        }
        let action3 = UIAlertAction.init(title: "Báo lỗi", style: .default) {[unowned self] (action) in
            alertControl.dismiss(animated: true, completion: nil)
            let help = HelpViewController()
            self.navigationController?.pushViewController(help, animated: true)
        }
        let actionCancel = UIAlertAction.init(title: "Huỷ", style: .cancel) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        
        alertControl.addAction(action2)
        alertControl.addAction(action3)
        alertControl.addAction(actionCancel)
        self.navigationController?.present(alertControl, animated: true, completion: nil)
    }
}

extension DetailEventViewController: Main2TableViewCellProtocol{
    func didCellMain2(index: Int) {
        print("index2 = ", index)
        let model = listEvents[index]
        let detail = DetailEventViewController()
        detail.modelDetail = model
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
