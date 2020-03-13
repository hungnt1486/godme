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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupTableView()
    }
    
    func setupTableView(){
        self.tbvBaseInfo.register(UINib(nibName: "SearchBarBaseInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchBarBaseInfoTableViewCell")
        self.tbvBaseInfo.register(UINib(nibName: "SearchBarBaseInfor2TableViewCell", bundle: nil), forCellReuseIdentifier: "SearchBarBaseInfor2TableViewCell")

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
        if section == 0 {
            return 1
        }
        return 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBarBaseInfoTableViewCell") as! SearchBarBaseInfoTableViewCell
            cell.delegate = self
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBarBaseInfor2TableViewCell") as! SearchBarBaseInfor2TableViewCell
            cell.imgMore.tag = indexPath.row
            cell.delegate = self
            return cell
        }
    }
}

extension SearchBarInfoBaseViewController: SearchBarBaseInfoTableViewCellProtocol{
    func didMoreButton(){
        Settings.ShareInstance.showAlertView(message: "more button", vc: self)
    }
}

extension SearchBarInfoBaseViewController: SearchBarBaseInfor2TableViewCellProtocol{
    func didMore(index: Int) {
        Settings.ShareInstance.showAlertView(message: "more + index = \(index)" , vc: self)
    }
    
    
}
