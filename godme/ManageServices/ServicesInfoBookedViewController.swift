//
//  ServicesInfoBookedViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class ServicesInfoBookedViewController: BaseViewController {

    @IBOutlet weak var tbvServicesInfoBook: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupTableView()
    }
    
    func setupTableView(){
        self.tbvServicesInfoBook.register(UINib(nibName: "ServicesInfoBookTableViewCell", bundle: nil), forCellReuseIdentifier: "ServicesInfoBookTableViewCell")
//        self.tbvServicesInfoBook.register(UINib(nibName: "MyServicesJoinTableViewCell", bundle: nil), forCellReuseIdentifier: "MyServicesJoinTableViewCell")
        self.tbvServicesInfoBook.register(UINib.init(nibName: "HeaderServicesInfoBook", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderServicesInfoBook")

        self.tbvServicesInfoBook.delegate = self
        self.tbvServicesInfoBook.dataSource = self
//        self.tbvServicesInfoBook.separatorColor = UIColor.clear
//        self.tbvServicesInfoBook.separatorInset = UIEdgeInsets.zero
        self.tbvServicesInfoBook.estimatedRowHeight = 300
        self.tbvServicesInfoBook.rowHeight = UITableView.automaticDimension
    }
}

extension ServicesInfoBookedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 10
        }else if section == 1 {
            return 5
        }else{
            return 10
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderServicesInfoBook") as! HeaderServicesInfoBook
        if section == 0 {
            header.lbTitle.text = "Dịch vụ cơ bản"
        }else if section == 1 {
            header.lbTitle.text = "Dịch vụ đấu giá"
        }else{
            header.lbTitle.text = "Sự kiện"
        }
        header.backgroundColor = UIColor.FlatColor.Gray.BGColor
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesInfoBookTableViewCell") as! ServicesInfoBookTableViewCell
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesInfoBookTableViewCell") as! ServicesInfoBookTableViewCell
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServicesInfoBookTableViewCell") as! ServicesInfoBookTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
