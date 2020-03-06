//
//  AccountsViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/5/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

enum typeCellAccounts: Int {
    case Avatar = 0
    case Services = 1
    case Events  = 2
    case Security = 3
    case Contact = 4
    case Signout = 5
}

class AccountsViewController: BaseViewController {

    @IBOutlet weak var tbvAccounts: UITableView!
    var listTypeCell : [typeCellAccounts] = [.Avatar, .Services, .Events, .Security, .Contact, .Signout]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
    }
    
    func setupTableView(){
        self.tbvAccounts.register(UINib(nibName: "AvatarTableViewCell", bundle: nil), forCellReuseIdentifier: "AvatarTableViewCell")
        self.tbvAccounts.register(UINib(nibName: "FeatureTableViewCell", bundle: nil), forCellReuseIdentifier: "FeatureTableViewCell")

        self.tbvAccounts.delegate = self
        self.tbvAccounts.dataSource = self
        self.tbvAccounts.allowsSelection = false
        self.tbvAccounts.separatorColor = UIColor.clear
        self.tbvAccounts.separatorInset = UIEdgeInsets.zero
    }
}

extension AccountsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let typeCell = listTypeCell[indexPath.row]
           switch typeCell {
            
           case .Avatar:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AvatarTableViewCell") as! AvatarTableViewCell
            return cell
           case .Services:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureTableViewCell") as! FeatureTableViewCell
            return cell
           case .Events:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureTableViewCell") as! FeatureTableViewCell
            return cell
           case .Security:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureTableViewCell") as! FeatureTableViewCell
            return cell
           case .Contact:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureTableViewCell") as! FeatureTableViewCell
            return cell
           case .Signout:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureTableViewCell") as! FeatureTableViewCell
            return cell
        }
    }
    
    
}
