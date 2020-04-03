//
//  ConfirmBasicServiceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/10/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

enum typeCellConfirm: Int {
    case Basic = 0
    case ConfirmContent = 1
    case ConfirmButton = 2
}

class ConfirmBasicServiceViewController: BaseViewController {

    @IBOutlet weak var tbvConfirmBasicService: UITableView!
    let listTypeCell:[typeCellConfirm] = [.Basic, .ConfirmContent, .ConfirmButton]
    var modelDetail: BaseServiceModel?
    var indexDateTime: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configButtonBack()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = modelDetail?.title ?? ""
    }
    
    func setupTableView(){
           self.tbvConfirmBasicService.register(UINib(nibName: "BasicServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "BasicServicesTableViewCell")
           self.tbvConfirmBasicService.register(UINib(nibName: "ConfirmBasicServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "ConfirmBasicServiceTableViewCell")
           self.tbvConfirmBasicService.register(UINib(nibName: "BookServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "BookServiceTableViewCell")

           self.tbvConfirmBasicService.delegate = self
           self.tbvConfirmBasicService.dataSource = self
           self.tbvConfirmBasicService.separatorColor = UIColor.clear
           self.tbvConfirmBasicService.separatorInset = UIEdgeInsets.zero
           self.tbvConfirmBasicService.estimatedRowHeight = 300
           self.tbvConfirmBasicService.rowHeight = UITableView.automaticDimension
       }
}

extension ConfirmBasicServiceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let typeCell = listTypeCell[indexPath.row]
        
        switch typeCell {
            
        case .Basic:
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
            cell.lbCity.text = "Địa chỉ: \(modelDetail?.address ?? "")"
            cell.lbName.text = modelDetail?.userInfo?.userCategory
            cell.lbCoin.text = "\(modelDetail?.amount ?? "0") Godcoin"
            return cell
        case .ConfirmContent:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ConfirmBasicServiceTableViewCell") as! ConfirmBasicServiceTableViewCell
            cell.lbMoney.text = "\(modelDetail?.amount ?? "0") Godcoin"
            var arr: [String] = []
            if ((modelDetail?.dateTime1) != 0) {
                arr.append(Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.dateTime1 ?? 0.0))
            }
            if ((modelDetail?.dateTime2) != 0) {
                arr.append(Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.dateTime2 ?? 0.0))
            }
            if ((modelDetail?.dateTime3) != 0) {
                arr.append(Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.dateTime3 ?? 0.0))
            }
            if ((modelDetail?.dateTime4) != 0) {
                arr.append(Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.dateTime4 ?? 0.0))
            }
            if ((modelDetail?.dateTime5) != 0) {
                arr.append(Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.dateTime5 ?? 0.0))
            }
            if ((modelDetail?.dateTime6) != 0) {
                arr.append(Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.dateTime6 ?? 0.0))
            }
            if ((modelDetail?.dateTime7) != 0) {
                arr.append(Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: modelDetail?.dateTime7 ?? 0.0))
            }
            cell.arrString = arr
            cell.setupTypeDropdown()
            cell.delegate = self
            return cell
        case .ConfirmButton:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookServiceTableViewCell") as! BookServiceTableViewCell
            cell.btBookService.setTitle("Xác nhận đặt dịch vụ", for: .normal)
            cell.delegate = self
            return cell
        }
    }
}

extension ConfirmBasicServiceViewController: BookServiceTableViewCellProtocol{
    func didBookService() {
        Settings.ShareInstance.showAlertViewWithOkCancel(message: "Bạn có chắc chắn đặt dịch vụ?", vc: self) { [unowned self](str) in
            let modelUser = Settings.ShareInstance.getDictUser()
            var model = AddNewConfirmBasicServiceParams()
            model.amount = Int(self.modelDetail?.amount ?? "0")
            model.buyerId = modelUser.userId ?? 0
            model.sellerId = self.modelDetail?.userInfo?.id
            model.serviceId = self.modelDetail?.id
            
            switch self.indexDateTime {
            case 0:
                model.dateTime = self.modelDetail?.dateTime1
                break
            case 1:
                model.dateTime = self.modelDetail?.dateTime2
                break
            case 2:
                model.dateTime = self.modelDetail?.dateTime3
                break
            case 3:
                model.dateTime = self.modelDetail?.dateTime4
                break
            case 4:
                model.dateTime = self.modelDetail?.dateTime5
                break
            case 5:
                model.dateTime = self.modelDetail?.dateTime6
                break
            case 6:
                model.dateTime = self.modelDetail?.dateTime7
                break
            default:
                model.dateTime = self.modelDetail?.dateTime1
                break
            }
            ManageServicesManager.shareManageServicesManager().confirmBookBaseService(model: model) { [unowned self] (response) in
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

extension ConfirmBasicServiceViewController: ConfirmBasicServiceTableViewCellProtocol{
    func getTextDateTime(_ index: Int) {
        indexDateTime = index
    }
}
