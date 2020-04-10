//
//  RegisterViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/4/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

@objc enum typeCellRegister: Int {
    case RealText = 0
    case FullName = 1
    case Password = 2
    case PasswordConfirm = 3
    case Email = 4
    case Country = 5
    case City = 6
    case District  = 7
    case Ward = 8
    case Address = 9
    case Job = 10
    case Gender = 11
    case Refferal = 12
    case RefferalDefault = 13
    case Complete = 14
}

class RegisterViewController: BaseViewController {
    
    deinit {
        print("RegisterViewController")
    }

    @IBOutlet weak var tbvRegister: UITableView!
    
    var arrayProvince: [[String: String]] = []
    var arrayDistrict: [[String: String]] = []
    var arrayWard: [[String: String]] = []
    var arrayEducation: [[String: String]] = []
    var arrayJobs: [[String: String]] = []
    var arrayGender: [[String: String]] = []
    var arrTemp: [GenderModel] = []
    var phoneNumber: String = ""
    
    var cellDob: TwiceComboboxTableViewCell!
    
    var vCheckBox: ViewShowListCheckBoxJob!
    var vDatePicker: ViewDatePicker1!
    
    var cellDistrict: ComboboxTableViewCell!
    var cellWard: ComboboxTableViewCell!
    
    var registerModel = RegisterParamsModel()
    
    var strCity, strDistrict, strWard: String?
    
    var listTypeCell : [typeCellRegister] = [.RealText, .FullName, .Password, .PasswordConfirm, .Email, .Country, .City, .District, .Ward, .Address, .Job, .Gender, .Refferal, .RefferalDefault, .Complete]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.configButtonBack()
        self.setupTableView()
    }
    
    func setupUI(){
        self.navigationItem.title = Settings.ShareInstance.translate(key: "register")
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = UIColor.FlatColor.Gray.BGColor
        self.registerModel.email = phoneNumber
//        self.arrayCountry = self.loadCountry()
        self.arrayJobs = BaseViewController.arrayJobs
        self.arrayProvince = self.loadProvince()
        self.arrayEducation = self.loadEduction()
        self.arrTemp = Settings.ShareInstance.Gender()
        if  self.arrTemp.count > 0 {
            for item in self.arrTemp {
                self.arrayGender.append(["name":item.Name ?? "", "code": "\(item.Id ?? "")"])
            }
        }
    }
    
    func setupTableView(){
        self.tbvRegister.register(UINib(nibName: "TwiceComboboxTableViewCell", bundle: nil), forCellReuseIdentifier: "TwiceComboboxTableViewCell")
        self.tbvRegister.register(UINib(nibName: "InputTextTableViewCell", bundle: nil), forCellReuseIdentifier: "InputTextTableViewCell")
        self.tbvRegister.register(UINib(nibName: "ComboboxTableViewCell", bundle: nil), forCellReuseIdentifier: "ComboboxTableViewCell")
        self.tbvRegister.register(UINib(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTableViewCell")

        self.tbvRegister.register(UINib.init(nibName: "CompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteTableViewCell")
        self.tbvRegister.delegate = self
        self.tbvRegister.dataSource = self
        self.tbvRegister.allowsSelection = false
        self.tbvRegister.separatorColor = UIColor.clear
        self.tbvRegister.separatorInset = UIEdgeInsets.zero
        
        self.tbvRegister.rowHeight = UITableView.automaticDimension
        self.tbvRegister.estimatedRowHeight = 300
    }
    
    func loadCountry()->[String]{
        var arrString: [String] = []
        let arrCountry = Settings.ShareInstance.loadCountry()
        if arrCountry.count > 0 {
            for item in arrCountry {
                arrString.append(item.name ?? "")
            }
        }
        return arrString
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
    
    func setupVCheckBox(){
        if vCheckBox == nil {
            vCheckBox = ViewShowListCheckBoxJob.instanceFromNib()
            let arr = self.registerModel.career.split(separator: ",")
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
    
    func registerUser(model: AddNewRegisterParams){
        UserManager.shareUserManager().registerUser(model: model) {[unowned self] (response) in
            switch response{
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: "Chúc mừng bạn đã đăng ký thành công", vc: self) { [unowned self] (str) in
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

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let typeCell = listTypeCell[indexPath.row]
    
           switch typeCell {
            
           case .RealText:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell") as! ContentTableViewCell
            cell.lbText.text = "Khuyến nghị sử dụng thông tin thật vì lợi ích tài chính người dùng."
            return cell
           case .FullName:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextTableViewCell") as! InputTextTableViewCell
            cell.tfText.placeholder = "Họ và tên"
            cell.tfText.tag = indexPath.row
            cell.tfText.text = self.registerModel.fullName
            cell.delegate = self
            return cell
           case .Password:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextTableViewCell") as! InputTextTableViewCell
            cell.tfText.placeholder = "Mật khẩu"
            cell.tfText.tag = indexPath.row
            cell.tfText.isSecureTextEntry = true
            cell.tfText.text = self.registerModel.password
            cell.delegate = self
            return cell
           case .PasswordConfirm:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextTableViewCell") as! InputTextTableViewCell
            cell.tfText.placeholder = "Xác nhận mật khẩu"
            cell.tfText.tag = indexPath.row
            cell.tfText.isSecureTextEntry = true
            cell.tfText.text = self.registerModel.passwordConfirm
            cell.delegate = self
            return cell
           case .Email:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextTableViewCell") as! InputTextTableViewCell
            cell.tfText.placeholder = "Số điện thoại"
            cell.tfText.tag = indexPath.row
            cell.tfText.isUserInteractionEnabled = false
            cell.tfText.text = self.registerModel.email
            cell.delegate = self
            return cell
           case .Country:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComboboxTableViewCell") as! ComboboxTableViewCell
            cell.tfText.placeholder = "Quốc gia"
            cell.tfText.text = "Việt Nam"
            cell.btShow.tag = indexPath.row
            self.registerModel.nationCode = "VN"
            self.registerModel.nationName = "Việt Nam"
            cell.delegate = self
            return cell
           case .City:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComboboxTableViewCell") as! ComboboxTableViewCell
            cell.tfText.placeholder = "Thành phố"
            cell.btShow.tag = indexPath.row
            cell.delegate = self
            if cell.arr.count == 0 {
                cell.arr = arrayProvince
                cell.setupTypeDropdown()
            }
            return cell
           case .District:
            cellDistrict = tableView.dequeueReusableCell(withIdentifier: "ComboboxTableViewCell") as? ComboboxTableViewCell
            cellDistrict.tfText.placeholder = "Quận/Huyện"
            cellDistrict.btShow.tag = indexPath.row
            cellDistrict.delegate = self
            return cellDistrict
           case .Ward:
            cellWard = tableView.dequeueReusableCell(withIdentifier: "ComboboxTableViewCell") as? ComboboxTableViewCell
            cellWard.tfText.placeholder = "Phường/Xã"
            cellWard.btShow.tag = indexPath.row
            cellWard.delegate = self
            return cellWard
           case .Address:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextTableViewCell") as! InputTextTableViewCell
            cell.tfText.placeholder = "Địa chỉ"
            cell.tfText.tag = indexPath.row
            cell.tfText.text = self.registerModel.address
            cell.delegate = self
            return cell
           case .Job:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwiceComboboxTableViewCell") as! TwiceComboboxTableViewCell
            cell.tfText1.placeholder = "Ngành nghề"
            cell.tfText2.placeholder = "Học vấn"
            cell.btShow1.tag = indexPath.row
            cell.btShow2.tag = indexPath.row
            if self.arrayJobs.count > 0 {
                cell.isListJob = 1
                
                if self.registerModel.career.count > 0 {
                    let career = registerModel.career
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
                                break
                            }
                        }
                    }
                    cell.tfText1.text = strCareer
                }
                
            }
            if self.arrayEducation.count > 0 {
                if cell.arrSub.count == 0 {
                    cell.arrSub = self.arrayEducation
                    cell.setupTypeDropdownSub()
                }
            }
            for item in self.arrayEducation {
                if item["code"] == registerModel.education {
                    cell.tfText2.text = item["name"]
                    break
                }
            }
            
            cell.delegate = self
            return cell
           case .Gender:
            cellDob = tableView.dequeueReusableCell(withIdentifier: "TwiceComboboxTableViewCell") as? TwiceComboboxTableViewCell
            cellDob.tfText1.placeholder = "Độ tuổi"
            cellDob.tfText2.placeholder = "Giới tính"
            cellDob.tfText2.text = self.registerModel.gender == "NAM" ? "Nam" : "Nữ"
            cellDob.tfText1.text = self.registerModel.dob
            cellDob.btShow1.tag = indexPath.row
            cellDob.btShow2.tag = indexPath.row
            cellDob.isListJob = 2
            if self.arrayGender.count > 0 {
                if cellDob.arrSub.count == 0 {
                    cellDob.arrSub = self.arrayGender
                    cellDob.setupTypeDropdownSub()
                }
            }
            cellDob.delegate = self
            return cellDob
           case .Refferal:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextTableViewCell") as! InputTextTableViewCell
            cell.tfText.tag = indexPath.row
            cell.tfText.placeholder = "Mã giới thiệu"
            cell.tfText.text = self.registerModel.referralCode
            cell.delegate = self
            return cell
           case .RefferalDefault:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell") as! ContentTableViewCell
            cell.lbText.text = "Nếu bạn chưa có mã giới thiệu thì nhập mã giới thiệu mặc định: Godme 1789"
            return cell
           case .Complete:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension RegisterViewController: InputTextTableViewCellProtocol{
    func getTextInput(_ string: String, type: typeCellRegister) {
        switch type {
            
        case .RealText:
            break
        case .FullName:
            self.registerModel.fullName = string
            break
        case .Password:
            self.registerModel.password = string
            break
        case .PasswordConfirm:
            self.registerModel.passwordConfirm = string
            break
        case .Email:
            self.registerModel.email = string
            break
        case .Country:
            break
        case .City:
            break
        case .District:
            break
        case .Ward:
            break
        case .Address:
            self.registerModel.address = string
            break
        case .Job:
            break
        case .Gender:
            break
        case .Refferal:
            self.registerModel.referralCode = string
            break
        case .RefferalDefault:
            break
        case .Complete:
            break
        }
    }
    func getTextInput(_ string: String) {
        print("string = \(string)")
    }
}

extension RegisterViewController: ComboboxTableViewCellProtocol{
    func didTouch(str: String, type: typeCellRegister, index: Int) {
        print("str = \(str), type = \(type), index = \(index)")
        switch type {
            
        case .RealText:
            break
        case .FullName:
            break
        case .Password:
            break
        case .PasswordConfirm:
            break
        case .Email:
            break
        case .Country:
            break
        case .City:
            let parentCode = self.arrayProvince[index]["code"]
            self.arrayDistrict = self.loadDistrict(parentCode: parentCode ?? "")
//            if self.userInfoModel.provinceCode != parentCode {
//                self.userInfoModel.provinceCode = parentCode ?? ""
//                self.userInfoModel.provinceName = string
//                cellDistrict.lbTypeCar.text = ""
//                cellWard.lbTypeCar.text = ""
//            }
            if self.strCity != parentCode {
                self.strCity = parentCode
                self.registerModel.provinceCode = parentCode ?? ""
                self.registerModel.provinceName = str
                cellDistrict.tfText.text = ""
                cellWard.tfText.text = ""
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
                if self.strDistrict != parentCode {
                    self.strDistrict = parentCode
                    self.registerModel.districtCode = parentCode ?? ""
                    self.registerModel.districtName = str
                    self.cellWard.tfText.text = ""
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
            self.registerModel.wardCode = code ?? ""
            self.registerModel.wardName = str
            self.strWard = code
            break
        case .Address:
            break
        case .Job:
            break
        case .Gender:
            break
        case .Refferal:
            break
        case .RefferalDefault:
            break
        case .Complete:
            break
        }
    }
}

extension RegisterViewController: TwiceComboboxTableViewCellProtocol{
    func didTouch1(_ index: Int, type: typeCellRegister, str: String) {
        switch type {
            
        case .RealText:
            break
        case .FullName:
            break
        case .Password:
            break
        case .PasswordConfirm:
            break
        case .Email:
            break
        case .Country:
            break
        case .City:
            break
        case .District:
            break
        case .Ward:
            break
        case .Address:
            break
        case .Job:
            break
        case .Gender:
            self.registerModel.dob = str
            break
        case .Refferal:
            break
        case .RefferalDefault:
            break
        case .Complete:
            break
        }
    }
    
    func didTouch2(_ index: Int, type: typeCellRegister, str: String) {
        switch type {
            
        case .RealText:
            break
        case .FullName:
            break
        case .Password:
            break
        case .PasswordConfirm:
            break
        case .Email:
            break
        case .Country:
            break
        case .City:
            break
        case .District:
            break
        case .Ward:
            break
        case .Address:
            break
        case .Job:
            self.registerModel.education = self.arrayEducation[index]["code"] ?? ""
            break
        case .Gender:
            self.registerModel.gender = str == "Nam" ? "NAM" : "NU"
            break
        case .Refferal:
            break
        case .RefferalDefault:
            break
        case .Complete:
            break
        }
    }
    
    func didShowListJob() {
        self.setupVCheckBox()
    }
    
    func didShowDate() {
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

extension RegisterViewController: ViewShowListCheckBoxJobProtocol{
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
//        self.userInfoModel.career = str
        self.registerModel.career = str
        vCheckBox.viewWithTag(10)?.removeFromSuperview()
        vCheckBox = nil
        self.tbvRegister.reloadData()
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

extension RegisterViewController: ViewDatePicker1Protocol {
    
    func tapDone(_ index: Int) {
        print("tap done")
        let df = DateFormatter.init()
        df.dateFormat = "yyyy-MM-dd"
        cellDob.tfText1.text = df.string(from: vDatePicker.datePicker.date)
        self.registerModel.dob = df.string(from: vDatePicker.datePicker.date)
//        cellDate.lbTypeCar.text = df.string(from: vDatePicker.datePicker.date)
//        self.userInfoModel.dob = df.string(from: vDatePicker.datePicker.date)
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

extension RegisterViewController: CompleteTableViewCellProtocol{
    func didComplete() {
        self.showProgressHub()
        if self.registerModel.address.count == 0 ||
            self.registerModel.career.count == 0 ||
            self.registerModel.districtCode.count == 0 ||
            self.registerModel.dob.count == 0 ||
            self.registerModel.education.count == 0 ||
            self.registerModel.email.count == 0 ||
            self.registerModel.fullName.count == 0 ||
            self.registerModel.password.count == 0 ||
            self.registerModel.provinceCode.count == 0 ||
            self.registerModel.referralCode.count == 0 ||
            self.registerModel.username.count == 0 ||
            self.registerModel.wardCode.count == 0 {
            Settings.ShareInstance.showAlertView(message: "Vui lòng điền đầy đủ thông tin", vc: self)
            self.hideProgressHub()
        }
        var model = AddNewRegisterParams()
        model.address = self.registerModel.address
        model.career = self.registerModel.career
        model.codeOTP = self.registerModel.codeOTP
        model.districtCode = self.registerModel.districtCode
        model.districtName = self.registerModel.districtName
        model.dob = self.registerModel.dob
        model.education = self.registerModel.education
        model.email = self.registerModel.email
        model.fullName = self.registerModel.fullName
        model.gender = self.registerModel.gender
        model.nationCode = self.registerModel.nationCode
        model.nationName = self.registerModel.nationName
        model.password = self.registerModel.password
        model.provinceCode = self.registerModel.provinceCode
        model.provinceName = self.registerModel.provinceName
        model.referralCode = self.registerModel.referralCode
        model.username = self.registerModel.username
        model.wardCode = self.registerModel.wardCode
        model.wardName = self.registerModel.wardName
        self.registerUser(model: model)
    }
}
