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
    var listLanguages:[[String: String]] = [["language": "\(Settings.ShareInstance.translate(key: "vietnamese"))", "code" : "vi"], ["language": "\(Settings.ShareInstance.translate(key: "english"))", "code" : "en"]]
    let currentLanguage = Settings.ShareInstance.getCurrentLanguage()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupTableView()
        self.configButtonBack()
    }
    
    func setupUI(){
        self.navigationItem.title = Settings.ShareInstance.translate(key: "languages")
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
        let model = listLanguages[indexPath.row]
        cell.lbTitle.text = model["language"]
        cell.accessoryType = .none
        if currentLanguage == model["code"] {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = listLanguages[indexPath.row]
        if currentLanguage != model["code"] {
            Settings.ShareInstance.showAlertViewWithOkCancel(message: Settings.ShareInstance.translate(key: "label_change_language"), vc: self) {[unowned self] (str) in
                let model = self.listLanguages[indexPath.row]
                
                UserDefaults.standard.setValue(model["code"], forKey: info_language)
                UserDefaults.standard.synchronize()
                print("language = \(Settings.ShareInstance.getCurrentLanguage())")
                self.configToken()
                self.getListJobsMain()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
