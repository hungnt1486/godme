//
//  ListGroupRelationShipViewController.swift
//  godme
//
//  Created by Lê Hùng on 4/4/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class ListGroupRelationShipViewController: BaseViewController {

    @IBOutlet weak var tbvListGroupRelationShip: UITableView!
    var listGroupRelationShip: [GroupRelationShipModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.configButtonBack()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "label_group_relationship")
        self.showProgressHub()
        // parent
        self.getListGroupRelationShip()
        self.getListGroup1RelationShip()
    }
    
    func setupUI(){
        let right = UIBarButtonItem.init(image: UIImage.init(named: "ic_plus")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(touchRight))
        self.navigationItem.rightBarButtonItem = right
    }
    
    @objc func touchRight(){
        let createGroup = CreateGroupViewController()
        self.navigationController?.pushViewController(createGroup, animated: true)
    }
    
    func setupTableView(){
        self.tbvListGroupRelationShip.register(UINib(nibName: "ListGroupRelationShipTableViewCell", bundle: nil), forCellReuseIdentifier: "ListGroupRelationShipTableViewCell")

        self.tbvListGroupRelationShip.delegate = self
        self.tbvListGroupRelationShip.dataSource = self
        self.tbvListGroupRelationShip.separatorColor = UIColor.clear
        self.tbvListGroupRelationShip.separatorInset = UIEdgeInsets.zero
        self.tbvListGroupRelationShip.estimatedRowHeight = 300
        self.tbvListGroupRelationShip.rowHeight = UITableView.automaticDimension
    }
    
    func getListGroup1RelationShip(){
        RelationShipsManager.shareRelationShipsManager().getListGroupRelationShip(sorts: [["field":"createdOn", "order": "desc"]]) { [unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                self.listGroupRelationShip.removeAll()
                for model in data {
                    self.listGroupRelationShip.append(model)
                }
                self.tbvListGroupRelationShip.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func deleteGroupRelationShip(index: Int){
        let model = self.listGroupRelationShip[index]
        RelationShipsManager.shareRelationShipsManager().deleteGroupRelationShip(id: model.id ?? 0) { (response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: Settings.ShareInstance.translate(key: "warning_delete_relationship_group_successful"), vc: self) {[unowned self] (str) in
                    self.getListGroupRelationShip()
                    self.listGroupRelationShip.remove(at: index)
                    self.tbvListGroupRelationShip.reloadData()
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

extension ListGroupRelationShipViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listGroupRelationShip.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListGroupRelationShipTableViewCell") as! ListGroupRelationShipTableViewCell
        let model = self.listGroupRelationShip[indexPath.row]
        cell.lbTitle.text = model.name
        cell.btEdit.tag = indexPath.row
        cell.btDelete.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListGroupRelationShipViewController: ListGroupRelationShipTableViewCellProtocol{
    func didEdit(_ index: Int) {
        let model = self.listGroupRelationShip[index]
        let edit = EditGroupViewController()
        edit.idGroup = model.id ?? 0
        self.navigationController?.pushViewController(edit, animated: true)
    }
    
    func didDelete(_ index: Int) {
        let model = self.listGroupRelationShip[index]
        Settings.ShareInstance.showAlertViewWithOkCancel(message: String.init(format: Settings.ShareInstance.translate(key: "warning_delete_relationship_group"), model.name ?? ""), vc: self) {[unowned self] (str) in
            self.showProgressHub()
            self.deleteGroupRelationShip(index: index)
        }
    }
    
    
}
