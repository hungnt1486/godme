//
//  ListHiddenViewController.swift
//  godme
//
//  Created by fcsdev on 3/13/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class ListHiddenViewController: BaseViewController {

    @IBOutlet weak var tbvListHidden: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func setupTableView(){
        self.tbvListHidden.register(UINib(nibName: "MyRelationShipTableViewCell", bundle: nil), forCellReuseIdentifier: "MyRelationShipTableViewCell")

        self.tbvListHidden.delegate = self
        self.tbvListHidden.dataSource = self
        self.tbvListHidden.separatorColor = UIColor.clear
        self.tbvListHidden.separatorInset = UIEdgeInsets.zero
        self.tbvListHidden.estimatedRowHeight = 300
        self.tbvListHidden.rowHeight = UITableView.automaticDimension
    }

}

extension ListHiddenViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRelationShipTableViewCell") as! MyRelationShipTableViewCell
        return cell
    }
    
    
}
