//
//  HistoryViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class HistoryViewController: BaseViewController {

    @IBOutlet weak var tbvHistory: UITableView!
    @IBOutlet weak var btFromDate: UIButton!
    @IBOutlet weak var btToDate: UIButton!
    @IBOutlet weak var vFromDate: UIView!
    @IBOutlet weak var vToDate: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.setupUI()
        }
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "find_history".localized()
    }
    
    func setupUI(){
        self.btFromDate = Settings.ShareInstance.setupButton(button: self.btFromDate)
        self.btToDate = Settings.ShareInstance.setupButton(button: self.btToDate)
        self.vFromDate = Settings.ShareInstance.setupBTV(v: self.vFromDate)
        self.vToDate = Settings.ShareInstance.setupBTV(v: self.vToDate)
    }
    
    func setupTableView(){
        self.tbvHistory.register(UINib(nibName: "HistoryLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryLabelTableViewCell")

        self.tbvHistory.delegate = self
        self.tbvHistory.dataSource = self
//        self.tbvHistory.allowsSelection = false
        self.tbvHistory.estimatedRowHeight = 100
        self.tbvHistory.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func touchFromDate(_ sender: Any) {
        
    }
    
    @IBAction func touchToDate(_ sender: Any) {
        
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryLabelTableViewCell") as! HistoryLabelTableViewCell
        return cell
    }
    
    
}
