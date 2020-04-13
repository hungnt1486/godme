//
//  EditProfileViewController.swift
//  godme
//
//  Created by Lê Hùng on 4/6/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import SDWebImage
import Toaster

@objc enum typeCellEditProfile: Int{
    case Avatar = 0
    case FullName = 1
    case Gender = 2
    case Education = 3
    case Position = 4
    case SocialSecurity = 5
    case Job = 6
    case DOB = 7
    case National = 8
    case City = 9
    case District = 10
    case Ward = 11
    case Address = 12
    case Email = 13
    case Experience = 14
    case Intro = 15
    case Code = 16
    case ConnectValue = 17
    case RealText = 18
    case Confirm = 19
}

class EditProfileViewController: BaseViewController {

    @IBOutlet weak var tbvEditProfile: UITableView!
    var listTypeCell: [typeCellEditProfile] = [.Avatar, .FullName, .Gender, .Education, .Position, .SocialSecurity, .Job, .DOB, .National, .City, .District, .Ward, .Address, .Email, .Experience, .Intro, .Code, .ConnectValue, .RealText, .Confirm]
    var cellImage: AvatarTableViewCell!
    var userInfo: UserRegisterReturnModel?
    var imagePicker = UIImagePickerController()
    var imgAvatar = UIImage.init(named: "ic_avatar")
    var isUploadImg = false
    var userInfoModel = UserProfileParamsModel()
    
    var arrayProvince: [[String: String]] = []
    var arrayDistrict: [[String: String]] = []
    var arrayWard: [[String: String]] = []
    var arrayEducation: [[String: String]] = []
    var arrayJobs: [[String: String]] = []
    var arrayGender: [[String: String]] = []
    var arrTemp: [GenderModel] = []
    
    var cellDistrict: TypeCarTableViewCell!
    var cellWard: TypeCarTableViewCell!
    var cellDate: DateTableViewCell!
    
    var vDatePicker: ViewDatePicker1!
    var vCheckBox: ViewShowListCheckBoxJob!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showProgressHub()
        self.setupUI()
        self.configButtonBack()
        self.setupTableview()
        self.getUserInfo()
    }
    
    func setupUI(){
        self.arrayJobs = BaseViewController.arrayJobs
        self.arrayProvince = self.loadProvince()
        self.arrayEducation = self.loadEduction()
        self.arrTemp = Settings.ShareInstance.Gender()
        if  self.arrTemp.count > 0 {
            for item in self.arrTemp {
                self.arrayGender.append(["name":item.Name ?? "", "code": "\(item.Id ?? "")"])
            }
        }
        
        imagePicker.delegate = self
        self.navigationItem.title = "Cập nhật thông tin"
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setupTableview(){
        self.tbvEditProfile.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        self.tbvEditProfile.register(UINib(nibName: "AvatarTableViewCell", bundle: nil), forCellReuseIdentifier: "AvatarTableViewCell")
        self.tbvEditProfile.register(UINib(nibName: "TypeCarTableViewCell", bundle: nil), forCellReuseIdentifier: "TypeCarTableViewCell")
        self.tbvEditProfile.register(UINib(nibName: "CompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteTableViewCell")
        self.tbvEditProfile.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTableViewCell")
        self.tbvEditProfile.register(UINib(nibName: "DescriptionCarTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionCarTableViewCell")
        self.tbvEditProfile.register(UINib(nibName: "DateTableViewCell", bundle: nil), forCellReuseIdentifier: "DateTableViewCell")
        self.tbvEditProfile.register(UINib(nibName: "JobTableViewCell", bundle: nil), forCellReuseIdentifier: "JobTableViewCell")
        self.tbvEditProfile.delegate = self
        self.tbvEditProfile.dataSource = self
        self.tbvEditProfile.separatorColor = UIColor.clear
        self.tbvEditProfile.separatorInset = UIEdgeInsets.zero
        self.tbvEditProfile.allowsSelection = false
        self.tbvEditProfile.estimatedRowHeight = 100
        self.tbvEditProfile.rowHeight = UITableView.automaticDimension
    }
    
    func loadProvince()->[[String:String]]{
        var arrString: [[String:String]] = []
        let arrCountry = Settings.ShareInstance.loadProvince()
        if arrCountry.count > 0 {
            for item in arrCountry {
                arrString.append(["name":item.name ?? "", "code": "\(item.code ?? "")"])
            }
        }
        return arrString
    }
    
    func loadDistrict(parentCode: String)->[[String:String]]{
        var arrString: [[String:String]] = []
        let arrCountry = Settings.ShareInstance.loadDistrict()
        if arrCountry.count > 0 {
            for item in arrCountry {
                if parentCode == item.parent_code {
                    arrString.append(["name":item.name ?? "", "code": "\(item.code ?? "")"])
                }
            }
        }
        return arrString
    }
    
    func loadWard(parentCode: String)->[[String: String]]{
        var arrString: [[String: String]] = []
        let arrCountry = Settings.ShareInstance.loadWard()
        if arrCountry.count > 0 {
            for item in arrCountry {
                if parentCode == item.parent_code {
                    arrString.append(["name":item.name ?? "", "code": "\(item.code ?? "")"])
                }
            }
        }
        return arrString
    }
    
    func loadEduction() ->[[String: String]]{
        var arrString: [[String: String]] = []
        let arrCountry = Settings.ShareInstance.loadEducation()
        if arrCountry.count > 0 {
            for item in arrCountry {
                arrString.append(["name":item.label ?? "", "code": "\(item.code ?? "")"])
            }
        }
        return arrString
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
    
    func setupVCheckBox(){
        if vCheckBox == nil {
            vCheckBox = ViewShowListCheckBoxJob.instanceFromNib()
            let arr = self.userInfoModel.career.split(separator: ",")
            var arrTemp:[Int] = []
            for item in arr {
                
                arrTemp.append(Int(String(item)) ?? 0)
            }
            vCheckBox.listId = arrTemp
            vCheckBox.tag = 10
            self.view.window?.addSubview(vCheckBox)
            vCheckBox.delegate = self
            self.vCheckBox.configFrame()
        }
    }
    
    func getUserInfo(){
        UserManager.shareUserManager().getUserInfo {[unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                self.userInfo = data[0]
                self.userInfoModel.address = self.userInfo?.address ?? ""
                self.userInfoModel.avatar = self.userInfo?.avatar ?? ""
                self.userInfoModel.career = self.userInfo?.career ?? ""
                self.userInfoModel.createdBy = self.userInfo?.createdBy ?? ""
                self.userInfoModel.createdByUserId = self.userInfo?.createdByUserId ?? 0
                self.userInfoModel.createdOn = self.userInfo?.createdOn ?? 0.0
                self.userInfoModel.districtCode = self.userInfo?.districtCode ?? "0"
                self.userInfoModel.districtName = self.userInfo?.districtName ?? ""
                self.userInfoModel.dob = Settings.ShareInstance.convertDOB(str: self.userInfo?.dob ?? "")
                self.userInfoModel.education = self.userInfo?.education ?? ""
                self.userInfoModel.email = self.userInfo?.email ?? ""
                self.userInfoModel.experience = self.userInfo?.experience ?? ""
                self.userInfoModel.fullName = self.userInfo?.fullName ?? ""
                self.userInfoModel.gender = self.userInfo?.gender ?? ""
                self.userInfoModel.id = self.userInfo?.id ?? 0
                self.userInfoModel.idNumber = self.userInfo?.idNumber ?? 0
                self.userInfoModel.isConnected = self.userInfo?.isConnected ?? 0
                self.userInfoModel.limitReferralCode = self.userInfo?.limitReferralCode ?? 0
                self.userInfoModel.modifiedOn = self.userInfo?.modifiedOn ?? 0.0
                self.userInfoModel.nationCode = self.userInfo?.nationCode ?? "0"
                self.userInfoModel.nationName = self.userInfo?.nationName ?? ""
                self.userInfoModel.phoneNumber = self.userInfo?.phoneNumber ?? ""
                self.userInfoModel.position = self.userInfo?.position ?? ""
                self.userInfoModel.provinceCode = self.userInfo?.provinceCode ?? ""
                self.userInfoModel.provinceName = self.userInfo?.provinceName ?? ""
                self.userInfoModel.referralCode = self.userInfo?.referralCode ?? ""
                self.userInfoModel.totalStar = Double(self.userInfo?.totalStar ?? 0.0)
                self.userInfoModel.userCategory = self.userInfo?.userCategory ?? ""
                self.userInfoModel.userCode = self.userInfo?.userCode ?? ""
                self.userInfoModel.userInfo = self.userInfo?.userInfo ?? ""
                self.userInfoModel.wardCode = self.userInfo?.wardCode ?? ""
                self.userInfoModel.wardName = self.userInfo?.wardName ?? ""
                self.tbvEditProfile.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func updateProfile(){
        let group = DispatchGroup()
        if self.isUploadImg {
            group.enter()
            AWSS3Manager.shared.uploadImage(image: cellImage.imgAvatar.image!, progress: nil) { [unowned self] (fileURL, error) in
                
                if error == nil {
                    self.userInfoModel.avatar = fileURL as! String
                }else{
                    Settings.ShareInstance.showAlertView(message: error?.localizedDescription ?? "", vc: self)
                    group.leave()
                    return
                }
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.global(qos: .background)) {
            var model = AddNewUserProfileParams()
            model.id = self.userInfoModel.id
            model.idNumber = self.userInfoModel.idNumber
            model.avatar = self.userInfoModel.avatar
            model.fullName = self.userInfoModel.fullName
            model.gender = self.userInfoModel.gender
            model.position = self.userInfoModel.position
            model.education = self.userInfoModel.education
            model.experience = self.userInfoModel.experience
            model.dob = self.userInfoModel.dob
            model.career = self.userInfoModel.career
            model.idNumber = self.userInfoModel.idNumber
            model.email = self.userInfoModel.email
            model.userInfo = self.userInfoModel.userInfo
            model.nationCode = self.userInfoModel.nationCode
            model.nationName = self.userInfoModel.nationName
            model.provinceCode = self.userInfoModel.provinceCode
            model.provinceName = self.userInfoModel.provinceName
            model.districtCode = self.userInfoModel.districtCode
            model.districtName = self.userInfoModel.districtName
            model.wardCode = self.userInfoModel.wardCode
            model.wardName = self.userInfoModel.wardName
            model.address = self.userInfoModel.address
            model.userCode = self.userInfoModel.userCode
            self.updateUserInfo(model: model)
        }
    }
    
    func updateUserInfo(model: AddNewUserProfileParams){
        UserManager.shareUserManager().updateUserInfo(model: model) {[unowned self] (response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
}

extension EditProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = listTypeCell[indexPath.row]
        switch type {
            
        case .Avatar:
            cellImage = tableView.dequeueReusableCell(withIdentifier: "AvatarTableViewCell") as? AvatarTableViewCell
            if self.userInfoModel.avatar.count > 0 {
                if imgAvatar?.jpegData(compressionQuality: 0.5) != UIImage.init(named: "ic_avatar")?.jpegData(compressionQuality: 0.5) {
                    cellImage.imgAvatar.image = imgAvatar
                }else{
                    cellImage.imgAvatar.sd_setImage(with: URL.init(string: self.userInfoModel.avatar), placeholderImage: imgAvatar, options: .lowPriority) { [unowned self] (img, error, nil, url) in
                        if error == nil {
                            self.cellImage.imgAvatar.image = img
                        }
                    }
                }
            }else {
                cellImage.imgAvatar.image = imgAvatar
            }
            cellImage.lbCode.text = "Mã giới thiệu: \(userInfoModel.userCode)"
            cellImage.delegate = self
            return cellImage
        case .FullName:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.textColor = UIColor.FlatColor.Gray.TextColor
            cell.lbTitle.text = "Họ và tên"
            cell.tfInput.placeholder = "Họ và tên"
            cell.tfInput.tag = indexPath.row
            cell.tfInput.text = userInfoModel.fullName
            cell.delegate = self
            return cell
        case .Gender:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCarTableViewCell") as! TypeCarTableViewCell
            cell.lbTitle.text = "Giới tính"
            cell.lbTitle.textColor = UIColor.FlatColor.Gray.TextColor
            cell.lbTypeCar.tag = indexPath.row
            cell.lbTypeCar.text = userInfoModel.gender == "NAM" ? "Nam" : "Nữ"
            cell.delegate = self
            if cell.arr.count == 0 {
                cell.arr = self.arrayGender
                cell.setupTypeDropdown()
            }
            return cell
        case .Education:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCarTableViewCell") as! TypeCarTableViewCell
            cell.lbTitle.textColor = UIColor.FlatColor.Gray.TextColor
            cell.lbTitle.text = "Học vấn"
            cell.lbTypeCar.tag = indexPath.row
            for item in self.arrayEducation {
                if item["code"] == userInfoModel.education {
                    cell.lbTypeCar.text = item["name"]
                    break
                }
            }
            cell.delegate = self
            if cell.arr.count == 0 {
                cell.arr = self.arrayEducation
                cell.setupTypeDropdown()
            }
            return cell
        case .Position:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.textColor = UIColor.FlatColor.Gray.TextColor
            cell.lbTitle.text = "Chức vụ"
            cell.tfInput.tag = indexPath.row
            cell.tfInput.text = userInfoModel.position
            cell.delegate = self
            return cell
        case .SocialSecurity:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.textColor = UIColor.FlatColor.Gray.TextColor
            cell.lbTitle.text = "Số CMND"
            cell.tfInput.tag = indexPath.row
            cell.tfInput.text = "\(userInfoModel.idNumber)"
            cell.delegate = self
            return cell
        case .Job:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobTableViewCell") as! JobTableViewCell
            cell.lbTitle.textColor = UIColor.FlatColor.Gray.TextColor
            cell.lbTitle.text = "Ngành nghề"
            cell.lbTypeCar.tag = indexPath.row
            if userInfoModel.career.count > 0 {
                let career = userInfoModel.career
                let arrCareer = career.split(separator: ",")
                var strCareer = ""
                for item in arrCareer {
                    for item1 in self.arrayJobs {
                        if Int(item) == Int(item1["code"] ?? "0") {
                            if strCareer.count == 0 {
                                strCareer = strCareer + (item1["name"] ?? "")
                            }else {
                                strCareer = strCareer + ", " + (item1["name"] ?? "")
                            }
                        }
                        break
                    }
                }
                cell.lbTypeCar.text = strCareer
            }
            cell.delegate = self
            return cell
        case .DOB:
            cellDate = tableView.dequeueReusableCell(withIdentifier: "DateTableViewCell") as? DateTableViewCell
            cellDate.lbTitle.textColor = UIColor.FlatColor.Gray.TextColor
            cellDate.lbTitle.text = "Ngày sinh"
            cellDate.lbTypeCar.tag = indexPath.row
            cellDate.lbTypeCar.text = userInfoModel.dob
            cellDate.delegate = self
            return cellDate
        case .National:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCarTableViewCell") as! TypeCarTableViewCell
            cell.lbTitle.textColor = UIColor.FlatColor.Gray.TextColor
            cell.lbTitle.text = "Quốc gia"
            cell.lbTypeCar.tag = indexPath.row
            cell.lbTypeCar.text = userInfoModel.nationName
            cell.delegate = self
            return cell
        case .City:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCarTableViewCell") as! TypeCarTableViewCell
            cell.lbTitle.textColor = UIColor.FlatColor.Gray.TextColor
            cell.lbTitle.text = "Tỉnh/Thành phố"
            cell.lbTypeCar.tag = indexPath.row
            cell.lbTypeCar.text = userInfoModel.provinceName
            cell.delegate = self
            if cell.arr.count == 0 {
                cell.arr = self.arrayProvince
                cell.setupTypeDropdown()
            }
            return cell
        case .District:
            cellDistrict = tableView.dequeueReusableCell(withIdentifier: "TypeCarTableViewCell") as? TypeCarTableViewCell
            cellDistrict.lbTitle.textColor = UIColor.FlatColor.Gray.TextColor
            cellDistrict.lbTitle.text = "Quận/Huyện"
            cellDistrict.lbTypeCar.tag = indexPath.row
            cellDistrict.lbTypeCar.text = userInfoModel.districtName
            cellDistrict.delegate = self
            return cellDistrict
        case .Ward:
            cellWard = tableView.dequeueReusableCell(withIdentifier: "TypeCarTableViewCell") as? TypeCarTableViewCell
            cellWard.lbTitle.textColor = UIColor.FlatColor.Gray.TextColor
            cellWard.lbTitle.text = "Phường/Xã"
            cellWard.lbTypeCar.tag = indexPath.row
            cellWard.lbTypeCar.text = userInfoModel.wardName
            cellWard.delegate = self
            return cellWard
        case .Address:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.textColor = UIColor.FlatColor.Gray.TextColor
            cell.lbTitle.text = "Địa chỉ"
            cell.tfInput.tag = indexPath.row
            cell.tfInput.text = userInfoModel.address
            cell.delegate = self
            return cell
        case .Email:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.textColor = UIColor.FlatColor.Gray.TextColor
            cell.lbTitle.text = "Email"
            cell.tfInput.tag = indexPath.row
            cell.tfInput.text = userInfoModel.email
            cell.delegate = self
            return cell
        case .Experience:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCarTableViewCell") as! DescriptionCarTableViewCell
            cell.lbTitle.textColor = UIColor.FlatColor.Gray.TextColor
            cell.lbTitle.text = "Kinh nghiệm"
            cell.textView.tag = indexPath.row
            cell.textView.text = userInfoModel.experience
            cell.delegate = self
            return cell
        case .Intro:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCarTableViewCell") as! DescriptionCarTableViewCell
            cell.lbTitle.textColor = UIColor.FlatColor.Gray.TextColor
            cell.lbTitle.text = "Giới thiệu bản thân"
            cell.textView.tag = indexPath.row
            cell.textView.text = userInfoModel.userInfo
            cell.delegate = self
            return cell
        case .Code:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.textColor = UIColor.FlatColor.Gray.TextColor
            cell.lbTitle.text = "Mã giới thiệu"
            cell.tfInput.tag = indexPath.row
            cell.tfInput.text = userInfoModel.userCode
            cell.delegate = self
            return cell
        case .ConnectValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.textColor = UIColor.FlatColor.Gray.TextColor
            cell.lbTitle.text = "Giá trị kết nối"
            cell.tfInput.tag = indexPath.row
//            cell.tfInput.text = userInfoModel.userCode
            cell.tfInput.keyboardType = .numberPad
            cell.delegate = self
            return cell
        case .RealText:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell") as! ContentTableViewCell
            let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Roboto-regular", size: 15.0), NSAttributedString.Key.foregroundColor : UIColor.FlatColor.Red.TextColor]
            let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Medium", size: 15.0), NSAttributedString.Key.foregroundColor : UIColor.black]
            let attr1 = NSMutableAttributedString(string: "Không được phép nhập thông tin liên hệ cá nhân vào mô tả. ", attributes: attrs1 as [NSAttributedString.Key : Any])
            let attr2 = NSMutableAttributedString(string: "Khuyến nghị sử dụng thông tin thật vì lợi ích tài chính người dùng", attributes: attrs2 as [NSAttributedString.Key : Any])
            attr1.append(attr2)
            cell.lbText.attributedText = attr1
            return cell
        case .Confirm:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
            cell.delegate = self
            cell.btComplete.setTitle("Cập nhật", for: .normal)
            return cell
        }
    }
}

extension EditProfileViewController: TypeCarTableViewCellProtocol{
    func eventGetTextEditProfile(_ string: String, type: typeCellEditProfile, index: Int) {
        switch type {
            
        case .Avatar:
            break
        case .FullName:
            break
        case .Gender:
            self.userInfoModel.gender = string == "Nam" ? "NAM" : "NU"
            break
        case .Education:
            self.userInfoModel.education = self.arrayEducation[index]["code"] ?? ""
            break
        case .Position:
            break
        case .SocialSecurity:
            break
        case .Job:
            self.userInfoModel.career = self.arrayJobs[index]["code"] ?? ""
            break
        case .DOB:
            break
        case .National:
            break
        case .City:
            let parentCode = self.arrayProvince[index]["code"]
            self.arrayDistrict = self.loadDistrict(parentCode: parentCode ?? "")
            if self.userInfoModel.provinceCode != parentCode {
                self.userInfoModel.provinceCode = parentCode ?? ""
                self.userInfoModel.provinceName = string
                cellDistrict.lbTypeCar.text = ""
                cellWard.lbTypeCar.text = ""
            }
            if cellDistrict.arr.count > 0 {
                cellDistrict.arr.removeAll()
                cellDistrict.arrString.removeAll()
            }
            cellDistrict.arr = arrayDistrict
            cellDistrict.setupTypeDropdown()
            break
        case .District:
            let parentCode = self.arrayDistrict[index]["code"]
            DispatchQueue.main.async {
                self.arrayWard = self.loadWard(parentCode: parentCode ?? "")
                if self.userInfoModel.districtCode != parentCode {
                    self.userInfoModel.districtCode = parentCode ?? ""
                    self.userInfoModel.districtName = string
                    self.cellWard.lbTypeCar.text = ""
                }
                if self.cellWard.arr.count > 0 {
                    self.cellWard.arr.removeAll()
                    self.cellWard.arrString.removeAll()
                }
                self.cellWard.arr = self.arrayWard
                self.cellWard.setupTypeDropdown()
            }
            break
        case .Ward:
            let code = self.arrayWard[index]["code"]
            self.userInfoModel.wardCode = code ?? ""
            self.userInfoModel.wardName = string
            break
        case .Address:
            break
        case .Email:
            break
        case .Experience:
            break
        case .Intro:
            break
        case .Code:
            break
        case .ConnectValue:
            break
        case .RealText:
            break
        case .Confirm:
            break
        }
    }
    
}

extension EditProfileViewController: CompleteTableViewCellProtocol{
    func didComplete() {
        self.showProgressHub()
        self.updateProfile()
    }
}

extension EditProfileViewController: TitleTableViewCellProtocol{
    func getTextEditProfile(_ str: String, type: typeCellEditProfile) {
        switch type {
            
        case .Avatar:
            break
        case .FullName:
            self.userInfoModel.fullName = str
            break
        case .Gender:
            break
        case .Education:
            break
        case .Position:
            self.userInfoModel.position = str
            break
        case .SocialSecurity:
            self.userInfoModel.idNumber = Int(str) ?? 0
            break
        case .Job:
            break
        case .DOB:
            break
        case .National:
            break
        case .City:
            break
        case .District:
            break
        case .Ward:
            break
        case .Address:
            self.userInfoModel.address = str
            break
        case .Email:
            self.userInfoModel.email = str
            break
        case .Experience:
            break
        case .Intro:
            break
        case .Code:
            self.userInfoModel.userCode = str
            break
        case .ConnectValue:
            break
        case .RealText:
            break
        case .Confirm:
            break
        }
    }
}

extension EditProfileViewController: AvatarTableViewCellProtocol{
    func didCopy() {
        UIPasteboard.general.string = "\(URLs.linkWebRefference)refId=\(self.userInfoModel.id)"
        Toast.init(text: "Copy").show()
    }
    
    func didImg() {
        self.chooseAvatar()
    }
}

extension EditProfileViewController: DescriptionCarTableViewCellProtocol{
    func getDescriptionText(_ string: String) {
        
    }
    
    func getDescriptionTextEditProfile(_ string: String, type: typeCellEditProfile) {
        switch type {
            
        case .Avatar:
            break
        case .FullName:
            break
        case .Gender:
            break
        case .Education:
            break
        case .Position:
            break
        case .SocialSecurity:
            break
        case .Job:
            break
        case .DOB:
            break
        case .National:
            break
        case .City:
            break
        case .District:
            break
        case .Ward:
            break
        case .Address:
            break
        case .Email:
            break
        case .Experience:
            self.userInfoModel.experience = string
            break
        case .Intro:
            self.userInfoModel.userInfo = string
            break
        case .Code:
            break
        case .ConnectValue:
            break
        case .RealText:
            break
        case .Confirm:
            break
        }
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.imagePicker.dismiss(animated: true) {
            self.isUploadImg = true
            self.imgAvatar = info[.editedImage] as? UIImage
            let indexPath = NSIndexPath(row: 0, section: 0)
            self.tbvEditProfile.reloadRows(at: [indexPath as IndexPath], with: .none)
        }
        print("info = \(info)")
    }
}

extension EditProfileViewController: ViewDatePicker1Protocol {
    
    func tapDone(_ index: Int) {
        print("tap done")
        let df = DateFormatter.init()
        df.dateFormat = "yyyy-MM-dd"
        cellDate.lbTypeCar.text = df.string(from: vDatePicker.datePicker.date)
        self.userInfoModel.dob = df.string(from: vDatePicker.datePicker.date)
//        self.userInfoModel.dob
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

extension EditProfileViewController: DateTableViewCellProtocol{
    func getDateText(_ str: String) {
        
    }
    
    func showDatePicker() {
        self.view.endEditing(true)
        if vDatePicker == nil {
            vDatePicker = ViewDatePicker1.instanceFromNib()
            vDatePicker.datePicker.datePickerMode = .date
            vDatePicker.indexPosition = 1
            vDatePicker.tag = 11
            self.view.addSubview(vDatePicker)
            vDatePicker.delegate = self
        }
    }
    
    
}

extension EditProfileViewController: ViewShowListCheckBoxJobProtocol{
    func tapDone(_ list: [Int]) {
        if list.count == 0 {
            Settings.ShareInstance.showAlertView(message: "Vui lòng chọn nhóm quan hệ", vc: self)
            return
        }
        var str: String = ""
        for i in 0..<list.count {
            if str.count == 0 {
                str = "\(list[i])"
            }else{
                str = "\(str),\(list[i])"
            }
        }
        self.userInfoModel.career = str
        vCheckBox.viewWithTag(10)?.removeFromSuperview()
        vCheckBox = nil
        self.tbvEditProfile.reloadData()
    }
    
    func tapCancelJob() {
//        self.listUserId.removeAll()
        vCheckBox.viewWithTag(10)?.removeFromSuperview()
        vCheckBox = nil
    }
    
    func tapGestureJob() {
//        self.listUserId.removeAll()
        vCheckBox.viewWithTag(10)?.removeFromSuperview()
        vCheckBox = nil
    }
}

extension EditProfileViewController: JobTableViewCellProtocol{
    func showPopup() {
        self.setupVCheckBox()
    }
}
