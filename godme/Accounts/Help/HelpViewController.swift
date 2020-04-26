//
//  HelpViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/30/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

@objc enum typeCellHelp: Int {
    case Image = 0
    case Title = 1
    case Description = 2
    case Confirm = 3
}

class HelpViewController: BaseViewController {

    @IBOutlet weak var tbvHelp: UITableView!
    var listTypeCell: [typeCellHelp] = [.Image, .Title, .Description, .Confirm]
    
    var cellImage: ImageCarTableViewCell!
    var strImgBase64: String = ""
    var imagePicker = UIImagePickerController()
    var index: Int = 0
    
    var linkImg1: String = ""
    var linkImg2: String = ""
    var linkImg3: String = ""
    
    var helpModel = HelpServiceParamsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configButtonBack()
        self.setupUI()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "support_report")
    }
    
    func setupUI(){
        imagePicker.delegate = self
    }
    
    func setupTableView(){
        self.tbvHelp.register(UINib(nibName: "ImageCarTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageCarTableViewCell")
        self.tbvHelp.register(UINib(nibName: "DescriptionCarTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionCarTableViewCell")

        self.tbvHelp.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        self.tbvHelp.register(UINib.init(nibName: "CompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteTableViewCell")
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
        let actionChoicePhoto = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_iamge_pick_gallery"), style: .default) { (action) in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let actionChoiseCamera = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_image_capture_new"), style: .default) { (action) in
            self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.imagePicker.allowsEditing = true
            self.imagePicker.cameraDevice = .rear
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_cancel"), style: .cancel) { (action) in
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
            
            if self.helpModel.title.count == 0 ||
                self.helpModel.description.count == 0 ||
                linkImgs.count == 0 {
                DispatchQueue.main.async {
                    Settings.ShareInstance.showAlertView(message: Settings.ShareInstance.translate(key: "label_please_fill_in_full"), vc: self)
                }
            }else {
                var model = AddNewHelpServiceParams()
                model.title = self.helpModel.title
                model.description = self.helpModel.description
                model.images = linkImgs
                self.createNewService(model: model)
            }
        }
        
    }
    
    func createNewService(model: AddNewHelpServiceParams){
        UserManager.shareUserManager().createSupport(model: model) { [unowned self] (response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message:Settings.ShareInstance.translate(key: "label_create_service_success"), vc: self) { (str) in
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

extension HelpViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = listTypeCell[indexPath.row]
        
        switch type {
            
        case .Image:
            cellImage = tableView.dequeueReusableCell(withIdentifier: "ImageCarTableViewCell") as? ImageCarTableViewCell
            cellImage.delegate = self
            cellImage.lbTitle.text = Settings.ShareInstance.translate(key: "label_image")
            return cellImage
        case .Title:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.text = Settings.ShareInstance.translate(key: "label_title")
            cell.tfInput.placeholder = Settings.ShareInstance.translate(key: "label_title")
            cell.tfInput.tag = indexPath.row
            cell.tfInput.text = self.helpModel.title
            cell.delegate = self
            return cell
        case .Description:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCarTableViewCell") as! DescriptionCarTableViewCell
            cell.lbTitle.text = Settings.ShareInstance.translate(key: "label_description")
            cell.textView.text = self.helpModel.description
            cell.delegate = self
            return cell
        case .Confirm:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
            cell.btComplete.setTitle(Settings.ShareInstance.translate(key: "confirm"), for: .normal)
            cell.delegate = self
            return cell
        }
    }
    
    
}

extension HelpViewController: ImageCarTableViewCellProtocol{
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

extension HelpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.imagePicker.dismiss(animated: true) {
            let img1 = info[.editedImage] as? UIImage
            let img = img1?.resizeWithWidth(width: 400)
            let imgData: Data? = img?.jpegData(compressionQuality: 0.5)//UIImageJPEGRepresentation(img!, 0.5)
            self.strImgBase64 = (imgData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)))!
            //            self.icAvatar.image = img
            //            self.icAvatar.clipsToBounds = true
            self.cellImage?.updateImg(str: self.strImgBase64, index: self.index, img: img ?? UIImage())
            self.tbvHelp.reloadData()
        }
        print("info = \(info)")
    }
}

extension HelpViewController: TitleTableViewCellProtocol{
    func getTextHelp(_ str: String, type: typeCellHelp) {
        switch type {
            
        case .Image:
            break
            
        case .Title:
            self.helpModel.title = str
            break
        case .Description:
            break
        case .Confirm:
            break
        }
    }
}

extension HelpViewController: DescriptionCarTableViewCellProtocol{
    func getDescriptionText(_ string: String) {
        self.helpModel.description = string
    }
}

extension HelpViewController: CompleteTableViewCellProtocol{
    func didComplete() {
        self.showProgressHub()
        self.addNewService()
    }
}
