//
//  AuctionServiceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/9/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class EventsViewController: BaseViewController {

    @IBOutlet weak var tbvEvents: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupTableView()
        self.configButtonBack()
    }
    
    func setupUI(){
        self.title = "events".localized()
    }
    
    func setupTableView(){
        self.tbvEvents.register(UINib(nibName: "EventsTableViewCell", bundle: nil), forCellReuseIdentifier: "EventsTableViewCell")
        self.tbvEvents.delegate = self
        self.tbvEvents.dataSource = self
        self.tbvEvents.separatorColor = UIColor.clear
        self.tbvEvents.separatorInset = UIEdgeInsets.zero
        self.tbvEvents.estimatedRowHeight = 300
        self.tbvEvents.rowHeight = UITableView.automaticDimension
    }
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsTableViewCell") as! EventsTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
