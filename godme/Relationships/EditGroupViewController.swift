//
//  EditGroupViewController.swift
//  godme
//
//  Created by Lê Hùng on 4/4/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit


class EditGroupViewController: BaseViewController {

    @IBOutlet weak var tbvEditGroup: UITableView!
    var listGroupRelationShip: [GroupRelationShipModel] = []
    var idGroup: Int = 0
    var strName: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showProgressHub()
        self.setupUI()
        self.configButtonBack()
        self.setupTableView()
        self.getDetailGroupRelationShip()
    }
    
    func setupUI(){
        self.navigationItem.title = "Cập nhật nhóm mối quan hệ"
    }
    
    func setupTableView(){
        self.tbvEditGroup.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        self.tbvEditGroup.register(UINib(nibName: "CompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteTableViewCell")
        self.tbvEditGroup.register(UINib(nibName: "ListGroupRelationShipTableViewCell", bundle: nil), forCellReuseIdentifier: "ListGroupRelationShipTableViewCell")
        self.tbvEditGroup.register(UINib(nibName: "DefaultTableViewCell", bundle: nil), forCellReuseIdentifier: "DefaultTableViewCell")
        self.tbvEditGroup.register(UINib.init(nibName: "HeaderSubMain", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderSubMain")

        self.tbvEditGroup.delegate = self
        self.tbvEditGroup.dataSource = self
        self.tbvEditGroup.separatorColor = UIColor.clear
        self.tbvEditGroup.separatorInset = UIEdgeInsets.zero
        self.tbvEditGroup.estimatedRowHeight = 300
        self.tbvEditGroup.rowHeight = UITableView.automaticDimension
    }
    
    func getDetailGroupRelationShip(){
        RelationShipsManager.shareRelationShipsManager().getDetailGroupRelationShip(id: idGroup, sorts: [["field":"createdOn", "order": "desc"]]) { [unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listGroupRelationShip.append(model)
                }
                self.tbvEditGroup.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func updateGroupRelationShip() {
        var userIds: String = ""
        if self.listGroupRelationShip[0].listUserInfo!.count > 0 {
            for item in self.listGroupRelationShip[0].listUserInfo! {
                if userIds.count == 0 {
                    userIds = "\(item.id ?? 0)"
                }else {
                    userIds = "\(userIds),\(item.id ?? 0)"
                }
            }
        }
        RelationShipsManager.shareRelationShipsManager().updateGroupRelationShip(id: idGroup, name: strName, userIds: userIds) {[unowned self] (response) in
            switch response{
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: "Bạn đã cập nhật nhóm thành công", vc: self) { [unowned self] (str) in
                    self.navigationController?.popViewController(animated: true)
                }
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
}
extension EditGroupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return listGroupRelationShip.count
        }else if section == 1 {
            if listGroupRelationShip.count > 0 {
                let model = listGroupRelationShip[0]
                if let list = model.listUserInfo, list.count > 0 {
                    return list.count
                }
            }
            return 1
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderSubMain") as! HeaderSubMain
            header.backgroundColor = UIColor.FlatColor.Gray.BGColor
            header.btMore.isHidden = true
            header.lbTitle.text = "Mối quan hệ"
            return header
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let model = self.listGroupRelationShip[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.delegate = self
            cell.lbTitle.font = UIFont(name: "Roboto-Medium", size: 15.0)!
            cell.lbTitle.text = "Tên nhóm"
            cell.tfInput.text = model.name ?? ""
            self.strName = model.name ?? ""
            return cell
        } else if indexPath.section == 1 {
            if self.listGroupRelationShip.count > 0 {
                let model = self.listGroupRelationShip[0].listUserInfo
                if model?.count == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultTableViewCell") as! DefaultTableViewCell
                    cell.lbTitle.text = "Bạn chưa có mối quan hệ nào"
                    return cell
                }else {
                    let model = self.listGroupRelationShip[0].listUserInfo?[indexPath.row]
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ListGroupRelationShipTableViewCell") as! ListGroupRelationShipTableViewCell
                    cell.lbTitle.text = model?.fullName
                    cell.btEdit.isHidden = true
                    cell.btDelete.tag = indexPath.row
                    cell.delegate = self
                    return cell
                }
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultTableViewCell") as! DefaultTableViewCell
                cell.lbTitle.text = "Bạn chưa có mối quan hệ nào"
                return cell
            }
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
            cell.delegate = self
            cell.btComplete.setTitle("Xác nhận", for: .normal)
            return cell
        }
    }
}

extension EditGroupViewController: TitleTableViewCellProtocol{
    func getTextTitle(_ str: String) {
        self.strName = str
    }
}

extension EditGroupViewController: CompleteTableViewCellProtocol{
    func didComplete() {
        self.showProgressHub()
        self.updateGroupRelationShip()
    }
}

extension EditGroupViewController: ListGroupRelationShipTableViewCellProtocol{
    func didEdit(_ index: Int) {
        
    }
    
    func didDelete(_ index: Int) {
        self.listGroupRelationShip[0].listUserInfo?.remove(at: index)
        self.tbvEditGroup.reloadData()
    }
}
