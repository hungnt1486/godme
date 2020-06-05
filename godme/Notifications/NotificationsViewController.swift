//
//  NotificationsViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/15/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class NotificationsViewController: BaseViewController {
    @IBOutlet weak var tbvNotifications: UITableView!
    
    var listNotification: [NotificationModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configButtonBack()
        self.showProgressHub()
        self.setupTableView()
        self.getListNotification()

    }
    
    func setupTableView(){
        self.tbvNotifications.register(UINib(nibName: "InputGodcoinLabel2TableViewCell", bundle: nil), forCellReuseIdentifier: "InputGodcoinLabel2TableViewCell")

        self.tbvNotifications.delegate = self
        self.tbvNotifications.dataSource = self
        self.tbvNotifications.separatorColor = UIColor.clear
        self.tbvNotifications.separatorInset = UIEdgeInsets.zero
        self.tbvNotifications.estimatedRowHeight = 300
        self.tbvNotifications.rowHeight = UITableView.automaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "notification")
    }
    
    func getListNotification(){
        UserManager.shareUserManager().getListNotification { [unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listNotification.append(model)
                }
                self.tbvNotifications.reloadData()
                break
            case .failure(message: let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
}

extension NotificationsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InputGodcoinLabel2TableViewCell") as! InputGodcoinLabel2TableViewCell
        let detail = listNotification[indexPath.row]
        cell.lbTitle.text = detail.title ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detail = listNotification[indexPath.row]
        let notificationsDetail = NotificationDetailViewController()
        notificationsDetail.detail = detail
        self.navigationController?.pushViewController(notificationsDetail, animated: true)
    }
    
    
}
