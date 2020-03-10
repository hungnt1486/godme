//
//  DetailBasicServiceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/9/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

enum typeCellDetailBasic: Int {
    case Avatar = 0
    case Address = 1
    case Detail = 2
    case Book = 3
}

class DetailBasicServiceViewController: BaseViewController {

    @IBOutlet weak var tbvDetailBasicService: UITableView!
    var listTypeCell: [typeCellDetailBasic] = [.Avatar, .Address, .Detail, .Book]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupTableView()
        self.configButtonBack()
    }
    
    func setupUI(){
        
    }
    
    func setupTableView(){
        self.tbvDetailBasicService.register(UINib(nibName: "ImageDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageDetailTableViewCell")
        self.tbvDetailBasicService.register(UINib(nibName: "TimeAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "TimeAddressTableViewCell")
        self.tbvDetailBasicService.register(UINib(nibName: "InfoDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoDetailTableViewCell")
        self.tbvDetailBasicService.register(UINib(nibName: "BookServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "BookServiceTableViewCell")
        self.tbvDetailBasicService.delegate = self
        self.tbvDetailBasicService.dataSource = self
        self.tbvDetailBasicService.separatorColor = UIColor.clear
        self.tbvDetailBasicService.separatorInset = UIEdgeInsets.zero
        self.tbvDetailBasicService.estimatedRowHeight = 300
        self.tbvDetailBasicService.rowHeight = UITableView.automaticDimension
    }
}

extension DetailBasicServiceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let typeCell = listTypeCell[indexPath.row]
        
        switch typeCell {
            
        case .Avatar:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageDetailTableViewCell") as! ImageDetailTableViewCell
            cell.arrImageBanner = ["ic_logo"]
            cell.delegate = self
            if cell.arrImageBanner.count > 0 {
                cell.crollViewImage()
                cell.configCrollView()
            }
            return cell
        case .Address:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeAddressTableViewCell") as! TimeAddressTableViewCell
            return cell
        case .Detail:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoDetailTableViewCell") as! InfoDetailTableViewCell
            return cell
        case .Book:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookServiceTableViewCell") as! BookServiceTableViewCell
            cell.delegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension DetailBasicServiceViewController: BookServiceTableViewCellProtocol{
    func didBookService() {
        let confirm = ConfirmBasicServiceViewController()
        self.navigationController?.pushViewController(confirm, animated: true)
    }
}

extension DetailBasicServiceViewController: ImageDetailTableViewCellProtocol{
    func didShowMore() {
        let alertControl = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let action2 = UIAlertAction.init(title: "Tạo dịch vụ của bạn", style: .default) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        let action3 = UIAlertAction.init(title: "Báo xấu", style: .default) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction.init(title: "Huỷ", style: .cancel) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        
        alertControl.addAction(action2)
        alertControl.addAction(action3)
        alertControl.addAction(actionCancel)
        self.navigationController?.present(alertControl, animated: true, completion: nil)
    }
}
