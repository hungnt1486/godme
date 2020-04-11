//
//  ContinueMyRelationShipViewController.swift
//  godme
//
//  Created by Lê Hùng on 4/1/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

enum typeCellContinue: Int{
    case Title = 0
    case NumberOfYear = 1
    case Confirm = 2
}

class ContinueMyRelationShipViewController: BaseViewController {

    @IBOutlet weak var tbvContinueMyRelationShip: UITableView!
    var listTypeCell: [typeCellContinue] = [.Title, .NumberOfYear, .Confirm]
    var cellNumber: NumberOfYearTableViewCell!
    var listUser: [UserRegisterReturnModel] = []
    var intYear = 1
    var userId: Int?
    var intRelationShip = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showProgressHub()
        self.configButtonBack()
        self.setupTableView()
        self.getMyRelationShip()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Gia hạn mối quan hệ"
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setupTableView(){
        self.tbvContinueMyRelationShip.register(UINib(nibName: "NumberOfYearTableViewCell", bundle: nil), forCellReuseIdentifier: "NumberOfYearTableViewCell")
        self.tbvContinueMyRelationShip.register(UINib(nibName: "TypeCarTableViewCell", bundle: nil), forCellReuseIdentifier: "TypeCarTableViewCell")
        self.tbvContinueMyRelationShip.register(UINib.init(nibName: "CompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteTableViewCell")

        self.tbvContinueMyRelationShip.delegate = self
        self.tbvContinueMyRelationShip.dataSource = self
        self.tbvContinueMyRelationShip.separatorColor = UIColor.clear
        self.tbvContinueMyRelationShip.separatorInset = UIEdgeInsets.zero
        self.tbvContinueMyRelationShip.estimatedRowHeight = 300
        self.tbvContinueMyRelationShip.rowHeight = UITableView.automaticDimension
    }
    
    func getMyRelationShip(){
        UserManager.shareUserManager().getMyRelationShip(id: userId ?? 0 ) { [unowned self](response) in
            switch response{
                
            case .success(let data):
                self.hideProgressHub()
                self.listUser = data
                self.tbvContinueMyRelationShip.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func createContinueRelation(numberOfExtension: Int, relationshipId: Int){
        RelationShipsManager.shareRelationShipsManager().createContinueRelation(numberOfExtension: numberOfExtension, relationshipId: relationshipId) { [unowned self](response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: "Chúc mừng bạn đã gia hạn thành công", vc: self) { (str) in
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

extension ContinueMyRelationShipViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTypeCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = listTypeCell[indexPath.row]
        switch type {
            
        case .Title:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCarTableViewCell") as! TypeCarTableViewCell
            cell.lbTitle.text = "Tiêu đề"
            cell.lbTypeCar.tag = indexPath.row
            var arr: [String] = []
            for item in self.listUser {
                arr.append(item.fullName ?? "")
                if userId == item.id {
                    cell.lbTypeCar.text = item.fullName
                    intRelationShip = item.id ?? 0
                }
            }
            if intRelationShip == 0 {
                cell.lbTypeCar.text = "NaN"
            }
            if cell.arrString.count == 0 {
                cell.arrString = arr
                cell.setupTypeDropdown()
            }
            cell.delegate = self
            return cell
        case .NumberOfYear:
            cellNumber = tableView.dequeueReusableCell(withIdentifier: "NumberOfYearTableViewCell") as? NumberOfYearTableViewCell
            cellNumber.delegate = self
            return cellNumber
        case .Confirm:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as! CompleteTableViewCell
            cell.delegate = self
            return cell
        }
    }
}

extension ContinueMyRelationShipViewController: NumberOfYearTableViewCellProtocol{
    func didMinus() {
        if intYear > 1 {
            intYear = intYear - 1
            cellNumber.lbNumberOfYearValue.text = String(intYear)
            cellNumber.lbTitleCoinValue.text = String(intYear * 10) + " Godcoin/năm"
        }
    }
    
    func didPlus() {
        intYear = intYear + 1
        cellNumber.lbNumberOfYearValue.text = String(intYear)
        cellNumber.lbTitleCoinValue.text = String(intYear * 10) + " Godcoin/năm"
    }
}

extension ContinueMyRelationShipViewController: CompleteTableViewCellProtocol{
    func didComplete() {
        if self.intRelationShip == 0 {
            Settings.ShareInstance.showAlertView(message: "Vui lòng chọn mối quan hệ để gia hạn.", vc: self)
            return
        }
        self.showProgressHub()
        self.createContinueRelation(numberOfExtension: intYear, relationshipId: self.intRelationShip)
    }
}

extension ContinueMyRelationShipViewController: TypeCarTableViewCellProtocol{
    func eventGetTextEditProfile(_ string: String, type: typeCellEditProfile, index: Int) {
        
    }
    
    func eventGetTextTypeCar(_ string: String, index: Int) {
        let model = self.listUser[index]
        self.intRelationShip = model.id ?? 0
    }
}

