//
//  CreateServiceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/15/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

@objc enum typeCellCreateService: Int{
    case Image  = 0
    case Title = 1
}

@objc enum typeCellCreateService1: Int {
    case Position = 0
    case Description = 1
    case Language = 2
    case Fee = 3
    case CreateService = 4
}

class CreateServiceViewController: BaseViewController {

    @IBOutlet weak var tbvCreateService: UITableView!
    
    var cellImage: ImageCarTableViewCell!
    var strImgBase64: String = ""
    var imagePicker = UIImagePickerController()
    var index: Int = 0
    var cellAddres: AddressPostCarTableViewCell!
    var vDatePicker: ViewDatePicker1!
    var cellDate: TimeTableViewCell!
    var basicModel = BasicServiceModel()
    var linkImg1: String = ""
    var linkImg2: String = ""
    var linkImg3: String = ""
    
    var arrayGender: [[String: String]] = []
    var arrTemp: [GenderModel] = []
    var indexLanguage = -1
    
    var indexRow = 1
    
    var listTypeCell: [typeCellCreateService] = [.Image, .Title]
    var listTypeCell1: [typeCellCreateService1] = [.Position, .Description, .Language, .Fee, .CreateService]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupTableView()
        self.configButtonBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "create_services")
    }
    
    func setupUI(){
        imagePicker.delegate = self
        self.arrTemp = Settings.ShareInstance.Languages()
        if  self.arrTemp.count > 0 {
            for item in self.arrTemp {
                self.arrayGender.append(["name":Settings.ShareInstance.translate(key: item.Name ?? ""), "code": "\(item.Id ?? "")"])
            }
        }
    }
    
    func setupTableView(){
        self.tbvCreateService.register(UINib(nibName: "ImageCarTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageCarTableViewCell")
        self.tbvCreateService.register(UINib(nibName: "DescriptionCarTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionCarTableViewCell")
        self.tbvCreateService.register(UINib(nibName: "AddressPostCarTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressPostCarTableViewCell")

        self.tbvCreateService.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        self.tbvCreateService.register(UINib.init(nibName: "Title1TableViewCell", bundle: nil), forCellReuseIdentifier: "Title1TableViewCell")
        self.tbvCreateService.register(UINib.init(nibName: "TimeTableViewCell", bundle: nil), forCellReuseIdentifier: "TimeTableViewCell")
        self.tbvCreateService.register(UINib.init(nibName: "CompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteTableViewCell")
        self.tbvCreateService.register(UINib.init(nibName: "TypeCarTableViewCell", bundle: nil), forCellReuseIdentifier: "TypeCarTableViewCell")
        self.tbvCreateService.register(UINib.init(nibName: "HeaderSubMain", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderSubMain")
        self.tbvCreateService.delegate = self
        self.tbvCreateService.dataSource = self
        self.tbvCreateService.allowsSelection = false
        self.tbvCreateService.separatorColor = UIColor.clear
        self.tbvCreateService.separatorInset = UIEdgeInsets.zero
        
        self.tbvCreateService.rowHeight = UITableView.automaticDimension
        self.tbvCreateService.estimatedRowHeight = 300
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
            if self.basicModel.dateTime1 == 0.0 ||
                self.basicModel.amount.count == 0 ||
                self.basicModel.address.count == 0 ||
                self.basicModel.description.count == 0 ||
                self.basicModel.language.count == 0 ||
                self.basicModel.title.count == 0 ||
                linkImgs.count == 0 {
                DispatchQueue.main.async {
                    self.hideProgressHub()
                    Settings.ShareInstance.showAlertView(message: Settings.ShareInstance.translate(key: "label_please_fill_in_full"), vc: self)
                }
            }else {
                let modelLanguage = self.arrayGender[self.indexLanguage]
                var model = AddNewBaseServiceParams()
                model.dateTime1 = self.basicModel.dateTime1
                model.dateTime2 = self.basicModel.dateTime2
                model.dateTime3 = self.basicModel.dateTime3
                model.dateTime4 = self.basicModel.dateTime4
                model.dateTime5 = self.basicModel.dateTime5
                model.dateTime6 = self.basicModel.dateTime6
                model.dateTime7 = self.basicModel.dateTime7
                model.amount = self.basicModel.amount
                model.address = self.basicModel.address
                model.latitude = self.basicModel.latitude
                model.longitude = self.basicModel.longitude
                model.description = self.basicModel.description
                model.language = modelLanguage["code"]//self.basicModel.language
                model.images = linkImgs
                model.title = self.basicModel.title
                self.createNewService(model: model)
            }
        }
        
    }
    
    func createNewService(model: AddNewBaseServiceParams){
        ManageServicesManager.shareManageServicesManager().createBaseService(model: model) { [unowned self](response) in
            switch response {
                
            case .success( _):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: Settings.ShareInstance.translate(key: "label_create_service_success"), vc: self) { (str) in
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

extension CreateServiceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return listTypeCell.count
        }else if section == 2 {
            return listTypeCell1.count
        }
        return indexRow
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderSubMain") as! HeaderSubMain
        header.backgroundColor = UIColor.FlatColor.Gray.BGColor
        header.delegate = self
        header.btMore.tag = section
        if section == 1 {
            header.lbTitle.text = Settings.ShareInstance.translate(key: "label_time")
            header.btMore.setTitle(Settings.ShareInstance.translate(key: "label_add_time"), for: .normal)
            return header
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let typeCell = listTypeCell[indexPath.row]
            switch typeCell {
                
            case .Image:
                cellImage = tableView.dequeueReusableCell(withIdentifier: "ImageCarTableViewCell") as? ImageCarTableViewCell
                cellImage.lbTitle.text = Settings.ShareInstance.translate(key: "label_image")
                cellImage.delegate = self
                return cellImage
            case .Title:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
                cell.lbTitle.text = Settings.ShareInstance.translate(key: "label_title")
                cell.tfInput.placeholder = Settings.ShareInstance.translate(key: "label_title_of_service")
                cell.tfInput.tag = indexPath.row
                cell.tfInput.text = self.basicModel.title
                cell.delegate = self
                return cell
            }
        }else if indexPath.section == 2 {
            let typeCell = listTypeCell1[indexPath.row]
            switch typeCell {
                
            case .Position:
                cellAddres = tableView.dequeueReusableCell(withIdentifier: "AddressPostCarTableViewCell") as? AddressPostCarTableViewCell
                cellAddres.lbTitle.text = Settings.ShareInstance.translate(key: "label_position")
                if self.basicModel.address.count > 0 {
                    cellAddres.lbTypeCar.text = self.basicModel.address
                }else {
                    cellAddres.lbTypeCar.text = Settings.ShareInstance.translate(key: "label_address")
                }
                cellAddres.delegate = self
                return cellAddres
            case .Description:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCarTableViewCell") as! DescriptionCarTableViewCell
                cell.lbTitle.text = Settings.ShareInstance.translate(key: "label_description")
                cell.textView.text = self.basicModel.description
                cell.delegate = self
                return cell
            case .Language:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCarTableViewCell") as! TypeCarTableViewCell
                cell.lbTitle.text = Settings.ShareInstance.translate(key: "label_language")
                cell.lbTitle.textColor = UIColor.FlatColor.Gray.TextColor
                cell.lbTypeCar.tag = indexPath.row
                cell.lbTypeCar.text = self.basicModel.language
                cell.delegate = self
                if cell.arr.count == 0 {
                    cell.arr = self.arrayGender
                    cell.setupTypeDropdown()
                }
                return cell
            case .Fee:
                let cell = tableView.dequeueReusableCell(withIdentifier: "Title1TableViewCell") as! Title1TableViewCell
                cell.tfInput.tag = indexPath.row
                cell.delegate = self
                cell.lbTitle.text = Settings.ShareInstance.translate(key: "label_fee")
                cell.tfInput.placeholder = Settings.ShareInstance.translate(key: "label_input_fee_join")
                cell.tfInput.keyboardType = .numberPad
                cell.tfInput.text = self.basicModel.amount
                return cell
            case .CreateService:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
                cell.btComplete.setTitle(Settings.ShareInstance.translate(key: "label_create_service"), for: .normal)
                cell.delegate = self
                return cell
            }
        }else{
            cellDate = tableView.dequeueReusableCell(withIdentifier: "TimeTableViewCell") as? TimeTableViewCell
            cellDate.lbTime.tag = indexPath.row
            cellDate.delegate = self
            switch indexPath.row {
            case 0:
                cellDate.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: self.basicModel.dateTime1)
                break
            case 1:
                cellDate.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: self.basicModel.dateTime2)
                break
            case 2:
                cellDate.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: self.basicModel.dateTime3)
                break
            case 3:
                cellDate.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: self.basicModel.dateTime4)
                break
            case 4:
                cellDate.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: self.basicModel.dateTime5)
                break
            case 5:
                cellDate.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: self.basicModel.dateTime6)
                break
            case 6:
                cellDate.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: self.basicModel.dateTime7)
                break
            default:
                break
            }
            return cellDate
        }
    }
    
    
}

extension CreateServiceViewController: HeaderSubMainProtocol{
    func didMore(index: Int) {
        if indexRow < 7  {
            indexRow = indexRow + 1
            self.tbvCreateService.reloadSections(IndexSet.init(integer: 1), with: .none)
        }
        
    }
}

extension CreateServiceViewController: ImageCarTableViewCellProtocol{
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

extension CreateServiceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.imagePicker.dismiss(animated: true) {
            let img1 = info[.editedImage] as? UIImage
            let img = img1?.resizeWithWidth(width: 400)
            let imgData: Data? = img?.jpegData(compressionQuality: 0.5)//UIImageJPEGRepresentation(img!, 0.5)
            self.strImgBase64 = (imgData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)))!
            //            self.icAvatar.image = img
            //            self.icAvatar.clipsToBounds = true
            self.cellImage?.updateImg(str: self.strImgBase64, index: self.index, img: img ?? UIImage())
            self.tbvCreateService.reloadData()
        }
        print("info = \(info)")
    }
}

extension CreateServiceViewController: AddressPostCarTableViewCellProtocol{
    func getAddress() {
        let map = MapPickerViewController()
        map.onDismissCallback = {[weak self](location) in
            self?.cellAddres.updateAddress(to: location)
            self?.basicModel.latitude = location?.coordinate.latitude ?? 0.0
            self?.basicModel.longitude = location?.coordinate.longitude ?? 0.0
        }
        self.navigationController?.pushViewController(map, animated: true)
    }
    
    func getText(_ str: String) {
        print("address = ", str)
        self.cellAddres.lbTypeCar.text = str
        basicModel.address = str
    }
}

extension CreateServiceViewController: ViewDatePicker1Protocol {
    func tapDone(_ index: Int) {
        print("tap done = \(index)")
        let df = DateFormatter.init()
        df.locale = Locale.init(identifier: Settings.ShareInstance.getCurrentLanguage())
        df.dateFormat = "HH:mm, EEEE, dd/MM/yyyy"
        cellDate = self.tbvCreateService.cellForRow(at: IndexPath.init(row: index, section: 1)) as? TimeTableViewCell
        cellDate.lbTime.text = df.string(from: vDatePicker.datePicker.date)
        switch index {
        case 0:
            self.basicModel.dateTime1 = Settings.ShareInstance.convertDateToTimeInterval(date: vDatePicker.datePicker.date)
            break
        case 1:
            self.basicModel.dateTime2 = Settings.ShareInstance.convertDateToTimeInterval(date: vDatePicker.datePicker.date)
            break
        case 2:
            self.basicModel.dateTime3 = Settings.ShareInstance.convertDateToTimeInterval(date: vDatePicker.datePicker.date)
            break
        case 3:
            self.basicModel.dateTime4 = Settings.ShareInstance.convertDateToTimeInterval(date: vDatePicker.datePicker.date)
            break
        case 4:
            self.basicModel.dateTime5 = Settings.ShareInstance.convertDateToTimeInterval(date: vDatePicker.datePicker.date)
            break
        case 5:
            self.basicModel.dateTime6 = Settings.ShareInstance.convertDateToTimeInterval(date: vDatePicker.datePicker.date)
            break
        case 6:
            self.basicModel.dateTime7 = Settings.ShareInstance.convertDateToTimeInterval(date: vDatePicker.datePicker.date)
            break
        default:
            break
        }
        vDatePicker.viewWithTag(11)?.removeFromSuperview()
        vDatePicker = nil
    }
    
    func tapCancel() {
        print("tap cancel")
        vDatePicker.viewWithTag(11)?.removeFromSuperview()
        vDatePicker = nil
    }
    
    func tapGesture() {
        vDatePicker.viewWithTag(11)?.removeFromSuperview()
        vDatePicker = nil
    }
}

extension CreateServiceViewController: CompleteTableViewCellProtocol{
    func didComplete() {
        self.showProgressHub()
        self.addNewService()
    }
}

extension CreateServiceViewController: TitleTableViewCellProtocol{
    func getTextBaseService(_ str: String, type: typeCellCreateService) {
        if type == .Title {
            basicModel.title = str
        }
    }
    
}

extension CreateServiceViewController: Title1TableViewCellProtocol{
    func getTextBaseService1(_ str: String, type: typeCellCreateService1) {
        if type == .Fee {
            basicModel.amount = str
        }
//        if type == .Language {
//            basicModel.language = str
//        }
    }
}

extension CreateServiceViewController: DescriptionCarTableViewCellProtocol{
    func getDescriptionText(_ string: String) {
        self.basicModel.description = string
    }
}

extension CreateServiceViewController: TimeTableViewCellProtocol{
    func didLabel(_ index: Int) {
        self.view.endEditing(true)
        if vDatePicker == nil {
            vDatePicker = ViewDatePicker1.instanceFromNib()
            vDatePicker.indexPosition = index
            vDatePicker.tag = 11
            self.view.addSubview(vDatePicker)
            vDatePicker.delegate = self
        }
    }
}

extension CreateServiceViewController: TypeCarTableViewCellProtocol{
    func eventGetTextEditProfile(_ string: String, type: typeCellEditProfile, index: Int) {
        
    }
    
    func eventGetTextTypeCreateService(_ string: String, type: typeCellCreateService1, index: Int) {
        switch type {
            
        case .Position:
            break
        case .Description:
            break
        case .Language:
            self.basicModel.language = string
            self.indexLanguage = index
            break
        case .Fee:
            break
        case .CreateService:
            break
        }
    }
    
}
