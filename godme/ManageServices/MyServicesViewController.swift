//
//  MyServicesViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class MyServicesViewController: BaseViewController {

    @IBOutlet weak var tbvMyServices: CollapseTableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupTableView()
        
        self.tbvMyServices.didTapSectionHeaderView = { (sectionIndex, isOpen) in
            debugPrint("sectionIndex \(sectionIndex), isOpen \(isOpen)")
        }
        reloadTableView { [unowned self] in
            self.tbvMyServices.openSection(0, animated: true)
        }
    }
    
    func setupTableView(){
//        self.tbvMyServices.register(UINib(nibName: "MyServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "MyServicesTableViewCell")
//        self.tbvMyServices.register(UINib(nibName: "MyServicesJoinTableViewCell", bundle: nil), forCellReuseIdentifier: "MyServicesJoinTableViewCell")
//        self.tbvMyServices.register(UINib.init(nibName: "HeaderMyServices", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderMyServices")
        
        self.tbvMyServices.register(UINib(nibName: "BasicServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "BasicServicesTableViewCell")
        self.tbvMyServices.register(UINib(nibName: "AuctionServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "AuctionServicesTableViewCell")
        self.tbvMyServices.register(UINib(nibName: "EventsTableViewCell", bundle: nil), forCellReuseIdentifier: "EventsTableViewCell")
        

        self.tbvMyServices.delegate = self
        self.tbvMyServices.dataSource = self
        self.tbvMyServices.separatorColor = UIColor.clear
        self.tbvMyServices.separatorInset = UIEdgeInsets.zero
        self.tbvMyServices.estimatedRowHeight = 300
        self.tbvMyServices.rowHeight = UITableView.automaticDimension
        
        self.tbvMyServices.tableFooterView = UIView(frame: .zero)
        self.tbvMyServices.register(UINib.init(nibName: "SectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
    }
    
    func reloadTableView(_ completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            completion()
        })
        self.tbvMyServices.reloadData()
        CATransaction.commit()
    }
}

extension MyServicesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 10
        }
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == 0{
//            return UIView()
//        }else{
//            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderMyServices") as! HeaderMyServices
//            header.backgroundColor = UIColor.FlatColor.Gray.BGColor
//            return header
//        }
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderView") as! SectionHeaderView
        if section == 0 {
            view.lbTitle.text = "Dịch vụ cơ bản"
        }else if section == 1 {
            view.lbTitle.text = "Đấu giá dịch vụ"
        }else{
            view.lbTitle.text = "Sự kiện"
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicServicesTableViewCell") as! BasicServicesTableViewCell
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AuctionServicesTableViewCell") as! AuctionServicesTableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventsTableViewCell") as! EventsTableViewCell
            return cell
        }
        
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MyServicesTableViewCell") as! MyServicesTableViewCell
//            return cell
//        }else{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MyServicesJoinTableViewCell") as! MyServicesJoinTableViewCell
//            return cell
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
