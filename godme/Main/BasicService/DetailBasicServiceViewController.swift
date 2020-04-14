//
//  DetailBasicServiceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/9/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import SDWebImage
import Toaster

enum typeCellDetailBasic: Int {
    case Avatar = 0
    case Address = 1
    case Detail = 2
    case Book = 3
}

class DetailBasicServiceViewController: BaseViewController {

    @IBOutlet weak var tbvDetailBasicService: UITableView!
    var listTypeCell: [typeCellDetailBasic] = [.Avatar, .Address, .Detail, .Book]
    var modelDetail: BaseServiceModel?
    var listBaseService: [BaseServiceModel] = []
    var cellImageDetail: ImageDetailTableViewCell!
    var modelUser = Settings.ShareInstance.getDictUser()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showProgressHub()
        self.setupUI()
        self.setupTableView()
        self.configButtonBack()
        self.getListBaseServiceByCurrentService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = modelDetail?.title
    }
    
    func setupUI(){
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setupTableView(){
        self.tbvDetailBasicService.register(UINib(nibName: "ImageDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageDetailTableViewCell")
        self.tbvDetailBasicService.register(UINib(nibName: "TimeAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "TimeAddressTableViewCell")
        self.tbvDetailBasicService.register(UINib(nibName: "InfoDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoDetailTableViewCell")
        self.tbvDetailBasicService.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        self.tbvDetailBasicService.register(UINib(nibName: "BookServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "BookServiceTableViewCell")
        self.tbvDetailBasicService.register(UINib.init(nibName: "HeaderSubMain", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderSubMain")
        self.tbvDetailBasicService.delegate = self
        self.tbvDetailBasicService.dataSource = self
        self.tbvDetailBasicService.separatorColor = UIColor.clear
        self.tbvDetailBasicService.separatorInset = UIEdgeInsets.zero
        self.tbvDetailBasicService.estimatedRowHeight = 300
        self.tbvDetailBasicService.rowHeight = UITableView.automaticDimension
    }
    
    func getListBaseServiceByCurrentService(){
        ManageServicesManager.shareManageServicesManager().getListBaseServiceByCurrentService(currentServiceId: modelDetail?.id ?? 0, page: 1, pageSize: 1000) { [unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listBaseService.append(model)
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

extension DetailBasicServiceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return listTypeCell.count
        }else{
            return 1
        }
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
            header.lbTitle.text = "Các dịch vụ khác"
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
                cellImageDetail = tableView.dequeueReusableCell(withIdentifier: "ImageDetailTableViewCell") as? ImageDetailTableViewCell
                let images = modelDetail?.images
                let arrImgage = images?.split(separator: ",")
                var arrImg: [String] = []
                if let arrImgage = arrImgage {
                    for item in arrImgage {
                        arrImg.append(String(item))
                    }
                }
                cellImageDetail.arrImageBanner = arrImg
                cellImageDetail.delegate = self
                if cellImageDetail.arrImageBanner.count > 0 {
                    cellImageDetail.crollViewImage()
                    cellImageDetail.configCrollView()
                }
                cellImageDetail.imgAvatar.sd_setImage(with: URL.init(string: modelDetail?.userInfo?.avatar ?? ""), placeholderImage: UIImage.init(named: "ic_avatar"), options: .lowPriority) {[unowned self] (image, error, nil, link) in
                    if error == nil {
                        self.cellImageDetail.imgAvatar.image = image
                    }
                }
                cellImageDetail.lbFullName.text = modelDetail?.userInfo?.fullName
                cellImageDetail.lbJob.text = modelDetail?.title
                cellImageDetail.lbCoin.text = "\(Double(modelDetail?.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
                cellImageDetail.constraintHeightLabelCopy.constant = 0
                if modelDetail?.isRelationshipWithSeller ?? false {
                    cellImageDetail.constraintHeightLabelCopy.constant = 20
                }
                return cellImageDetail
            case .Address:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TimeAddressTableViewCell") as! TimeAddressTableViewCell
//                let date = NSDate.init(timeIntervalSinceNow: modelDetail?.dateTime1 ?? 0.0)
//                print("date = \(date)")
                cell.lbAddress.text = modelDetail?.address
                cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.dateTime1 ?? 0.0) + " - " + Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.dateTime2 ?? 0.0) + " - " + Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.dateTime3 ?? 0.0) + " - " + Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.dateTime4 ?? 0.0) + " - " + Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.dateTime5 ?? 0.0) + " - " + Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.dateTime6 ?? 0.0) + " - " + Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.dateTime7 ?? 0.0)
                cell.lbLanguages.text = modelDetail?.language
                cell.lbNumberBooked.text = "Tổng số người đặt: \(modelDetail?.totalOrder ?? 0)"
                return cell
            case .Detail:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InfoDetailTableViewCell") as! InfoDetailTableViewCell
                cell.lbDetail.text = modelDetail?.description
                return cell
            case .Book:
                let cell = tableView.dequeueReusableCell(withIdentifier: "BookServiceTableViewCell") as! BookServiceTableViewCell
                cell.delegate = self
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
            cell.delegate = self
            cell.listBaseService = self.listBaseService
            cell.collectionView.reloadData()
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension DetailBasicServiceViewController: BookServiceTableViewCellProtocol{
    func didBookService() {
        
        let confirm = ConfirmBasicServiceViewController()
        confirm.modelDetail = modelDetail
        self.navigationController?.pushViewController(confirm, animated: true)
    }
}

extension DetailBasicServiceViewController: ImageDetailTableViewCellProtocol{
    func didFullName() {
        let searchBarDetail = SearchBarDetailViewController()
        searchBarDetail.userId = modelDetail?.userInfo?.id ?? 0
        self.navigationController?.pushViewController(searchBarDetail, animated: true)
    }
    
    func didCopy() {
        let str = "\(modelDetail?.title ?? "") \(modelDetail?.id ?? 0)"
        UIPasteboard.general.string = "\(URLs.linkServicebase)\(str.convertedToSlug() ?? "")?refId=\(modelUser.userId ?? 0)"
        Toast.init(text: "Copy").show()
    }
    
    func didCoinConvert() {
        if (cellImageDetail.lbCoin.text?.contains("Godcoin"))! {
            cellImageDetail.lbCoin.text = Settings.ShareInstance.formatCurrency(Value: "\((Double(modelDetail?.amount ?? "0") ?? 0)*1000)")
        }else{
            cellImageDetail.lbCoin.text = "\(Double(modelDetail?.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
        }
    }
    
    func didShowMore() {
        let alertControl = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let action2 = UIAlertAction.init(title: "Tạo dịch vụ của bạn", style: .default) {[unowned self] (action) in
            alertControl.dismiss(animated: true, completion: nil)
            let createService = CreateServiceViewController()
            self.navigationController?.pushViewController(createService, animated: true)
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

extension DetailBasicServiceViewController: MainTableViewCellProtocol{
    func didCell(index: Int) {
        print("index = ", index)
        let model = listBaseService[index]
        let detail = DetailBasicServiceViewController()
        detail.modelDetail = model
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
