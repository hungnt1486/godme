//
//  CreateAuctionViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/15/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

@objc enum typeCellCreateCollaborate: Int {
    case Image = 0
    case Title = 1
    case FullName = 2
    case Email = 3
    case PhoneNumber = 4
    case Description = 5
    case CollaborateExpect = 6
    case CreateCollaborate = 7
}

class CreateCollaborateViewController: BaseViewController {

    @IBOutlet weak var  tbvCreateCollaborate: UITableView!
    
    var cellImage: ImageCarTableViewCell!
    var strImgBase64: String = ""
    var imagePicker = UIImagePickerController()
    var index: Int = 0
    
    var collaborationModel = CollaborationServiceParamsModel()
    var linkImg1: String = ""
    var linkImg2: String = ""
    var linkImg3: String = ""
    
    var listTypeCell: [typeCellCreateCollaborate] = [.Image, .Title, .FullName, .Email, .PhoneNumber, .Description, .CollaborateExpect, .CreateCollaborate]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupUI()
        self.setupTableView()
        self.configButtonBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "collaboration")
    }
    
    func setupUI(){
        imagePicker.delegate = self
    }
    
    func setupTableView(){
        self.tbvCreateCollaborate.register(UINib(nibName: "ImageCarTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageCarTableViewCell")
        self.tbvCreateCollaborate.register(UINib(nibName: "DescriptionCarTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionCarTableViewCell")

        self.tbvCreateCollaborate.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        self.tbvCreateCollaborate.register(UINib.init(nibName: "CompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteTableViewCell")
        self.tbvCreateCollaborate.delegate = self
        self.tbvCreateCollaborate.dataSource = self
        self.tbvCreateCollaborate.allowsSelection = false
        self.tbvCreateCollaborate.separatorColor = UIColor.clear
        self.tbvCreateCollaborate.separatorInset = UIEdgeInsets.zero
        
        self.tbvCreateCollaborate.rowHeight = UITableView.automaticDimension
        self.tbvCreateCollaborate.estimatedRowHeight = 300
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
            
            if self.collaborationModel.title.count == 0 ||
                self.collaborationModel.description.count == 0 ||
                self.collaborationModel.content.count == 0 ||
                self.collaborationModel.fullName.count == 0 ||
                self.collaborationModel.email.count == 0 ||
                self.collaborationModel.phoneNumber.count == 0 ||
                linkImgs.count == 0 {
                DispatchQueue.main.async {
                    self.hideProgressHub()
                    Settings.ShareInstance.showAlertView(message: "Vui lòng điền đầy đủ thông tin.", vc: self)
                }
            }else {
                var model = AddNewCollaborationParams()
                model.title = self.collaborationModel.title
                model.description = self.collaborationModel.description
                model.content = self.collaborationModel.content
                model.fullName = self.collaborationModel.fullName
                model.email = self.collaborationModel.email
                model.phoneNumber = self.collaborationModel.phoneNumber
                model.images = linkImgs
                self.createNewService(model: model)
            }
        }
        
    }
    
    func createNewService(model: AddNewCollaborationParams){
        ManageServicesManager.shareManageServicesManager().createCollaborationService(model: model) { [unowned self](response) in
            switch response {

            case .success( _):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: "Chúc mừng bạn đã tạo dịch vụ thành công.", vc: self) { (str) in
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

extension CreateCollaborateViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let typeCell = listTypeCell[indexPath.row]
        switch typeCell {
        case .Image:
            cellImage = tableView.dequeueReusableCell(withIdentifier: "ImageCarTableViewCell") as? ImageCarTableViewCell
            cellImage.delegate = self
            return cellImage
        case .Title:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.text = "Tiêu đề"
            cell.tfInput.placeholder = "Tiêu đề của hợp tác"
            cell.tfInput.tag = indexPath.row
            cell.delegate = self
            return cell
        case .FullName:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.text = "Họ và tên"
            cell.tfInput.placeholder = "Nhập họ và tên"
            cell.tfInput.tag = indexPath.row
            cell.delegate = self
            return cell
        case .Email:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.text = "Email"
            cell.tfInput.placeholder = "Nhập email"
            cell.tfInput.tag = indexPath.row
            cell.delegate = self
            return cell
        case .PhoneNumber:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.text = "Số điện thoại"
            cell.tfInput.placeholder = "Nhập số điện thoại"
            cell.tfInput.tag = indexPath.row
            cell.delegate = self
            return cell
        case .Description:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCarTableViewCell") as! DescriptionCarTableViewCell
            cell.lbTitle.text = "Mô tả"
            cell.delegate = self
            return cell
        case .CollaborateExpect:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.text = "Mong muốn hợp tác"
            cell.tfInput.placeholder = "Nhập mong muốn hợp tác"
            cell.tfInput.tag = indexPath.row
            cell.delegate = self
            return cell
        case .CreateCollaborate:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
            cell.btComplete.setTitle("Gửi thông tin", for: .normal)
            cell.delegate = self
            return cell
        }
    }
    
    
}

extension CreateCollaborateViewController: ImageCarTableViewCellProtocol{
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

extension CreateCollaborateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.imagePicker.dismiss(animated: true) {
            let img1 = info[.editedImage] as? UIImage
            let img = img1?.resizeWithWidth(width: 400)
            let imgData: Data? = img?.jpegData(compressionQuality: 0.5)//UIImageJPEGRepresentation(img!, 0.5)
            self.strImgBase64 = (imgData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)))!
            //            self.icAvatar.image = img
            //            self.icAvatar.clipsToBounds = true
            self.cellImage?.updateImg(str: self.strImgBase64, index: self.index, img: img ?? UIImage())
            self.tbvCreateCollaborate.reloadData()
        }
        print("info = \(info)")
    }
}

extension CreateCollaborateViewController: TitleTableViewCellProtocol{
    func getTextCollaborationService(_ str: String, type: typeCellCreateCollaborate) {
        switch type {
            
        case .Image:
            break
        case .Title:
            self.collaborationModel.title = str
            break
        case .FullName:
            self.collaborationModel.fullName = str
            break
        case .Email:
            self.collaborationModel.email = str
            break
        case .PhoneNumber:
            self.collaborationModel.phoneNumber = str
            break
        case .Description:
            break
        case .CollaborateExpect:
            self.collaborationModel.content = str
            break
        case .CreateCollaborate:
            break
        }
    }
}

extension CreateCollaborateViewController: DescriptionCarTableViewCellProtocol{
    func getDescriptionText(_ string: String) {
        self.collaborationModel.description = string
    }
}

extension CreateCollaborateViewController: CompleteTableViewCellProtocol{
    func didComplete() {
        self.showProgressHub()
        self.addNewService()
    }
}
