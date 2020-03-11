//
//  ConfirmBasicServiceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/10/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

enum typeCellConfirm: Int {
    case Basic = 0
    case ConfirmContent = 1
    case ConfirmButton = 2
}

class ConfirmBasicServiceViewController: BaseViewController {

    @IBOutlet weak var tbvConfirmBasicService: UITableView!
    let listTypeCell:[typeCellConfirm] = [.Basic, .ConfirmContent, .ConfirmButton]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configButtonBack()
        self.setupTableView()
    }
    
    func setupTableView(){
           self.tbvConfirmBasicService.register(UINib(nibName: "BasicServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "BasicServicesTableViewCell")
           self.tbvConfirmBasicService.register(UINib(nibName: "ConfirmBasicServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "ConfirmBasicServiceTableViewCell")
           self.tbvConfirmBasicService.register(UINib(nibName: "BookServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "BookServiceTableViewCell")

           self.tbvConfirmBasicService.delegate = self
           self.tbvConfirmBasicService.dataSource = self
           self.tbvConfirmBasicService.separatorColor = UIColor.clear
           self.tbvConfirmBasicService.separatorInset = UIEdgeInsets.zero
           self.tbvConfirmBasicService.estimatedRowHeight = 300
           self.tbvConfirmBasicService.rowHeight = UITableView.automaticDimension
       }
}

extension ConfirmBasicServiceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let typeCell = listTypeCell[indexPath.row]
        
        switch typeCell {
            
        case .Basic:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicServicesTableViewCell") as! BasicServicesTableViewCell
            return cell
        case .ConfirmContent:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ConfirmBasicServiceTableViewCell") as! ConfirmBasicServiceTableViewCell
            return cell
        case .ConfirmButton:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookServiceTableViewCell") as! BookServiceTableViewCell
            cell.btBookService.setTitle("Xác nhận đặt dịch vụ", for: .normal)
            cell.delegate = self
            return cell
        }
    }
}

extension ConfirmBasicServiceViewController: BookServiceTableViewCellProtocol{
    func didBookService() {
        Settings.ShareInstance.showAlertViewWithOkCancel(message: "Bạn có chắc chắn đặt dịch vụ?", vc: self) { (str) in
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
}
