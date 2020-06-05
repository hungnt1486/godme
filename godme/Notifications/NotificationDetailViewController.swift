//
//  NotificationDetailViewController.swift
//  godme
//
//  Created by Lê Hùng on 6/5/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class NotificationDetailViewController: BaseViewController {
    @IBOutlet weak var tbvNotificationDetail: UITableView!
    var detail: NotificationModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = Settings.ShareInstance.translate(key: detail?.title ?? "")
        self.configButtonBack()
        self.setupTableView()
    }
    
    func setupTableView(){
        self.tbvNotificationDetail.register(UINib(nibName: "NotificationDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationDetailTableViewCell")

        self.tbvNotificationDetail.delegate = self
        self.tbvNotificationDetail.dataSource = self
        self.tbvNotificationDetail.separatorColor = UIColor.clear
        self.tbvNotificationDetail.separatorInset = UIEdgeInsets.zero
        self.tbvNotificationDetail.estimatedRowHeight = 300
        self.tbvNotificationDetail.rowHeight = UITableView.automaticDimension
        self.tbvNotificationDetail.reloadData()
    }

}

extension NotificationDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationDetailTableViewCell") as! NotificationDetailTableViewCell
        cell.lbTitle.text = detail?.title
        cell.lbContent.text = detail?.description
        cell.lbName.text = detail?.createdBy
        cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: detail?.createdOn ?? 0.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
