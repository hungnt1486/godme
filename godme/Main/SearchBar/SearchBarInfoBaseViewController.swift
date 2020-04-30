//
//  SearchBarInfoBaseViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/12/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class SearchBarInfoBaseViewController: BaseViewController {

    @IBOutlet weak var tbvBaseInfo: UITableView!
    var modelDetail: UserRegisterReturnModel?
    var arrayEducation: [[String: String]] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.arrayEducation = self.loadEduction()
        self.setupTableView()
    }
    
    func setupTableView(){
        self.tbvBaseInfo.register(UINib(nibName: "SearchBarBaseInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchBarBaseInfoTableViewCell")
//        self.tbvBaseInfo.register(UINib(nibName: "SearchBarBaseInfor2TableViewCell", bundle: nil), forCellReuseIdentifier: "SearchBarBaseInfor2TableViewCell")

        self.tbvBaseInfo.delegate = self
        self.tbvBaseInfo.dataSource = self
//        self.tbvBaseInfo.separatorColor = UIColor.clear
//        self.tbvBaseInfo.separatorInset = UIEdgeInsets.zero
        self.tbvBaseInfo.estimatedRowHeight = 300
        self.tbvBaseInfo.rowHeight = UITableView.automaticDimension
    }
    
    func loadEduction() ->[[String: String]]{
        var arrString: [[String: String]] = []
        let arrCountry = Settings.ShareInstance.loadEducation()
        if arrCountry.count > 0 {
            for item in arrCountry {
                arrString.append(["name":Settings.ShareInstance.translate(key: item.label ?? ""), "code": "\(item.code ?? "")"])
            }
        }
        return arrString
    }

}

extension SearchBarInfoBaseViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
//        if section == 0 {
//            return 1
//        }
//        return 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBarBaseInfoTableViewCell") as! SearchBarBaseInfoTableViewCell
        cell.lbGender.text = "\(Settings.ShareInstance.translate(key: "label_gender")): \(self.modelDetail?.gender == "NAM" ? Settings.ShareInstance.translate(key:"label_male") : Settings.ShareInstance.translate(key: "label_female"))"
        cell.lbDOB.text = "\(Settings.ShareInstance.translate(key: "label_dob")): \(Settings.ShareInstance.convertDOB(str: self.modelDetail?.dob ?? ""))"
        let career = self.modelDetail?.career
        let arrCareer = career?.split(separator: ",")
        var strCareer = ""
        for item in arrCareer! {
            for item1 in BaseViewController.arrayJobs {
                if Int(item) == Int(item1["code"] ?? "0") {
                    if strCareer.count == 0 {
                        strCareer = strCareer + item1["name"]!
                    }else {
                        strCareer = strCareer + ", " + item1["name"]!
                    }
                    break
                }
            }
        }
        for item in self.arrayEducation {
            if item["code"] == self.modelDetail?.education {
                cell.lbEducation.text = "\(Settings.ShareInstance.translate(key: "label_learning")): \(item["name"] ?? "")"
                break
            }
        }
        cell.lbJob.text = "\(Settings.ShareInstance.translate(key: "label_career")): \(strCareer)"
        cell.lbEmail.text = "\(Settings.ShareInstance.translate(key: "label_email")): \(self.modelDetail?.email ?? "")"
        cell.lbContentShowInfo.text = self.modelDetail?.userInfo
        cell.lbContentExperience.text = self.modelDetail?.experience
        cell.lbPosition.text = "\(Settings.ShareInstance.translate(key: "label_position_job")): \(self.modelDetail?.position ?? "")"
        cell.lbAddress.text = "\(Settings.ShareInstance.translate(key: "label_address")): \(self.modelDetail?.address ?? "")"
        cell.lbPhone.text = "\(Settings.ShareInstance.translate(key: "label_phone")): \(self.modelDetail?.phoneNumber ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
