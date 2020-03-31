//
//  HelpViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/30/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

@objc enum typeCellPushNotification: Int {
    case Image = 0
    case Title = 1
    case Description = 2
}

//enum typeCellPushNotification1: Int {
//    case CheckBox = 0
//}
//
//enum typeCellPushNotification2: Int {
//    case Confirm = 0
//}

class PushNotificationViewController: BaseViewController {

    @IBOutlet weak var tbvHelp: UITableView!
    var listTypeCell: [typeCellPushNotification] = [.Image, .Title, .Description]
//    var listTypeCell1: [typeCellPushNotification1] = [.CheckBox]
//    var listTypeCell2: [typeCellPushNotification2] = [.Confirm]
    
    var cellImage: ImageCarTableViewCell!
    var strImgBase64: String = ""
    var imagePicker = UIImagePickerController()
    var index: Int = 0
    
    var linkImg1: String = ""
    var linkImg2: String = ""
    var linkImg3: String = ""
    
    var cellCheckBox: CheckBoxTableViewCell!
    
    var helpModel = PushNotificationServiceParamsModel()
    var listGroup: [GroupRelationShipModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showProgressHub()
        self.configButtonBack()
        self.setupUI()
        self.setupTableView()
        self.getSearchGroup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Thông báo đẩy"//Settings.ShareInstance.translate(key: "support_report")
    }
    
    func setupUI(){
        imagePicker.delegate = self
    }
    
    func setupTableView(){
        self.tbvHelp.register(UINib(nibName: "ImageCarTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageCarTableViewCell")
        self.tbvHelp.register(UINib(nibName: "DescriptionCarTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionCarTableViewCell")

        self.tbvHelp.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        self.tbvHelp.register(UINib.init(nibName: "CheckBoxTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckBoxTableViewCell")
        self.tbvHelp.register(UINib.init(nibName: "CompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteTableViewCell")
        self.tbvHelp.register(UINib.init(nibName: "HeaderMyServices", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderMyServices")
        self.tbvHelp.delegate = self
        self.tbvHelp.dataSource = self
        self.tbvHelp.allowsSelection = false
        self.tbvHelp.separatorColor = UIColor.clear
        self.tbvHelp.separatorInset = UIEdgeInsets.zero
        
        self.tbvHelp.rowHeight = UITableView.automaticDimension
        self.tbvHelp.estimatedRowHeight = 300
    }
    
    @objc func chooseAvatar(){
        let alertControl = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let actionChoicePhoto = UIAlertAction.init(title: "Thư viện ảnh", style: .default) { (action) in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let actionChoiseCamera = UIAlertAction.init(title: "Chụp hình", style: .default) { (action) in
            self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.imagePicker.allowsEditing = true
            self.imagePicker.cameraDevice = .rear
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction.init(title: "Hủy", style: .cancel) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        alertControl.addAction(actionChoicePhoto)
        alertControl.addAction(actionChoiseCamera)
        alertControl.addAction(actionCancel)
        //        if let popoverController = alertControl.popoverPresentationController {
        //            popoverController.sourceView = self.icAvatar
        //            popoverController.sourceRect = self.icAvatar.bounds
        //        }
        self.present(alertControl, animated: true, completion: nil)
    }
    
    func getSearchGroup(){
        RelationShipsManager.shareRelationShipsManager().getSearchGroupRelationShip { [unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                print("data = \(data)")
                for item in data {
                    self.listGroup.append(item)
                }
                self.tbvHelp.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func addNewService(){
        let group = DispatchGroup()
        if cellImage.imageOne.image != nil {
            group.enter()
            AWSS3Manager.shared.uploadImage(image: cellImage.imageOne.image!, progress: nil) { [unowned self] (fileURL, error) in
                if error == nil {
                    self.linkImg1 = fileURL as! String
                }else{
                    Settings.ShareInstance.showAlertView(message: error?.localizedDescription ?? "", vc: self)
                    group.leave()
                    return
                }
                group.leave()
            }
        }
        
        if cellImage.imageTwo.image != nil {
            group.enter()
            AWSS3Manager.shared.uploadImage(image: cellImage.imageTwo.image!, progress: nil) { [unowned self] (fileURL, error) in
                if error == nil {
                    self.linkImg2 = fileURL as! String
                }else{
                    Settings.ShareInstance.showAlertView(message: error?.localizedDescription ?? "", vc: self)
                    group.leave()
                    return
                }
                group.leave()
            }
        }
        if cellImage.imageThree.image != nil {
            group.enter()
            AWSS3Manager.shared.uploadImage(image: cellImage.imageThree.image!, progress: nil) { [unowned self] (fileURL, error) in
                if error == nil {
                    self.linkImg3 = fileURL as! String
                }else{
                    Settings.ShareInstance.showAlertView(message: error?.localizedDescription ?? "", vc: self)
                    group.leave()
                    return
                }
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.global(qos: .background)) {
            var linkImgs = ""
            if self.linkImg1.count > 0 && self.linkImg2.count > 0 && self.linkImg3.count > 0 {
                linkImgs = "\(self.linkImg1),\(self.linkImg2),\(self.linkImg3)"
            }else if self.linkImg1.count > 0 && self.linkImg2.count > 0 {
                linkImgs = "\(self.linkImg1),\(self.linkImg2)"
            }else if self.linkImg1.count > 0 {
                linkImgs = "\(self.linkImg1)"
            }
            
            if self.helpModel.title.count == 0 ||
                self.helpModel.description.count == 0 ||
                linkImgs.count == 0 {
                DispatchQueue.main.async {
                    Settings.ShareInstance.showAlertView(message: "Vui lòng điền đầy đủ thông tin.", vc: self)
                }
            }else {
                let totalRow = self.listGroup.count + 2
                DispatchQueue.main.sync {
                    for index in 0..<totalRow {
                        self.cellCheckBox = self.tbvHelp.cellForRow(at: IndexPath.init(item: index, section: 1)) as? CheckBoxTableViewCell
                        if self.cellCheckBox?.img1.image?.jpegData(compressionQuality: 0.5) != UIImage.init(named: "ic_uncheck")?.jpegData(compressionQuality: 0.5) {
                            if index == 0 {
                                self.helpModel.target.append("relationship")
                            }else if index == 1 {
                                self.helpModel.target.append("open_relationship")
                            }else {
                                let model = self.listGroup[index - 2]
                                let arrIds = model.userIds?.split(separator: ",")
                                if let arr = arrIds, arr.count > 0 {
                                    for i in arr {
                                        self.helpModel.relationship.append(Int(String(i)) ?? 0)
                                    }
                                }
                            }
                        }
                    }
                }
//                cellCheckBox = self.tbvHelp.cellForRow(at: IndexPath.init(item: index, section: 1)) as? CheckBoxTableViewCell
                var model = AddNewPushNotificationServiceParams()
                model.title = self.helpModel.title
                model.description = self.helpModel.description
                model.target = self.helpModel.target
                model.relationship = self.helpModel.relationship
                model.images = linkImgs
                self.createNewService(model: model)
            }
        }
        
    }
    
    func createNewService(model: AddNewPushNotificationServiceParams){
        RelationShipsManager.shareRelationShipsManager().createPushNotification(model: model) { [unowned self] (response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: "Lưu thành công", vc: self) {[unowned self] (str) in
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

extension PushNotificationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return listTypeCell.count
        }else if section == 1 {
            return listGroup.count + 2
        }else{
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 || section == 2 {
            return UIView()
        }
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderMyServices") as! HeaderMyServices
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = listTypeCell[indexPath.row]
        
        if indexPath.section == 0 {
            switch type {
                
            case .Image:
                cellImage = tableView.dequeueReusableCell(withIdentifier: "ImageCarTableViewCell") as? ImageCarTableViewCell
                cellImage.delegate = self
                return cellImage
            case .Title:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
                cell.lbTitle.text = "Tiêu đề"
                cell.tfInput.placeholder = "Tiêu đề"
                cell.tfInput.tag = indexPath.row
                cell.delegate = self
                return cell
            case .Description:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCarTableViewCell") as! DescriptionCarTableViewCell
                cell.lbTitle.text = "Mô tả"
                cell.delegate = self
                return cell
            }
        }else if indexPath.section == 1 {
            cellCheckBox = tableView.dequeueReusableCell(withIdentifier: "CheckBoxTableViewCell") as? CheckBoxTableViewCell
            if indexPath.row == 0 {
                cellCheckBox.lbTitle1.text = "Mối quan hệ"
                cellCheckBox.img1.image = UIImage.init(named: "ic_checked")
            }else if indexPath.row == 1 {
                cellCheckBox.lbTitle1.text = "Mối quan hệ mở rộng"
            }else{
                if listGroup.count > 0  {
                    let model = listGroup[indexPath.row - 2]
                    cellCheckBox.lbTitle1.text = model.name
                }
            }
            cellCheckBox.delegate = self
            cellCheckBox.bt1.tag = indexPath.row
            cellCheckBox.img1.tag = indexPath.row
            return cellCheckBox
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
            cell.btComplete.setTitle("Xác nhận", for: .normal)
            cell.delegate = self
            return cell
        }
    }
}

extension PushNotificationViewController: ImageCarTableViewCellProtocol{
    func touchImg2() {
        index = 2
        self.chooseAvatar()
    }
    
    func touchImg3() {
        index = 3
        self.chooseAvatar()
    }
    
    func touchImg1() {
        index = 1
        self.chooseAvatar()
    }
}

extension PushNotificationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.imagePicker.dismiss(animated: true) {
            let img1 = info[.editedImage] as? UIImage
            let img = img1?.resizeWithWidth(width: 400)
            let imgData: Data? = img?.jpegData(compressionQuality: 0.5)//UIImageJPEGRepresentation(img!, 0.5)
            self.strImgBase64 = (imgData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)))!
            self.cellImage?.updateImg(str: self.strImgBase64, index: self.index, img: img ?? UIImage())
            self.tbvHelp.reloadData()
        }
        print("info = \(info)")
    }
}

extension PushNotificationViewController: TitleTableViewCellProtocol{
    func getTextPushNotification(_ str: String, type: typeCellPushNotification) {
        switch type {
            
        case .Image:
            break
            
        case .Title:
            self.helpModel.title = str
            break
        case .Description:
            break
        }
    }
}

extension PushNotificationViewController: DescriptionCarTableViewCellProtocol{
    func getDescriptionText(_ string: String) {
        self.helpModel.description = string
    }
}

extension PushNotificationViewController: CompleteTableViewCellProtocol{
    func didComplete() {
        self.showProgressHub()
        self.addNewService()
    }
}

extension PushNotificationViewController: CheckBoxTableViewCellProtocol {
    
    func didImg1(_ index: Int) {
        cellCheckBox = self.tbvHelp.cellForRow(at: IndexPath.init(item: index, section: 1)) as? CheckBoxTableViewCell
        switch index {
        case 0 :
//            if cellCheckBox.img1!.tag == index {
//                if cellCheckBox?.img1.image?.jpegData(compressionQuality: 0.5) != UIImage.init(named: "ic_uncheck")?.jpegData(compressionQuality: 0.5) {
//                    cellCheckBox.img1.image = UIImage.init(named: "ic_uncheck")
//                }else{
//                    cellCheckBox.img1.image = UIImage.init(named: "ic_checked")
//                }
//            }
            
            break
        case 1 :
           if cellCheckBox.img1!.tag == index {
                if cellCheckBox?.img1.image?.jpegData(compressionQuality: 0.5) != UIImage.init(named: "ic_uncheck")?.jpegData(compressionQuality: 0.5) {
                    cellCheckBox.img1.image = UIImage.init(named: "ic_uncheck")
                }else{
                    cellCheckBox.img1.image = UIImage.init(named: "ic_checked")
                }
            }
            break
        case 2 :
            if cellCheckBox.img1!.tag == index {
                if cellCheckBox?.img1.image?.jpegData(compressionQuality: 0.5) != UIImage.init(named: "ic_uncheck")?.jpegData(compressionQuality: 0.5) {
                    cellCheckBox.img1.image = UIImage.init(named: "ic_uncheck")
                }else{
                    cellCheckBox.img1.image = UIImage.init(named: "ic_checked")
                }
            }
            break
        default:
            break
        }
    }
    
    
}
