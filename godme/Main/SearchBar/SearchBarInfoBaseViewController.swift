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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        cell.lbGender.text = "Giới tính: \(self.modelDetail?.gender == "NAM" ? "Nam" : "Nữ")"
        cell.lbDOB.text = "Ngày sinh: \(Settings.ShareInstance.convertDOB(str: self.modelDetail?.dob ?? ""))"
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
        cell.lbJob.text = "Ngành nghề: \(strCareer)"
        cell.lbEmail.text = "Email: \(self.modelDetail?.email ?? "")"
        cell.lbContentShowInfo.text = self.modelDetail?.userInfo
        cell.lbContentExperience.text = self.modelDetail?.experience
        cell.lbPosition.text = "Chức vụ: \(self.modelDetail?.position ?? "")"
        cell.lbAddress.text = "Địa chỉ: \(self.modelDetail?.address ?? "")"
        cell.lbPhone.text = "Số điện thoại: \(self.modelDetail?.phoneNumber ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
