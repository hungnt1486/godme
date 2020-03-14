//
//  ServicesInfoBookedViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class ServicesInfoBookedViewController: BaseViewController {

    @IBOutlet weak var tbvServicesInfoBook: CollapseTableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupTableView()
        
        self.tbvServicesInfoBook.didTapSectionHeaderView = { (sectionIndex, isOpen) in
            debugPrint("sectionIndex \(sectionIndex), isOpen \(isOpen)")
        }
        reloadTableView { [unowned self] in
            self.tbvServicesInfoBook.openSection(0, animated: true)
        }
    }
    
    func setupTableView(){
        self.tbvServicesInfoBook.register(UINib(nibName: "ServicesInfoBookTableViewCell", bundle: nil), forCellReuseIdentifier: "ServicesInfoBookTableViewCell")
        
//        self.tbvServicesInfoBook.register(UINib(nibName: "BasicServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "BasicServicesTableViewCell")
//        self.tbvServicesInfoBook.register(UINib(nibName: "AuctionServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "AuctionServicesTableViewCell")
//        self.tbvServicesInfoBook.register(UINib(nibName: "EventsTableViewCell", bundle: nil), forCellReuseIdentifier: "EventsTableViewCell")

        self.tbvServicesInfoBook.delegate = self
        self.tbvServicesInfoBook.dataSource = self
        self.tbvServicesInfoBook.separatorColor = UIColor.clear
        self.tbvServicesInfoBook.separatorInset = UIEdgeInsets.zero
        self.tbvServicesInfoBook.estimatedRowHeight = 300
        self.tbvServicesInfoBook.rowHeight = UITableView.automaticDimension
        
        self.tbvServicesInfoBook.tableFooterView = UIView(frame: .zero)
        self.tbvServicesInfoBook.register(UINib.init(nibName: "SectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
    }
    
    func reloadTableView(_ completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            completion()
        })
        self.tbvServicesInfoBook.reloadData()
        CATransaction.commit()
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
        
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicServicesTableViewCell") as! BasicServicesTableViewCell
//            return cell
//        }else if indexPath.section == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AuctionServicesTableViewCell") as! AuctionServicesTableViewCell
//            return cell
//        }else{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "EventsTableViewCell") as! EventsTableViewCell
//            return cell
//        }
        
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
