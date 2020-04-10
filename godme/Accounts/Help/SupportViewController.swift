//
//  SupportViewController.swift
//  godme
//
//  Created by Lê Hùng on 4/10/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class SupportViewController: BaseViewController {

    @IBOutlet weak var tbvSupport: UITableView!
    let arr: [String] = ["Liên hệ", "Thoả thuận sử dụng", "Hỗ trợ/Báo lỗi/Khiếu nại", "Ngôn ngữ"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupTableView()
        self.configButtonBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "support_report")
    }

    func setupTableView(){
        self.tbvSupport.register(UINib(nibName: "HelpTableViewCell", bundle: nil), forCellReuseIdentifier: "HelpTableViewCell")

        self.tbvSupport.delegate = self
        self.tbvSupport.dataSource = self
//        self.tbvHelp.separatorColor = UIColor.clear
//        self.tbvHelp.separatorInset = UIEdgeInsets.zero
        
        self.tbvSupport.rowHeight = UITableView.automaticDimension
        self.tbvSupport.estimatedRowHeight = 300
    }
    
}

extension SupportViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HelpTableViewCell") as! HelpTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.lbTitle.text = arr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            Settings.ShareInstance.openWebsite(link: "\(URLs.linkHostName)/contact")
            break
        case 1:
            Settings.ShareInstance.openWebsite(link: "\(URLs.linkHostName)/term-of-use")
            break
        case 2:
            let help = HelpViewController()
            self.navigationController?.pushViewController(help, animated: true)
            break
        case 3:
            let language = LanguagesViewController()
            self.navigationController?.pushViewController(language, animated: true)
            break
        default:
            break
        }
    }
    
    
}
