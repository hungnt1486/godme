//
//  AccountsViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/5/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import Localize_Swift

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    func setupUI(){
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.title = Settings.ShareInstance.translate(key: "account")
        let left = UIBarButtonItem.init(image: UIImage.init(named: "ic_people_white")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(touchLeft))
        self.navigationItem.leftBarButtonItem = left
    }
    
    @objc func touchLeft(){
        print("left")
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
                cell.delegate = self
            return cell
           case .Services:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureTableViewCell") as! FeatureTableViewCell
                cell.btOne.tag = indexPath.row
                cell.btTwo.tag = indexPath.row
                cell.btOne.setTitle("wallet_finance".localized(), for: .normal)
                cell.btTwo.setTitle("create_services".localized(), for: .normal)
                cell.delegate = self
            return cell
           case .Events:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureTableViewCell") as! FeatureTableViewCell
                cell.btOne.tag = indexPath.row
                cell.btTwo.tag = indexPath.row
                cell.btOne.setTitle("create_auction".localized(), for: .normal)
                cell.btTwo.setTitle("create_event".localized(), for: .normal)
                cell.delegate = self
            return cell
           case .Security:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureTableViewCell") as! FeatureTableViewCell
                cell.btOne.tag = indexPath.row
                cell.btTwo.tag = indexPath.row
                cell.btOne.setTitle("security_term".localized(), for: .normal)
                cell.btTwo.setTitle("use_term".localized(), for: .normal)
                cell.delegate = self
            return cell
           case .Contact:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureTableViewCell") as! FeatureTableViewCell
                cell.btOne.tag = indexPath.row
                cell.btTwo.tag = indexPath.row
                cell.btOne.setTitle("support_report".localized(), for: .normal)
                cell.btTwo.setTitle("contact".localized(), for: .normal)
                cell.delegate = self
            return cell
           case .Signout:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureTableViewCell") as! FeatureTableViewCell
                cell.btOne.tag = indexPath.row
                cell.btTwo.tag = indexPath.row
                cell.btOne.setTitle("collaboration".localized(), for: .normal)
                cell.btTwo.setTitle("logout".localized(), for: .normal)
                cell.delegate = self
            return cell
        }
    }
}

extension AccountsViewController: AvatarTableViewCellProtocol{
    func didImg() {
        
    }
    
    
}

extension AccountsViewController: FeatureTableViewCellProtocol{
    func didOne(type: typeCellAccounts, index: Int) {
        switch type {
        case .Services:
            let finance = FinanceViewController()
            self.navigationController?.pushViewController(finance, animated: true)
            break
        case .Events:
            print("Events")
            break
        case .Security:
            print("Security")
            break
        case .Contact:
            print("Contact")
            break
        case .Signout:
            print("Signout")
            break
        case .Avatar:
            break
        }
    }
    
    func didTwo(type: typeCellAccounts, index: Int) {
        switch type {
        case .Services:
            print("Services 2")
            break
        case .Events:
            print("Events 2")
            break
        case .Security:
            print("Security 2")
            break
        case .Contact:
            print("Contact 2")
            break
        case .Signout:
            print("Signout 2")
            break
        case .Avatar:
            break
        }
    }
    
    
    
    
}
