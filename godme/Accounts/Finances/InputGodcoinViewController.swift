//
//  InputGodcoinViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

enum cellTypeInputGodcoid: Int{
    case Label1 = 0
    case Label2 = 1
    case Label3 = 2
}

class InputGodcoinViewController: BaseViewController {

    @IBOutlet weak var tbvInputGodcoin: UITableView!
    var listTypeCell:[cellTypeInputGodcoid] = [.Label1, .Label2, .Label3]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupTableView()
        self.configButtonBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "input_godcoin")
    }
    
    func setupTableView(){
        self.tbvInputGodcoin.register(UINib(nibName: "InputGodcoinLabel1TableViewCell", bundle: nil), forCellReuseIdentifier: "InputGodcoinLabel1TableViewCell")
        self.tbvInputGodcoin.register(UINib(nibName: "InputGodcoinLabel2TableViewCell", bundle: nil), forCellReuseIdentifier: "InputGodcoinLabel2TableViewCell")
        self.tbvInputGodcoin.register(UINib(nibName: "InputGodcoinLabel3TableViewCell", bundle: nil), forCellReuseIdentifier: "InputGodcoinLabel3TableViewCell")

        self.tbvInputGodcoin.delegate = self
        self.tbvInputGodcoin.dataSource = self
        self.tbvInputGodcoin.allowsSelection = false
        self.tbvInputGodcoin.separatorColor = UIColor.clear
        self.tbvInputGodcoin.separatorInset = UIEdgeInsets.zero
        self.tbvInputGodcoin.estimatedRowHeight = 100
        self.tbvInputGodcoin.rowHeight = UITableView.automaticDimension
    }

}

extension InputGodcoinViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let typeCell = listTypeCell[indexPath.row]
        switch typeCell {
        case .Label1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputGodcoinLabel1TableViewCell") as! InputGodcoinLabel1TableViewCell
            return cell
        
        case .Label2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputGodcoinLabel2TableViewCell") as! InputGodcoinLabel2TableViewCell
            return cell
        case .Label3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputGodcoinLabel3TableViewCell") as! InputGodcoinLabel3TableViewCell
            return cell
        }
    }
    
    
}
