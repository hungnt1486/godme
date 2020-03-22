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
    
    var arrayCountry: [String] = []
    var arrayProvince: [String] = []
    var arrayDistrict: [String] = []
    var arrayWard: [String] = []
    
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
        
        self.arrayCountry = self.loadCountry()
        self.arrayProvince = self.loadProvince()
        self.arrayDistrict = self.loadDistrict()
        self.arrayWard = self.loadWard()
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
    
    func loadProvince()->[String]{
        var arrString: [String] = []
        let arrCountry = Settings.ShareInstance.loadProvince()
        if arrCountry.count > 0 {
            for item in arrCountry {
                arrString.append(item.name ?? "")
            }
        }
        return arrString
    }
    
    func loadDistrict()->[String]{
        var arrString: [String] = []
        let arrCountry = Settings.ShareInstance.loadDistrict()
        if arrCountry.count > 0 {
            for item in arrCountry {
                arrString.append(item.name ?? "")
            }
        }
        return arrString
    }
    
    func loadWard()->[String]{
        var arrString: [String] = []
        let arrCountry = Settings.ShareInstance.loadWard()
        if arrCountry.count > 0 {
            for item in arrCountry {
                arrString.append(item.name ?? "")
            }
        }
        return arrString
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
            cell.delegate = self
            return cell
           case .Password:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextTableViewCell") as! InputTextTableViewCell
            cell.tfText.placeholder = "Mật khẩu"
            cell.delegate = self
            return cell
           case .PasswordConfirm:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextTableViewCell") as! InputTextTableViewCell
            cell.tfText.placeholder = "Xác nhận mật khẩu"
            cell.delegate = self
            return cell
           case .Email:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextTableViewCell") as! InputTextTableViewCell
            cell.tfText.placeholder = "Email"
            cell.delegate = self
            return cell
           case .Country:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComboboxTableViewCell") as! ComboboxTableViewCell
            cell.tfText.placeholder = "Quốc gia"
            cell.btShow.tag = indexPath.row
            if cell.arrString.count == 0 {
                cell.arrString = arrayCountry
                cell.setupTypeDropdown()
            }
            cell.delegate = self
            return cell
           case .City:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComboboxTableViewCell") as! ComboboxTableViewCell
            cell.tfText.placeholder = "Thành phố"
            cell.btShow.tag = indexPath.row
            cell.delegate = self
            if cell.arrString.count == 0 {
                cell.arrString = arrayProvince
                cell.setupTypeDropdown()
            }
            return cell
           case .District:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComboboxTableViewCell") as! ComboboxTableViewCell
            cell.tfText.placeholder = "Quận/Huyện"
            cell.btShow.tag = indexPath.row
            cell.delegate = self
            if cell.arrString.count == 0 {
                cell.arrString = arrayDistrict
                cell.setupTypeDropdown()
            }
            return cell
           case .Ward:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComboboxTableViewCell") as! ComboboxTableViewCell
            cell.tfText.placeholder = "Phường/Xã"
            cell.btShow.tag = indexPath.row
            cell.delegate = self
            if cell.arrString.count == 0 {
                cell.arrString = arrayWard
                cell.setupTypeDropdown()
            }
            return cell
           case .Address:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextTableViewCell") as! InputTextTableViewCell
            cell.tfText.placeholder = "Địa chỉ"
            cell.delegate = self
            return cell
           case .Job:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwiceComboboxTableViewCell") as! TwiceComboboxTableViewCell
            cell.tfText1.placeholder = "Ngành nghề"
            cell.tfText2.placeholder = "Học vấn"
            cell.delegate = self
            return cell
           case .Gender:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwiceComboboxTableViewCell") as! TwiceComboboxTableViewCell
            cell.tfText1.placeholder = "Độ tuổi"
            cell.tfText2.placeholder = "Giới tính"
            cell.delegate = self
            return cell
           case .Refferal:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextTableViewCell") as! InputTextTableViewCell
            cell.tfText.placeholder = "Mã giới thiệu"
            cell.delegate = self
            return cell
           case .RefferalDefault:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell") as! ContentTableViewCell
            cell.lbText.text = "Nếu bạn chưa có mã giới thiệu thì nhập mã giới thiệu mặc định: Godme 1789"
            return cell
           case .Complete:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
//            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension RegisterViewController: InputTextTableViewCellProtocol{
    func getTextInput(_ string: String) {
        print("string = \(string)")
    }
}

extension RegisterViewController: ComboboxTableViewCellProtocol{
    func didTouch(str: String, type: typeCellRegister, index: Int) {
        print("str = \(str), type = \(type), index = \(index)")
    }
}

extension RegisterViewController: TwiceComboboxTableViewCellProtocol{
    func didTouch1() {
        
    }
    
    func didTouch2() {
        
    }
}
