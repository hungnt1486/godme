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
    func didSearch(_ value: [String: String])
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
    
    var arrayProvince: [String] = []
    var arrayDistrict: [String] = []
    var arrayWard: [String] = []
    
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
        self.arrayDistrict = self.loadDistrict()
        self.arrayWard = self.loadWard()
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
        delegate?.didSearch(["fullName" : self.strFullName ?? "", "gender": self.strGender ?? "", "education": self.strEducation ?? "", "job" : strJob ?? "", "city": strCity ?? "", "district": strDistrict ?? "", "ward": strWard ?? ""])
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
            cell.delegate = self
            return cell
        case .Education:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComboboxTableViewCell") as! ComboboxTableViewCell
            cell.btShow.tag = indexPath.row
            cell.delegate = self
            return cell
        case .Job:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComboboxTableViewCell") as! ComboboxTableViewCell
            cell.btShow.tag = indexPath.row
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
        }
    }
}

extension VSearchMain: InputTextTableViewCellProtocol{
    func getTextInput(_ string: String) {
        self.strFullName = string
    }
}

extension VSearchMain: ComboboxTableViewCellProtocol{
    func didTouchSearchMain(str: String, type: typeCellSearchMain) {
        switch type {
            
        case .InputText:
            break
        case .Gender:
            self.strWard = str
            break
        case .Education:
            self.strWard = str
            break
        case .Job:
            self.strWard = str
            break
        case .City:
            self.strCity = str
            break
        case .District:
            self.strDistrict = str
            break
        case .Ward:
            self.strWard = str
            break
        }
    }
}
