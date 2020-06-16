//
//  MyRelationShipExpandViewController.swift
//  godme
//
//  Created by fcsdev on 3/13/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import DropDown

class MyRelationShipExpandViewController: BaseViewController {

    @IBOutlet weak var vTop: UIView!
    @IBOutlet weak var tfInputName: UITextField!
    @IBOutlet weak var lbFilterJob: UILabel!
    @IBOutlet weak var tbvMyRelationShipExpand: UITableView!
    @IBOutlet weak var btFind: UIButton!
    var listRelationShipExpand: [RelationShipsModel] = []
    
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
    
    var vCheckBox: ViewShowListCheckBox!
    var listGroupId: [Int] = []
    var listUserId: [Int] = []
    
    var TypeDropdown = DropDown()
    var arrString:[String] = []
    var arr: [[String:String]] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showProgressHub()
        self.setupUI()
        self.setupTypeDropdown()
        self.setupTableView()
        self.getListRelationShipExpandFilter()
    }

    func setupUI(){
        self.vTop = Settings.ShareInstance.setupView(v: self.vTop)
        
        self.tfInputName = Settings.ShareInstance.setupTextField(textField: self.tfInputName, isLeftView: true)
        self.tfInputName.placeholder = Settings.ShareInstance.translate(key: "label_search_name_user")
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(showType))
        tapGesture.numberOfTouchesRequired = 1
        self.lbFilterJob.isUserInteractionEnabled = true
        self.lbFilterJob.addGestureRecognizer(tapGesture)
        self.btFind.setTitle(Settings.ShareInstance.translate(key: "label_search"), for: .normal)
    }

    func setupTableView(){
        self.tbvMyRelationShipExpand.register(UINib(nibName: "MyRelationShipTableViewCell", bundle: nil), forCellReuseIdentifier: "MyRelationShipTableViewCell")

        self.tbvMyRelationShipExpand.delegate = self
        self.tbvMyRelationShipExpand.dataSource = self
        self.tbvMyRelationShipExpand.separatorColor = UIColor.clear
        self.tbvMyRelationShipExpand.separatorInset = UIEdgeInsets.zero
        self.tbvMyRelationShipExpand.estimatedRowHeight = 300
        self.tbvMyRelationShipExpand.rowHeight = UITableView.automaticDimension
        self.tbvMyRelationShipExpand.addSubview(refreshControl)
    }
    
    func setupTypeDropdown(){
        TypeDropdown.anchorView = self.lbFilterJob
        self.arr = BaseViewController.arrayJobs
        self.arr.insert(["name": Settings.ShareInstance.translate(key: "label_all"), "code": "0"], at: 0)
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
        
    @objc func showType(){
        TypeDropdown.show()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        currentPage = 1
        self.getListRelationShipExpandFilter()
        refreshControl.endRefreshing()
    }
    
    func getListRelationShipExpandFilter(){
        RelationShipsManager.shareRelationShipsManager().getListRelationShipExpandFilter(careerId: self.indexJob, fullName: self.tfInputName.text ?? "", page: currentPage, pageSize: pageSize) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                
                if self.currentPage == 1 {
                    self.isLoadMore = true
                    self.listRelationShipExpand.removeAll()
                    self.listRelationShipExpand = [RelationShipsModel]()
                }
                if data.count < self.pageSize {
                    self.isLoadMore = false
                }
                for model in data {
                    self.listRelationShipExpand.append(model)
                }
                self.tbvMyRelationShipExpand.reloadData()
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
        self.getListRelationShipExpandFilter()
    }
    
    func setupVCheckBox(){
        if vCheckBox == nil {
            vCheckBox = ViewShowListCheckBox.instanceFromNib()
            vCheckBox.tag = 10
            self.view.window?.addSubview(vCheckBox)
            vCheckBox.delegate = self
            self.vCheckBox.configFrame()
        }
    }
    
    func hiddenRelationShip(index: Int){
        let model = self.listRelationShipExpand[index]
        let childrenId = model.id ?? 0
        RelationShipsManager.shareRelationShipsManager().hideRelationShip(childrenId: childrenId) { [unowned self](response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: Settings.ShareInstance.translate(key: "label_hidde_network_successful"), vc: self) {[unowned self] (str) in
                    self.listRelationShipExpand.remove(at: index)
                    self.tbvMyRelationShipExpand.reloadData()
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

extension MyRelationShipExpandViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listRelationShipExpand.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRelationShipTableViewCell") as! MyRelationShipTableViewCell
        cell.delegate = self
        let model = listRelationShipExpand[indexPath.row]
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
        cell.imgPhone.isHidden = true
        cell.lbPhone.text = ""
        cell.lbPhone.tag = indexPath.row
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
        let model = listRelationShipExpand[indexPath.row]
        let searchBarDetail = SearchBarDetailViewController()
        searchBarDetail.userId = model.id ?? 0
        self.navigationController?.pushViewController(searchBarDetail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLoadMore {
            if indexPath.row == listRelationShipExpand.count - 3 {
                currentPage = currentPage + 1
                self.getListRelationShipExpandFilter()
            }
        }
    }
    
}

extension MyRelationShipExpandViewController: MyRelationShipTableViewCellProtocol{
    func didEmail(index: Int) {
        let model = self.listRelationShipExpand[index]
        Settings.ShareInstance.openEmail(email: model.email ?? "")
    }
    
    func didPhoneNumber(index: Int) {
        let model = self.listRelationShipExpand[index]
        Settings.ShareInstance.callPhoneNumber(phoneNumber: model.phoneNumber ?? "")
    }
    
    func didMoreRelationShip(index: Int) {
        let model = self.listRelationShipExpand[index]
        let alertControl = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let action2 = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_hidde_network"), style: .default) {[unowned self] (action) in
            alertControl.dismiss(animated: true, completion: nil)
            self.showProgressHub()
            self.hiddenRelationShip(index: index)
        }
        let action1 = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_add_party"), style: .default) {[unowned self] (action) in
            alertControl.dismiss(animated: true, completion: nil)
            
            self.listUserId.append(model.id ?? 0)
            self.setupVCheckBox()
        }
        let action3 = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_report"), style: .default) {[unowned self] (action) in
            alertControl.dismiss(animated: true, completion: nil)
            let help = HelpViewController()
            self.navigationController?.pushViewController(help, animated: true)
        }
        let action4 = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_remove_network"), style: .default) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_cancel"), style: .cancel) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        let action7 = UIAlertAction.init(title: model.fullName ?? "", style: .default) {(action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        alertControl.addAction(action7)
        alertControl.addAction(action2)
        alertControl.addAction(action1)
        alertControl.addAction(action3)
        alertControl.addAction(action4)
        alertControl.addAction(actionCancel)
        self.navigationController?.present(alertControl, animated: true, completion: nil)
    }
}

extension MyRelationShipExpandViewController: ViewShowListCheckBoxProtocol{
    func tapDone(_ list: [Int]) {
        if list.count == 0 {
            Settings.ShareInstance.showAlertView(message: Settings.ShareInstance.translate(key: "label_group_relationship_choose"), vc: self)
            return
        }
        for i in 0..<list.count {
            let model = BaseViewController.listGroup[i]
            self.listGroupId.append(model.id ?? 0)
        }
        vCheckBox.viewWithTag(10)?.removeFromSuperview()
        vCheckBox = nil
        self.showProgressHub()
        self.addUserToMultiGroupRelationShip(listGroupId: self.listGroupId, listUserId: self.listUserId)
        self.listUserId.removeAll()
        self.listGroupId.removeAll()
    }
    
    func tapCancel() {
        self.listUserId.removeAll()
        vCheckBox.viewWithTag(10)?.removeFromSuperview()
        vCheckBox = nil
    }
    
    func tapGesture() {
        self.listUserId.removeAll()
        vCheckBox.viewWithTag(10)?.removeFromSuperview()
        vCheckBox = nil
    }
    
    
}
