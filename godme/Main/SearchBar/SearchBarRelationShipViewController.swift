//
//  SearchBarRelationShipViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/12/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class SearchBarRelationShipViewController: BaseViewController {

    @IBOutlet weak var btRelationShip: UIButton!
    @IBOutlet weak var btRelationShipExpand: UIButton!
    @IBOutlet weak var lbFilter: UILabel!
    @IBOutlet weak var tbvRelationShip: UITableView!
    var modelDetail: UserRegisterReturnModel?
    var userId: Int = 0
    var listMyRelationShip: [UserRegisterReturnModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupTableView()
        self.getListMyRelationShip(id: userId)
    }
    
    func setupUI(){
        
        self.btRelationShip = Settings.ShareInstance.setupButton(button: self.btRelationShip)
        self.btRelationShipExpand = Settings.ShareInstance.setupButton(button: self.btRelationShipExpand)
    }
    
    func setupTableView(){
        self.tbvRelationShip.register(UINib(nibName: "SearchBarRelationShipTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchBarRelationShipTableViewCell")
        self.tbvRelationShip.register(UINib(nibName: "DefaultTableViewCell", bundle: nil), forCellReuseIdentifier: "DefaultTableViewCell")

        self.tbvRelationShip.delegate = self
        self.tbvRelationShip.dataSource = self
        self.tbvRelationShip.separatorColor = UIColor.clear
        self.tbvRelationShip.separatorInset = UIEdgeInsets.zero
        self.tbvRelationShip.estimatedRowHeight = 300
        self.tbvRelationShip.rowHeight = UITableView.automaticDimension
    }

    @IBAction func touchRelationShipExpand(_ sender: Any) {
    
    }
    
    @IBAction func touchRelationShip(_ sender: Any) {
    
    }
    
    func getListMyRelationShip(id: Int){
        UserManager.shareUserManager().getListMyRelationShip(id: id) { [unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listMyRelationShip.append(model)
                }
                self.tbvRelationShip.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
}

extension SearchBarRelationShipViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listMyRelationShip.count == 0 {
            return 1
        }
        return listMyRelationShip.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if listMyRelationShip.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultTableViewCell") as! DefaultTableViewCell
            cell.lbTitle.text = "Không có mối quan hệ nào."
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBarRelationShipTableViewCell") as! SearchBarRelationShipTableViewCell
        let model = listMyRelationShip[indexPath.row]
        cell.imgAvatar.sd_setImage(with: URL.init(string: model.avatar ?? ""), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
            if error == nil {
                cell.imgAvatar.image = image
            }
        }
        cell.lbTitle.text = model.fullName
        cell.lbTime.text = model.address
        let career = model.career
        let arrCareer = career?.split(separator: ",")
        var strCareer = ""
        for item in arrCareer! {
            for item1 in BaseViewController.arrayJobs {
                if Int(item) == Int(item1["code"] ?? "0") {
                    if strCareer.count == 0 {
                        strCareer = strCareer + item1["name"]!
                    }else {
                        strCareer = strCareer + ", " + item1["name"]!
                    }
                    break
                }
            }
        }
        cell.lbCity.text = strCareer
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if listMyRelationShip.count == 0 {
            return
        }
        let model = listMyRelationShip[indexPath.row]
        let detail = SearchBarDetailViewController()
        detail.userId = model.id ?? 0
//        detail.modelDetail = model
//        self.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    
}
