//
//  CreateGroupViewController.swift
//  godme
//
//  Created by Lê Hùng on 4/4/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

enum typeCellCreateGroup: Int {
    case Title = 0
    case Confirm = 1
}

class CreateGroupViewController: BaseViewController {

    @IBOutlet weak var tbvCreateGroup: UITableView!
    var listTypeCell: [typeCellCreateGroup] = [.Title, .Confirm]
    var str: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.configButtonBack()
        self.setupTableView()
    }
    
    func setupUI(){
        self.navigationItem.title = "Tạo nhóm mối quan hệ"
    }
    
    func setupTableView(){
        self.tbvCreateGroup.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        self.tbvCreateGroup.register(UINib(nibName: "CompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteTableViewCell")

        self.tbvCreateGroup.delegate = self
        self.tbvCreateGroup.dataSource = self
        self.tbvCreateGroup.separatorColor = UIColor.clear
        self.tbvCreateGroup.separatorInset = UIEdgeInsets.zero
        self.tbvCreateGroup.estimatedRowHeight = 300
        self.tbvCreateGroup.rowHeight = UITableView.automaticDimension
    }
    
    func addNewGroupRelationShip(name: String){
        RelationShipsManager.shareRelationShipsManager().addNewGroupRelationShip(name: name) { [unowned self](response) in
            switch response {
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: "Chúc mừng đã tạo nhóm thành công", vc: self) {[unowned self] (str) in
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

extension CreateGroupViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = listTypeCell[indexPath.row]
        switch type {
            
        case .Title:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.lbTitle.text = "Tên nhóm"
            cell.tfInput.placeholder = "Nhập tên nhóm"
            cell.delegate = self
            return cell
        case .Confirm:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
            cell.delegate = self
            return cell
        }
    }
}

extension CreateGroupViewController: TitleTableViewCellProtocol{
    func getText(_ str: String) {
        self.str = str.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension CreateGroupViewController: CompleteTableViewCellProtocol{
    func didComplete() {
        self.showProgressHub()
        self.addNewGroupRelationShip(name: self.str ?? "")
    }
}
