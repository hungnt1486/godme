//
//  CreateAuctionViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/15/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

@objc enum typeCellCreateEvent: Int {
    case Image = 0
    case Title = 1
    case Time = 2
    case Position = 3
    case MaxOrder = 4
    case Description = 5
    case Language = 6
    case Fee = 7
    case CreateEvent = 8
}

class CreateEventViewController: BaseViewController {

    @IBOutlet weak var tbvCreateEvent: UITableView!
    
    var cellImage: ImageCarTableViewCell!
    var strImgBase64: String = ""
    var imagePicker = UIImagePickerController()
    var index: Int = 0
    var cellAddres: AddressPostCarTableViewCell!
    var vDatePicker: ViewDatePicker!
    var cellDate: StartEndTimeTableViewCell!
    
    var eventModel = EventServiceParamsModel()
    var linkImg1: String = ""
    var linkImg2: String = ""
    var linkImg3: String = ""
    
    var listTypeCell: [typeCellCreateEvent] = [.Image, .Title, .Time, .Position, .MaxOrder, .Description, .Language, .Fee, .CreateEvent]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupUI()
        self.setupTableView()
        self.configButtonBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "create_event")
    }
    
    func setupUI(){
        imagePicker.delegate = self
    }
    
    func setupTableView(){
        self.tbvCreateEvent.register(UINib(nibName: "ImageCarTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageCarTableViewCell")
        self.tbvCreateEvent.register(UINib(nibName: "DescriptionCarTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionCarTableViewCell")
        self.tbvCreateEvent.register(UINib(nibName: "AddressPostCarTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressPostCarTableViewCell")

        self.tbvCreateEvent.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        self.tbvCreateEvent.register(UINib.init(nibName: "StartEndTimeTableViewCell", bundle: nil), forCellReuseIdentifier: "StartEndTimeTableViewCell")
        self.tbvCreateEvent.register(UINib.init(nibName: "CompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteTableViewCell")
        self.tbvCreateEvent.delegate = self
        self.tbvCreateEvent.dataSource = self
        self.tbvCreateEvent.allowsSelection = false
        self.tbvCreateEvent.separatorColor = UIColor.clear
        self.tbvCreateEvent.separatorInset = UIEdgeInsets.zero
        
        self.tbvCreateEvent.rowHeight = UITableView.automaticDimension
        self.tbvCreateEvent.estimatedRowHeight = 300
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
        
        group.notify(queue: DispatchQueue.main) {
            var linkImgs = ""
            if self.linkImg1.count > 0 && self.linkImg2.count > 0 && self.linkImg3.count > 0 {
                linkImgs = "\(self.linkImg1),\(self.linkImg2),\(self.linkImg3)"
            }else if self.linkImg1.count > 0 && self.linkImg2.count > 0 {
                linkImgs = "\(self.linkImg1),\(self.linkImg2)"
            }else {
                linkImgs = "\(self.linkImg1)"
            }
            if self.eventModel.startTime == 0.0 ||
                self.eventModel.endTime == 0.0 ||
                self.eventModel.amount.count == 0 ||
                self.eventModel.address.count == 0 ||
                self.eventModel.description.count == 0 ||
                self.eventModel.language.count == 0 ||
                self.eventModel.title.count == 0 ||
                self.eventModel.maxOrder.count == 0 {
                DispatchQueue.main.sync {
                    print(linkImgs)
                    self.hideProgressHub()
                    Settings.ShareInstance.showAlertView(message: "Vui lòng điền đầy đủ thông tin.", vc: self)
                }
            }else{
                var model = AddNewAuctionServiceParams()
                model.startTime = self.eventModel.startTime
                model.endTime = self.eventModel.endTime
                model.amount = self.eventModel.amount
                model.address = self.eventModel.address
                model.latitude = self.eventModel.latitude
                model.longitude = self.eventModel.longitude
                model.description = self.eventModel.description
                model.language = self.eventModel.language
                model.images = linkImgs
                model.title = self.eventModel.title
                model.maxOrder = self.eventModel.maxOrder
                self.createNewService(model: model)
            }
        }
        
    }
    
    func createNewService(model: AddNewAuctionServiceParams){
        ManageServicesManager.shareManageServicesManager().createEventService(model: model) { [unowned self](response) in
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

extension CreateEventViewController: UITableViewDelegate, UITableViewDataSource{
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
            cell.tfInput.placeholder = "Tiêu đề của dịch vụ"
            cell.tfInput.tag = indexPath.row
            cell.tfInput.text = self.eventModel.title
            cell.delegate = self
            return cell
        case .Time:
            cellDate = tableView.dequeueReusableCell(withIdentifier: "StartEndTimeTableViewCell") as? StartEndTimeTableViewCell
            cellDate.delegate = self
            cellDate.lbTitle.text = "Thời gian"
            cellDate.lbStartTime.tag = 1
            if self.eventModel.startTime > 0.0  {
                cellDate.lbStartTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: self.eventModel.startTime)
            }else {
                cellDate.lbStartTime.text = "Chọn thời gian bắt đầu"
            }
            cellDate.lbEndTime.tag = 2
            if self.eventModel.endTime > 0.0  {
                cellDate.lbEndTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: self.eventModel.endTime)
            }else {
                cellDate.lbEndTime.text = "Chọn thời gian kết thúc"
            }
            return cellDate
            
        case .Position:
            cellAddres = tableView.dequeueReusableCell(withIdentifier: "AddressPostCarTableViewCell") as? AddressPostCarTableViewCell
            cellAddres.lbTitle.text = "Vị trí"
            if self.eventModel.address.count > 0 {
                cellAddres.lbTypeCar.text = self.eventModel.address
            }else {
                cellAddres.lbTypeCar.text = "Chọn địa điểm"
            }
            cellAddres.delegate = self
            return cellAddres
        case .MaxOrder:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.text = "Số người tối đa"
            cell.tfInput.placeholder = "Nhập số người tối đa"
            cell.tfInput.text = self.eventModel.maxOrder
            cell.tfInput.tag = indexPath.row
            cell.delegate = self
            return cell
        case .Description:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCarTableViewCell") as! DescriptionCarTableViewCell
            cell.lbTitle.text = "Mô tả"
            cell.textView.text = self.eventModel.description
            cell.delegate = self
            return cell
        case .Language:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.text = "Ngôn ngữ"
            cell.tfInput.placeholder = "Chọn ngôn ngữ sử dụng"
            cell.tfInput.tag = indexPath.row
            cell.tfInput.text = self.eventModel.language
            cell.delegate = self
            return cell
        case .Fee:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.text = "Phí tham dự"
            cell.tfInput.placeholder = "Nhập phí tham dự"
            cell.tfInput.tag = indexPath.row
            cell.tfInput.text = self.eventModel.amount
            cell.tfInput.keyboardType = .numberPad
            cell.delegate = self
            return cell
        case .CreateEvent:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
            cell.delegate = self
            cell.btComplete.setTitle("Tạo dịch vụ", for: .normal)
            return cell
        
        }
    }
    
    
}

extension CreateEventViewController: HeaderSubMainProtocol{
    func didMore(index: Int) {
        self.view.endEditing(true)
        if vDatePicker == nil {
            vDatePicker = ViewDatePicker.instanceFromNib()
            vDatePicker.tag = 11
            self.view.addSubview(vDatePicker)
            vDatePicker.delegate = self
        }
    }
    
    
}

extension CreateEventViewController: ImageCarTableViewCellProtocol{
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

extension CreateEventViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.imagePicker.dismiss(animated: true) {
            let img1 = info[.editedImage] as? UIImage
            let img = img1?.resizeWithWidth(width: 400)
            let imgData: Data? = img?.jpegData(compressionQuality: 0.5)//UIImageJPEGRepresentation(img!, 0.5)
            self.strImgBase64 = (imgData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)))!
            //            self.icAvatar.image = img
            //            self.icAvatar.clipsToBounds = true
            self.cellImage?.updateImg(str: self.strImgBase64, index: self.index, img: img ?? UIImage())
            self.tbvCreateEvent.reloadData()
        }
        print("info = \(info)")
    }
}

extension CreateEventViewController: AddressPostCarTableViewCellProtocol{
    func getAddress() {
        let map = MapPickerViewController()
        map.onDismissCallback = {[weak self](location) in
            self?.cellAddres.updateAddress(to: location)
            self?.eventModel.latitude = location?.coordinate.latitude ?? 0.0
            self?.eventModel.longitude = location?.coordinate.longitude ?? 0.0
        }
        self.navigationController?.pushViewController(map, animated: true)
    }
    
    func getText(_ str: String) {
        print("address = ", str)
        self.eventModel.address = str
//        postModel.workPlace = str
    }
}

extension CreateEventViewController: ViewDatePickerProtocol {
    func tapDone() {
        print("tap done")
        let df = DateFormatter.init()
        df.dateFormat = "HH:mm, EEEE, dd/MM/yyyy"
        if cellDate.indexLabel == 1 {
            cellDate.updateDate(str: df.string(from: vDatePicker.datePicker.date), index: cellDate.indexLabel)
            self.eventModel.startTime = Settings.ShareInstance.convertDateToTimeInterval(date: vDatePicker.datePicker.date)
        }else{
            cellDate.updateDate(str: df.string(from: vDatePicker.datePicker.date), index: cellDate.indexLabel)
            self.eventModel.endTime = Settings.ShareInstance.convertDateToTimeInterval(date: vDatePicker.datePicker.date)
        }
        
        vDatePicker.viewWithTag(11)?.removeFromSuperview()
        vDatePicker = nil
//        postModel.dateExpire = df.string(from: vDatePicker.datePicker.date)
//        vDatePicker.viewWithTag(11)?.removeFromSuperview()
//        vDatePicker = nil
//        cellDate.updateDate(str: df.string(from: vDatePicker.datePicker.date))
//        cellDate.lbTime.text = df.string(from: vDatePicker.datePicker.date)
//        cellDate.lbTime.text = df.string(from: vDatePicker.datePicker.date)
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

extension CreateEventViewController: StartEndTimeTableViewCellProtocol{
    func didStartTime(index: Int) {
        cellDate.indexLabel = index
        self.view.endEditing(true)
        if vDatePicker == nil {
            vDatePicker = ViewDatePicker.instanceFromNib()
            vDatePicker.tag = 11
            self.view.addSubview(vDatePicker)
            vDatePicker.delegate = self
        }
    }
    
    func didEndTime(index: Int) {
        cellDate.indexLabel = index
         self.view.endEditing(true)
         if vDatePicker == nil {
             vDatePicker = ViewDatePicker.instanceFromNib()
             vDatePicker.tag = 11
             self.view.addSubview(vDatePicker)
             vDatePicker.delegate = self
         }
    }
}

extension CreateEventViewController: TitleTableViewCellProtocol{
    func getTextEventService(_ str: String, type: typeCellCreateEvent) {
        switch type {
            
        case .Image:
            break
        case .Title:
            self.eventModel.title = str
            break
        case .Time:
            break
        case .Position:
            break
        case .Description:
            break
        case .Language:
            self.eventModel.language = str
            break
        case .Fee:
            self.eventModel.amount = str
            break
        case .CreateEvent:
            break
        case .MaxOrder:
            self.eventModel.maxOrder = str
            break
        }
    }
}

extension CreateEventViewController: DescriptionCarTableViewCellProtocol{
    func getDescriptionText(_ string: String) {
        self.eventModel.description = string
    }
}

extension CreateEventViewController: CompleteTableViewCellProtocol{
    func didComplete() {
        self.showProgressHub()
        self.addNewService()
    }
}
