//
//  LanguagesViewController.swift
//  godme
//
//  Created by Lê Hùng on 4/10/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class LanguagesViewController: BaseViewController {

    @IBOutlet weak var tbvLanguages: UITableView!
    var listLanguages:[String] = ["\(Settings.ShareInstance.translate(key: "vietnamese"))", "\(Settings.ShareInstance.translate(key: "english"))"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupTableView()
        self.configButtonBack()
    }
    
    func setupTableView(){
        self.tbvLanguages.register(UINib(nibName: "HelpTableViewCell", bundle: nil), forCellReuseIdentifier: "HelpTableViewCell")

        self.tbvLanguages.delegate = self
        self.tbvLanguages.dataSource = self
//        self.tbvHelp.separatorColor = UIColor.clear
//        self.tbvHelp.separatorInset = UIEdgeInsets.zero
        
        self.tbvLanguages.rowHeight = UITableView.automaticDimension
        self.tbvLanguages.estimatedRowHeight = 300
    }

}

extension LanguagesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listLanguages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HelpTableViewCell") as! HelpTableViewCell
        cell.lbTitle.text = listLanguages[indexPath.row]
        cell.accessoryType = .checkmark
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
