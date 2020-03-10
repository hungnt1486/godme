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
    
    var listTypeCell : [typeCellRegister] = [.RealText, .FullName, .Password, .PasswordConfirm, .Email, .Country, .City, .District, .Ward, .Address, .Job, .Gender, .Refferal, .RefferalDefault, .Complete]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.configButtonBack()
        self.setupTableView()
    }
    
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = UIColor.FlatColor.Gray.BGColor
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
            return cell
           case .Password:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextTableViewCell") as! InputTextTableViewCell
            cell.tfText.placeholder = "Mật khẩu"
            return cell
           case .PasswordConfirm:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextTableViewCell") as! InputTextTableViewCell
            cell.tfText.placeholder = "Xác nhận mật khẩu"
            return cell
           case .Email:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextTableViewCell") as! InputTextTableViewCell
            cell.tfText.placeholder = "Email"
            return cell
           case .Country:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComboboxTableViewCell") as! ComboboxTableViewCell
            cell.tfText.placeholder = "Quốc  "
            return cell
           case .City:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComboboxTableViewCell") as! ComboboxTableViewCell
            cell.tfText.placeholder = "Thành phố"
            return cell
           case .District:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComboboxTableViewCell") as! ComboboxTableViewCell
            cell.tfText.placeholder = "Quận/Huyện"
            return cell
           case .Ward:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComboboxTableViewCell") as! ComboboxTableViewCell
            cell.tfText.placeholder = "Phường/Xã"
            return cell
           case .Address:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextTableViewCell") as! InputTextTableViewCell
            cell.tfText.placeholder = "Địa chỉ"
            return cell
           case .Job:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwiceComboboxTableViewCell") as! TwiceComboboxTableViewCell
            cell.tfText1.placeholder = "Ngành nghề"
            cell.tfText2.placeholder = "Học vấn"
            return cell
           case .Gender:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwiceComboboxTableViewCell") as! TwiceComboboxTableViewCell
            cell.tfText1.placeholder = "Độ tuổi"
            cell.tfText2.placeholder = "Giới tính"
            return cell
           case .Refferal:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextTableViewCell") as! InputTextTableViewCell
            cell.tfText.placeholder = "Mã giới thiệu"
            return cell
           case .RefferalDefault:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell") as! ContentTableViewCell
            cell.lbText.text = "Nếu bạn chưa có mã giới thiệu thì nhập mã giới thiệu mặc định: Godme 1789"
            return cell
           case .Complete:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
