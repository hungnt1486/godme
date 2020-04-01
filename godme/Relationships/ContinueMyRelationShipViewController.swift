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
    var detailModel: UserRegisterReturnModel?
    var intYear = 1
    var userId: Int?
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
        self.tbvContinueMyRelationShip.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
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
                self.detailModel = data[0]
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
            cell.tfInput.isUserInteractionEnabled = false
            cell.tfInput.text = detailModel?.fullName
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
            cellNumber.lbTitleCoinValue.text = String(intYear * 10) + "Godcoin/năm"
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
        self.showProgressHub()
        self.createContinueRelation(numberOfExtension: intYear, relationshipId: detailModel?.id ?? 0)
    }
}

