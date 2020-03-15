//
//  CreateAuctionViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/15/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

enum typeCellCreateAuction: Int {
    case Image = 0
    case Title = 1
    case Time = 2
    case Position = 3
    case Description = 4
    case Language = 5
    case Start_Price = 6
    case Step_Price = 7
    case CreateAuction = 8
}

class CreateAuctionViewController: BaseViewController {

    @IBOutlet weak var tbvCreateAuction: UITableView!
    
    var cellImage: ImageCarTableViewCell!
    var strImgBase64: String = ""
    var imagePicker = UIImagePickerController()
    var index: Int = 0
    var cellAddres: AddressPostCarTableViewCell!
    var vDatePicker: ViewDatePicker!
    var cellDate: DateTableViewCell!
    
    var listTypeCell: [typeCellCreateAuction] = [.Image, .Title, .Time, .Position, .Description, .Language, .Start_Price, .Step_Price, .CreateAuction]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupUI()
        self.setupTableView()
        self.configButtonBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "create_auction")
    }
    
    func setupUI(){
        imagePicker.delegate = self
    }
    
    func setupTableView(){
        self.tbvCreateAuction.register(UINib(nibName: "ImageCarTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageCarTableViewCell")
        self.tbvCreateAuction.register(UINib(nibName: "DescriptionCarTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionCarTableViewCell")
        self.tbvCreateAuction.register(UINib(nibName: "AddressPostCarTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressPostCarTableViewCell")

        self.tbvCreateAuction.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        self.tbvCreateAuction.register(UINib.init(nibName: "DateTableViewCell", bundle: nil), forCellReuseIdentifier: "DateTableViewCell")
        self.tbvCreateAuction.register(UINib.init(nibName: "CompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteTableViewCell")
        self.tbvCreateAuction.delegate = self
        self.tbvCreateAuction.dataSource = self
        self.tbvCreateAuction.allowsSelection = false
        self.tbvCreateAuction.separatorColor = UIColor.clear
        self.tbvCreateAuction.separatorInset = UIEdgeInsets.zero
        
        self.tbvCreateAuction.rowHeight = UITableView.automaticDimension
        self.tbvCreateAuction.estimatedRowHeight = 300
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

}

extension CreateAuctionViewController: UITableViewDelegate, UITableViewDataSource{
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
            return cell
        case .Time:
            cellDate = tableView.dequeueReusableCell(withIdentifier: "DateTableViewCell") as? DateTableViewCell
            cellDate.delegate = self
            cellDate.lbTitle.text = "Thời gian"
            cellDate.lbTypeCar.text = "Chọn thời gian"
            return cellDate
            
        case .Position:
            cellAddres = tableView.dequeueReusableCell(withIdentifier: "AddressPostCarTableViewCell") as? AddressPostCarTableViewCell
            cellAddres.lbTitle.text = "Vị trí"
            cellAddres.lbTypeCar.text = "Chọn địa điểm"
            cellAddres.delegate = self
            return cellAddres
        case .Description:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCarTableViewCell") as! DescriptionCarTableViewCell
            cell.lbTitle.text = "Mô tả"
            return cell
        case .Language:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.text = "Ngôn ngữ"
            cell.tfInput.placeholder = "Chọn ngôn ngữ sử dụng"
            return cell
        case .Start_Price:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.text = "Giá khởi điểm"
            cell.tfInput.placeholder = "Nhập giá khởi điểm"
            return cell
        case .Step_Price:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.text = "Bước giá"
            cell.tfInput.placeholder = "Nhập bước giá"
            return cell
        case .CreateAuction:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
            cell.btComplete.setTitle("Tạo dịch vụ", for: .normal)
            return cell
        
        }
    }
    
    
}

extension CreateAuctionViewController: HeaderSubMainProtocol{
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

extension CreateAuctionViewController: ImageCarTableViewCellProtocol{
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

extension CreateAuctionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.imagePicker.dismiss(animated: true) {
            let img1 = info[.editedImage] as? UIImage
            let img = img1?.resizeWithWidth(width: 400)
            let imgData: Data? = img?.jpegData(compressionQuality: 0.5)//UIImageJPEGRepresentation(img!, 0.5)
            self.strImgBase64 = (imgData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)))!
            //            self.icAvatar.image = img
            //            self.icAvatar.clipsToBounds = true
            self.cellImage?.updateImg(str: self.strImgBase64, index: self.index, img: img ?? UIImage())
            self.tbvCreateAuction.reloadData()
        }
        print("info = \(info)")
    }
}

extension CreateAuctionViewController: AddressPostCarTableViewCellProtocol{
    func getAddress() {
        let map = MapPickerViewController()
        map.onDismissCallback = {[weak self](location) in
            self?.cellAddres.updateAddress(to: location)
//            self?.postModel.Lat = location?.coordinate.latitude ?? 0.0
//            self?.postModel.Lng = location?.coordinate.longitude ?? 0.0
        }
        self.navigationController?.pushViewController(map, animated: true)
    }
    
    func getText(_ str: String) {
        print("address = ", str)
//        postModel.workPlace = str
    }
}

extension CreateAuctionViewController: ViewDatePickerProtocol {
    func tapDone() {
        print("tap done")
        let df = DateFormatter.init()
        df.dateFormat = "dd/MM/yyyy"
//        postModel.dateExpire = df.string(from: vDatePicker.datePicker.date)
//        vDatePicker.viewWithTag(11)?.removeFromSuperview()
//        vDatePicker = nil
        cellDate.updateDate(str: df.string(from: vDatePicker.datePicker.date))
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

extension CreateAuctionViewController: DateTableViewCellProtocol{
    func getDateText(_ str: String) {
        
    }
    
    func showDatePicker() {
        self.view.endEditing(true)
        if vDatePicker == nil {
            vDatePicker = ViewDatePicker.instanceFromNib()
            vDatePicker.tag = 11
            self.view.addSubview(vDatePicker)
            vDatePicker.delegate = self
        }
    }
}
