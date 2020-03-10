//
//  AuctionServiceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/9/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class AuctionServiceViewController: BaseViewController {

    @IBOutlet weak var tbvAuctionService: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupTableView()
        self.configButtonBack()
    }
    
    func setupUI(){
        self.title = "auction_service".localized()
    }
    
    func setupTableView(){
        self.tbvAuctionService.register(UINib(nibName: "AuctionServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "AuctionServicesTableViewCell")
        self.tbvAuctionService.delegate = self
        self.tbvAuctionService.dataSource = self
        self.tbvAuctionService.separatorColor = UIColor.clear
        self.tbvAuctionService.separatorInset = UIEdgeInsets.zero
        self.tbvAuctionService.estimatedRowHeight = 300
        self.tbvAuctionService.rowHeight = UITableView.automaticDimension
    }
}

extension AuctionServiceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuctionServicesTableViewCell") as! AuctionServicesTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detail = DetailAuctionViewController()
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    
}
