//
//  MyRelationShipViewController.swift
//  godme
//
//  Created by fcsdev on 3/13/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class MyRelationShipViewController: BaseViewController {

    @IBOutlet weak var tbvMyRelationShip: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupTableView()
    }
    
    func setupTableView(){
        self.tbvMyRelationShip.register(UINib(nibName: "MyRelationShipTableViewCell", bundle: nil), forCellReuseIdentifier: "MyRelationShipTableViewCell")

        self.tbvMyRelationShip.delegate = self
        self.tbvMyRelationShip.dataSource = self
        self.tbvMyRelationShip.separatorColor = UIColor.clear
        self.tbvMyRelationShip.separatorInset = UIEdgeInsets.zero
        self.tbvMyRelationShip.estimatedRowHeight = 300
        self.tbvMyRelationShip.rowHeight = UITableView.automaticDimension
    }

}

extension MyRelationShipViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRelationShipTableViewCell") as! MyRelationShipTableViewCell
        return cell
    }
    
    
}
