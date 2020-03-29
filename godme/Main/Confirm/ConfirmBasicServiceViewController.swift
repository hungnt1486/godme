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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configButtonBack()
        self.setupTableView()
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
            let linkImg = arrImgage?[0]
            cell.imgAvatar.sd_setImage(with: URL.init(string: String(linkImg ?? "")), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
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
            let currentDate = Date()
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            
            var model = AddNewConfirmBasicServiceParams()
            model.amount = Int(self.modelDetail?.amount ?? "0")
            model.buyerId = self.modelDetail?.userInfo?.id
            model.sellerId = self.modelDetail?.createdByUserId
            model.serviceId = self.modelDetail?.id
            model.dateTime = Settings.ShareInstance.convertDateToTimeInterval(date: formatter.date(from: formatter.string(from: currentDate)) ?? Date())
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
