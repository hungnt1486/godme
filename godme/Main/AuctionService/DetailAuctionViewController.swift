//
//  DetailAuctionViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/10/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

enum typeCellDetailAuction: Int {
    case Avatar = 0
    case Auction = 1
    case Address = 2
    case Detail = 3
//    case Book = 3
}

class DetailAuctionViewController: BaseViewController {

    @IBOutlet weak var tbvDetailAuction: UITableView!
    var listTypeCell: [typeCellDetailAuction] = [.Avatar, .Auction, .Address, .Detail]
    var modelDetail: AuctionServiceModel?
    var listAuction:[AuctionServiceModel] = []
    var cellInfo: InfoAuctionTableViewCell!
    var modelUser = Settings.ShareInstance.getDictUser()
    var listLanguage = Settings.ShareInstance.Languages()
    var serviceID = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showProgressHub()
        self.setupUI()
        self.setupTableView()
        self.configButtonBack()
        if serviceID == 0 {
            self.getListAuctionServiceByCurrentService()
        }else{
            self.getDetailBaseService()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if serviceID == 0 {
            self.navigationItem.title = modelDetail?.title
        }
    }
    
    func setupUI(){
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setupTableView(){
        self.tbvDetailAuction.register(UINib(nibName: "ImageDetailAuctionTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageDetailAuctionTableViewCell")
        self.tbvDetailAuction.register(UINib(nibName: "InfoAuctionTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoAuctionTableViewCell")
        self.tbvDetailAuction.register(UINib(nibName: "TimeAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "TimeAddressTableViewCell")
        self.tbvDetailAuction.register(UINib(nibName: "InfoDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoDetailTableViewCell")
        self.tbvDetailAuction.register(UINib(nibName: "Main1TableViewCell", bundle: nil), forCellReuseIdentifier: "Main1TableViewCell")
        self.tbvDetailAuction.register(UINib.init(nibName: "HeaderSubMain", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderSubMain")
        self.tbvDetailAuction.delegate = self
        self.tbvDetailAuction.dataSource = self
        self.tbvDetailAuction.separatorColor = UIColor.clear
        self.tbvDetailAuction.separatorInset = UIEdgeInsets.zero
        self.tbvDetailAuction.estimatedRowHeight = 300
        self.tbvDetailAuction.rowHeight = UITableView.automaticDimension
    }
    
    func getDetailBaseService(){
        ManageServicesManager.shareManageServicesManager().getDetailAuctionService(id: serviceID) { [unowned self](response) in
            switch response {
                
            case .success(let data):
//                self.hideProgressHub()
                self.modelDetail = data[0]
                self.navigationItem.title = self.modelDetail?.title ?? ""
                self.getListAuctionServiceByCurrentService()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func getListAuctionServiceByCurrentService(){
        ManageServicesManager.shareManageServicesManager().getListAuctionServiceByCurrentService(currentServiceId: modelDetail?.id ?? 0, page: 1, pageSize: 1000) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listAuction.append(model)
                }
                self.tbvDetailAuction.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func createOrderAuction(sellerId: Int, serviceId: Int, buyerId: Int, amount: Double){
        ManageServicesManager.shareManageServicesManager().createOrderAuction(sellerId: sellerId, serviceId: serviceId, buyerId: buyerId, amount: amount) {[unowned self] (response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: Settings.ShareInstance.translate(key: "label_you_have_successfull_bid"), vc: self) {[unowned self] (str) in
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

extension DetailAuctionViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return listTypeCell.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 130
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderSubMain") as! HeaderSubMain
            header.backgroundColor = UIColor.FlatColor.Gray.BGColor
            header.btMore.isHidden = true
            header.lbTitle.text = Settings.ShareInstance.translate(key: "label_auction_difference")
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "ImageDetailAuctionTableViewCell") as! ImageDetailAuctionTableViewCell
                cell.arrImageBanner = ["ic_banner_default"]
                cell.delegate = self
                if cell.arrImageBanner.count > 0 {
                    cell.crollViewImage()
                    cell.configCrollView()
                }
                
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
                cell.lbCoin.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.endTime ?? 0.0)//(modelDetail?.amount ?? "0") + " Godcoin"
                cell.constraintHeightLabelCopy.constant = 0
                if modelDetail?.isRelationshipWithSeller ?? false {
                    cell.constraintHeightLabelCopy.constant = 20
                }
                let date = Date()
                if modelDetail?.endTime ?? 0.0 > Settings.ShareInstance.convertDateToTimeInterval(date: date) {
                    cell.dateTime = Settings.ShareInstance.convertTimeIntervalToDateTimeForCountDown(timeInterval: modelDetail?.endTime ?? 0.0)
                    cell.countDown()
                }else{
                    cell.lbCoin.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.endTime ?? 0.0)
                    
                }
                return cell
            case .Auction:
                cellInfo = tableView.dequeueReusableCell(withIdentifier: "InfoAuctionTableViewCell") as? InfoAuctionTableViewCell
                cellInfo.delegate = self
                cellInfo.lbWiner.text = modelDetail?.currentWinner
                cellInfo.lbStepMoney.text = "\(Double(modelDetail?.priceStep ?? "0")?.formatnumber() ?? "0") Godcoin"
                cellInfo.lbPrice.text = "\(Double(modelDetail?.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
                cellInfo.lbNumber.text = "\(modelDetail?.totalOrder ?? 0)"
                let date = Date()
                if modelDetail?.endTime ?? 0.0 < Settings.ShareInstance.convertDateToTimeInterval(date: date) {
                    cellInfo.btAuction.isUserInteractionEnabled = false
                    cellInfo.tfMoney.isUserInteractionEnabled = false
                    cellInfo.btAuction.backgroundColor = UIColor.FlatColor.Gray.TextColor
                }
                return cellInfo
            case .Address:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TimeAddressTableViewCell") as! TimeAddressTableViewCell
                cell.contraintHeightV1.constant = 0
                cell.v1.isHidden = true
                cell.lbAddress.text = modelDetail?.address
                cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.startTime ?? 0.0) + " - " + Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.endTime ?? 0.0)
                for item in self.listLanguage {
                    if item.Id ?? "" == modelDetail?.language {
                        cell.lbLanguages.text = Settings.ShareInstance.translate(key: item.Name ?? "")
                        break
                    }
                }
                return cell
            case .Detail:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InfoDetailTableViewCell") as! InfoDetailTableViewCell
                cell.lbTitle.text = Settings.ShareInstance.translate(key: "label_detail")
                cell.lbDetail.text = modelDetail?.description
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Main1TableViewCell") as! Main1TableViewCell
            cell.delegate = self
            cell.listAuction = self.listAuction
            cell.collectionView.reloadData()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension DetailAuctionViewController: ImageDetailAuctionTableViewCellProtocol{
    func didFullName() {
        let searchBarDetail = SearchBarDetailViewController()
        searchBarDetail.userId = modelDetail?.userInfo?.id ?? 0
        self.navigationController?.pushViewController(searchBarDetail, animated: true)
    }
    
    func didCopy() {
        let str = "\(modelDetail?.title ?? "") \(modelDetail?.id ?? 0)"
        UIPasteboard.general.string = "\(URLs.linkServiceAuction)\(str.convertedToSlug() ?? "")?refId=\(modelUser.userId ?? 0)"
        self.showToast()
    }
    
    func didShowMoreAuction() {
        let alertControl = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let action2 = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_create_my_auction"), style: .default) {[unowned self] (action) in
            alertControl.dismiss(animated: true, completion: nil)
            let createAuction = CreateAuctionViewController()
            self.navigationController?.pushViewController(createAuction, animated: true)
        }
        let action3 = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_error"), style: .default) {[unowned self] (action) in
            alertControl.dismiss(animated: true, completion: nil)
            let help = HelpViewController()
            self.navigationController?.pushViewController(help, animated: true)
        }
        let actionCancel = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_cancel"), style: .cancel) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        
        alertControl.addAction(action2)
        alertControl.addAction(action3)
        alertControl.addAction(actionCancel)
        self.navigationController?.present(alertControl, animated: true, completion: nil)
    }
    
    
}

extension DetailAuctionViewController: Main1TableViewCellProtocol{
    func didCellMain1(index: Int) {
        print("index1 = ", index)
        let model = listAuction[index]
        let detail = DetailAuctionViewController()
        detail.modelDetail = model
        self.navigationController?.pushViewController(detail, animated: true)
    }
}

extension DetailAuctionViewController: InfoAuctionTableViewCellProtocol{
    func didCoinConvert() {
        if (cellInfo.lbPrice.text?.contains("Godcoin"))! {
            cellInfo.lbPrice.text = Settings.ShareInstance.formatCurrency(Value: "\((Double(modelDetail?.amount ?? "0") ?? 0)*1000)")
            cellInfo.lbStepMoney.text = Settings.ShareInstance.formatCurrency(Value: "\((Double(modelDetail?.priceStep ?? "0") ?? 0)*1000)")
        }else{
            cellInfo.lbPrice.text = "\(Double(modelDetail?.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
            cellInfo.lbStepMoney.text = "\(Double(modelDetail?.priceStep ?? "0")?.formatnumber() ?? "0") Godcoin"
        }
    }
    
    func didAuction() {
        Settings.ShareInstance.showAlertViewWithOkCancel(message: Settings.ShareInstance.translate(key: "label_are_you_sure_auction"), vc: self) {[unowned self] (str) in
            self.showProgressHub()
            self.createOrderAuction(sellerId: self.modelDetail?.userInfo?.id ?? 0, serviceId: self.modelDetail?.id ?? 0, buyerId: self.modelUser.userId ?? 0, amount: Double(self.cellInfo.tfMoney.text ?? "0.0") ?? 0.0)
        }
    }
    
    
}
