//
//  BasicServiceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/9/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class BasicServiceViewController: BaseViewController {

    @IBOutlet weak var tbvBasicService: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupTableView()
        self.configButtonBack()
    }
    
    func setupUI(){
        self.navigationItem.title = Settings.ShareInstance.translate(key: "basic_service")
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setupTableView(){
        self.tbvBasicService.register(UINib(nibName: "BasicServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "BasicServicesTableViewCell")
        self.tbvBasicService.delegate = self
        self.tbvBasicService.dataSource = self
        self.tbvBasicService.separatorColor = UIColor.clear
        self.tbvBasicService.separatorInset = UIEdgeInsets.zero
        self.tbvBasicService.estimatedRowHeight = 300
        self.tbvBasicService.rowHeight = UITableView.automaticDimension
    }
}

extension BasicServiceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicServicesTableViewCell") as! BasicServicesTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detail = DetailBasicServiceViewController()
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    
}
