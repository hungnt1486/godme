//
//  MyServicesViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class MyServicesViewController: BaseViewController {

    @IBOutlet weak var tbvMyServices: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupTableView()
    }
    
    func setupTableView(){
        self.tbvMyServices.register(UINib(nibName: "MyServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "MyServicesTableViewCell")

        self.tbvMyServices.delegate = self
        self.tbvMyServices.dataSource = self
        self.tbvMyServices.separatorColor = UIColor.clear
        self.tbvMyServices.separatorInset = UIEdgeInsets.zero
        self.tbvMyServices.estimatedRowHeight = 300
        self.tbvMyServices.rowHeight = UITableView.automaticDimension
    }
}

extension MyServicesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyServicesTableViewCell") as! MyServicesTableViewCell
        return cell
    }
    
    
}
