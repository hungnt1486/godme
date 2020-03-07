//
//  FollowTableViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class FollowTableViewController: BaseViewController {

    @IBOutlet weak var tbvFollow: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "follow_table".localized()
    }
    
    func setupTableView(){
        self.tbvFollow.register(UINib(nibName: "FollowTableViewCell", bundle: nil), forCellReuseIdentifier: "FollowTableViewCell")
        self.tbvFollow.register(UINib(nibName: "FollowMonthTableViewCell", bundle: nil), forCellReuseIdentifier: "FollowMonthTableViewCell")
        self.tbvFollow.separatorColor = UIColor.clear
        self.tbvFollow.separatorInset = UIEdgeInsets.zero
        self.tbvFollow.delegate = self
        self.tbvFollow.dataSource = self
        self.tbvFollow.estimatedRowHeight = 100
        self.tbvFollow.rowHeight = UITableView.automaticDimension
    }
}

extension FollowTableViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }else {
            return 30
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FollowTableViewCell") as! FollowTableViewCell
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FollowMonthTableViewCell") as! FollowMonthTableViewCell
            return cell
        }
    }
    
    
}
