//
//  ListHiddenViewController.swift
//  godme
//
//  Created by fcsdev on 3/13/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import DropDown

class ListHiddenViewController: BaseViewController {

    @IBOutlet weak var vTop: UIView!
    @IBOutlet weak var tbvListHidden: UITableView!
    @IBOutlet weak var tfInputName: UITextField!
    @IBOutlet weak var lbFilterJob: UILabel!
    var listHidden: [RelationShipsModel] = []
    @IBOutlet weak var btFind: UIButton!
    
    var TypeDropdown = DropDown()
    var arrString:[String] = []
    var arr: [[String:String]] = []
    
    lazy var refreshControl: UIRefreshControl = {
           let refreshControl = UIRefreshControl()
           refreshControl.addTarget(self, action:
               #selector(self.handleRefresh(_:)),
                                    for: UIControl.Event.valueChanged)
           refreshControl.tintColor = UIColor.gray
           
           return refreshControl
    }()
    var isLoadMore: Bool = true
    var currentPage: Int = 1
    var pageSize: Int = 10
    var indexJob: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showProgressHub()
        self.setupUI()
        self.setupTypeDropdown()
        self.setupTableView()
        self.getListHiddenFilter()
    }
    
    func setupUI(){
        self.vTop = Settings.ShareInstance.setupView(v: self.vTop)
        
        self.tfInputName = Settings.ShareInstance.setupTextField(textField: self.tfInputName, isLeftView: true)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(showType))
        tapGesture.numberOfTouchesRequired = 1
        self.lbFilterJob.isUserInteractionEnabled = true
        self.lbFilterJob.addGestureRecognizer(tapGesture)
    }

    func setupTableView(){
        self.tbvListHidden.register(UINib(nibName: "MyRelationShipTableViewCell", bundle: nil), forCellReuseIdentifier: "MyRelationShipTableViewCell")

        self.tbvListHidden.delegate = self
        self.tbvListHidden.dataSource = self
        self.tbvListHidden.separatorColor = UIColor.clear
        self.tbvListHidden.separatorInset = UIEdgeInsets.zero
        self.tbvListHidden.estimatedRowHeight = 300
        self.tbvListHidden.rowHeight = UITableView.automaticDimension
    }
    
    func setupTypeDropdown(){
        TypeDropdown.anchorView = self.lbFilterJob
        self.arr = BaseViewController.arrayJobs
        self.arr.insert(["name": "Tất cả", "code": "0"], at: 0)
        self.lbFilterJob.text = self.arr[0]["name"]
        TypeDropdown.bottomOffset = CGPoint(x: 0, y: self.lbFilterJob.bounds.height)
            for item in arr {
                arrString.append(item["name"] ?? "")
            }
        let typeDataSource = arrString
        TypeDropdown.dataSource = typeDataSource
        TypeDropdown.selectionAction = { [unowned self] (index, item) in
            self.lbFilterJob.text = item
            let model = self.arr[index]
            self.indexJob = Int(model["code"] ?? "0")!
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        currentPage = 1
        self.getListHiddenFilter()
        refreshControl.endRefreshing()
    }
        
    @objc func showType(){
        TypeDropdown.show()
    }
    
    func getListHiddenFilter(){
        RelationShipsManager.shareRelationShipsManager().getListHidenFilter(careerId: 0, fullName: "", page: 0, pageSize: 0) { [unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                
                if self.currentPage == 1 {
                    self.isLoadMore = true
                    self.listHidden.removeAll()
                    self.listHidden = [RelationShipsModel]()
                }
                if data.count < self.pageSize {
                    self.isLoadMore = false
                }
                for model in data {
                    self.listHidden.append(model)
                }
                self.tbvListHidden.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    @IBAction func touchFind(_ sender: Any) {
        self.showProgressHub()
        self.currentPage = 1
        self.getListHiddenFilter()
    }
    
    func showRelationShip(index: Int){
        let model = self.listHidden[index]
        let childrenId = model.id ?? 0
        RelationShipsManager.shareRelationShipsManager().showRelationShip(childrenId: childrenId) { [unowned self](response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: "Hiển thị mối quan hệ thành công", vc: self) {[unowned self] (str) in
                    self.listHidden.remove(at: index)
                    self.tbvListHidden.reloadData()
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

extension ListHiddenViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listHidden.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRelationShipTableViewCell") as! MyRelationShipTableViewCell
        cell.delegate = self
        
        let model = listHidden[indexPath.row]
        cell.imgAvatar.sd_setImage(with: URL.init(string: model.avatar ?? ""), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
            if error == nil {
                cell.imgAvatar.image = image
            }
        }
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
        cell.lbTime.text = strCareer
        cell.indexStar = model.totalStar ?? 0.0
        cell.lbCoin.text = "\(Double(model.totalBenefited ?? 0).formatnumber()) Godcoin"
        cell.lbEmail.text = model.email
        cell.lbEmail.tag = indexPath.row
        cell.lbPhone.tag = indexPath.row
        cell.lbPhone.text = ""
        cell.imgPhone.isHidden = true
        if let phone = model.phoneNumber, phone.count > 0 {
            cell.lbPhone.text = phone
            cell.imgPhone.isHidden = false
        }else{
            cell.constraintHeightPhone.constant = 0
        }
        cell.lbTitle.text = model.fullName
        cell.lbCity.text = model.address
        cell.setupUI()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = listHidden[indexPath.row]
        let searchBarDetail = SearchBarDetailViewController()
        searchBarDetail.userId = model.id ?? 0
        self.navigationController?.pushViewController(searchBarDetail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLoadMore {
            if indexPath.row == listHidden.count - 3 {
                currentPage = currentPage + 1
                self.getListHiddenFilter()
            }
        }
    }
    
}

extension ListHiddenViewController: MyRelationShipTableViewCellProtocol{
    func didEmail(index: Int) {
        let model = self.listHidden[index]
        Settings.ShareInstance.openEmail(email: model.email ?? "")
    }
    
    func didPhoneNumber(index: Int) {
        let model = self.listHidden[index]
        Settings.ShareInstance.callPhoneNumber(phoneNumber: model.phoneNumber ?? "")
    }
    
    func didMoreRelationShip(index: Int) {
        let alertControl = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let action2 = UIAlertAction.init(title: "Hiển thị mối quan hệ", style: .default) {[unowned self]  (action) in
            alertControl.dismiss(animated: true, completion: nil)
            self.showProgressHub()
            self.showRelationShip(index: index)
        }
        let action3 = UIAlertAction.init(title: "Báo xấu", style: .default) {[unowned self]  (action) in
            alertControl.dismiss(animated: true, completion: nil)
            let help = HelpViewController()
            self.navigationController?.pushViewController(help, animated: true)
        }
        let action4 = UIAlertAction.init(title: "Xoá mối quan hệ", style: .default) {(action) in
            alertControl.dismiss(animated: true, completion: nil)
            
        }
        let actionCancel = UIAlertAction.init(title: "Huỷ", style: .cancel) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        
        alertControl.addAction(action2)
        alertControl.addAction(action3)
        alertControl.addAction(action4)
        alertControl.addAction(actionCancel)
        self.navigationController?.present(alertControl, animated: true, completion: nil)
    }
}
