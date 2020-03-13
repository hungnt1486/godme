//
//  SearchBarRelationShipViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/12/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class SearchBarRelationShipViewController: BaseViewController {

    @IBOutlet weak var btRelationShip: UIButton!
    @IBOutlet weak var btRelationShipExpand: UIButton!
    @IBOutlet weak var lbFilter: UILabel!
    @IBOutlet weak var tbvRelationShip: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupTableView()
    }
    
    func setupUI(){
        
        self.btRelationShip = Settings.ShareInstance.setupButton(button: self.btRelationShip)
        self.btRelationShipExpand = Settings.ShareInstance.setupButton(button: self.btRelationShipExpand)
    }
    
    func setupTableView(){
        self.tbvRelationShip.register(UINib(nibName: "SearchBarRelationShipTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchBarRelationShipTableViewCell")

        self.tbvRelationShip.delegate = self
        self.tbvRelationShip.dataSource = self
        self.tbvRelationShip.separatorColor = UIColor.clear
        self.tbvRelationShip.separatorInset = UIEdgeInsets.zero
        self.tbvRelationShip.estimatedRowHeight = 300
        self.tbvRelationShip.rowHeight = UITableView.automaticDimension
    }

    @IBAction func touchRelationShipExpand(_ sender: Any) {
    
    }
    
    @IBAction func touchRelationShip(_ sender: Any) {
    
    }
    
}

extension SearchBarRelationShipViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBarRelationShipTableViewCell") as! SearchBarRelationShipTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
