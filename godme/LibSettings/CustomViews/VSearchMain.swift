//
//  VSearchMain.swift
//  godme
//
//  Created by Lê Hùng on 3/21/20.
//  Copyright © 2020 godme. All rights reserved.
//

import Foundation
import UIKit

protocol VSearchMainProtocol {
    func didSearch(_ value: userSearchParamsModel)
    func didCancel()
}

@objc enum typeCellSearchMain: Int {
    case InputText = 0
    case Gender = 1
    case Education = 2
    case Job = 3
    case City = 4
    case District = 5
    case Ward = 6
}

class VSearchMain: UIView {
    
    @IBOutlet weak var btCancel: UIButton!
    @IBOutlet weak var tbvSearch: UITableView!
    
    var arrayProvince: [[String: String]] = []
    var arrayDistrict: [[String: String]] = []
    var arrayWard: [[String: String]] = []
    var arrayEducation: [[String: String]] = []
    var arrayJobs: [[String: String]] = []
    var arrayGender: [[String: String]] = []
    var arrTemp: [GenderModel] = []
    
    var cellDistrict: ComboboxTableViewCell!
    var cellWard: ComboboxTableViewCell!
    
    var strFullName, strGender, strEducation, strJob, strCity, strDistrict, strWard: String?
    
    var delegate: VSearchMainProtocol?
    var listTypeCell: [typeCellSearchMain] = [.InputText, .Gender, .Education, .Job, .City, .District, .Ward]
    class func instanceFromNib() ->VSearchMain{
        return UINib.init(nibName: "VSearchMain", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! VSearchMain
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI(){
        self.arrayProvince = self.loadProvince()
        self.arrayEducation = self.loadEduction()
        self.arrTemp = Settings.ShareInstance.Gender()
        if  self.arrTemp.count > 0 {
            for item in self.arrTemp {
                self.arrayGender.append(["name":item.Name ?? "", "code": "\(item.Id ?? "")"])
            }
        }
//        self.arrayDistrict = self.loadDistrict()
//        self.arrayWard = self.loadWard()
//        self.arrayEducation = self.loade
    }
    
    func setupTableView(){
        self.tbvSearch.register(UINib(nibName: "InputTextTableViewCell", bundle: nil), forCellReuseIdentifier: "InputTextTableViewCell")
        self.tbvSearch.register(UINib(nibName: "ComboboxTableViewCell", bundle: nil), forCellReuseIdentifier: "ComboboxTableViewCell")

        self.tbvSearch.delegate = self
        self.tbvSearch.dataSource = self
        self.tbvSearch.separatorColor = UIColor.clear
        self.tbvSearch.separatorInset = UIEdgeInsets.zero
        self.tbvSearch.estimatedRowHeight = 300
        self.tbvSearch.rowHeight = UITableView.automaticDimension
    }
    
    func configVSearchMain(frameView: CGRect, index: Int = 1) {
        self.setupUI()
        self.setupTableView()
        self.frame = CGRect(x: 0, y: 0, width: frameView.size.width, height: frameView.size.height)
    }
    @IBAction func touchCancel(_ sender: Any) {
        delegate?.didCancel()
    }
    
    @IBAction func touchSearch(_ sender: Any) {
        let model = userSearchParamsModel()
        model.nationCode = "VN"
        model.keyword = self.strFullName?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        model.fullName = self.strFullName?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        model.gender = self.strGender ?? ""
        model.education = self.strEducation ?? ""
        model.career = self.strJob ?? ""
        model.provinceCode = self.strCity ?? ""
        model.districtCode = self.strDistrict ?? ""
        model.wardCode = self.strWard ?? ""
        delegate?.didSearch(model)
    }
    
//    func loadCountry()->[String]{
//        var arrString: [String] = []
//        let arrCountry = Settings.ShareInstance.loadCountry()
//        if arrCountry.count > 0 {
//            for item in arrCountry {
//                arrString.append(item.name ?? "")
//            }
//        }
//        return arrString
//    }
    
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
}

extension VSearchMain: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = listTypeCell[indexPath.row]
        
        switch type {
            
        case .InputText:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextTableViewCell") as! InputTextTableViewCell
            cell.delegate = self
            return cell
        case .Gender:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComboboxTableViewCell") as! ComboboxTableViewCell
            cell.btShow.tag = indexPath.row
            cell.tfText.placeholder = "Giới tính"
            cell.delegate = self
            if cell.arr.count == 0 {
                cell.arr = self.arrayGender
                cell.setupTypeDropdown()
            }
            return cell
        case .Education:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComboboxTableViewCell") as! ComboboxTableViewCell
            cell.tfText.placeholder = "Học vấn"
            cell.btShow.tag = indexPath.row
            cell.delegate = self
            if cell.arr.count == 0 {
                cell.arr = self.arrayEducation
                cell.setupTypeDropdown()
            }
            return cell
        case .Job:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComboboxTableViewCell") as! ComboboxTableViewCell
            cell.btShow.tag = indexPath.row
            cell.tfText.placeholder = "Nghề nghiệp"
            cell.delegate = self
            if cell.arr.count == 0 {
                cell.arr = self.arrayJobs
                cell.setupTypeDropdown()
            }
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
        }
    }
}

extension VSearchMain: InputTextTableViewCellProtocol{
    func getTextInput(_ string: String) {
        self.strFullName = string
    }
}

extension VSearchMain: ComboboxTableViewCellProtocol{
    func didTouchSearchMain(str: String, type: typeCellSearchMain, index: Int) {
        switch type {
            
        case .InputText:
            break
        case .Gender:
            let code = self.arrayGender[index]["code"]
            self.strGender = code
            break
        case .Education:
            let code = self.arrayEducation[index]["code"]
            self.strEducation = code
            break
        case .Job:
            let code = self.arrayJobs[index]["code"]
            self.strJob = code
            break
        case .City:
            let parentCode = self.arrayProvince[index]["code"]
            self.arrayDistrict = self.loadDistrict(parentCode: parentCode ?? "")
            if self.strCity != parentCode {
                self.strCity = parentCode
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
            self.strJob = code
            break
        }
    }
}
