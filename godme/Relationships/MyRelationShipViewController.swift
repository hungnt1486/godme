//
//  MyRelationShipViewController.swift
//  godme
//
//  Created by fcsdev on 3/13/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import SDWebImage
import DropDown

class MyRelationShipViewController: BaseViewController {

    @IBOutlet weak var vTop: UIView!
    @IBOutlet weak var tfInputName: UITextField!
    @IBOutlet weak var lbFilterJob: UILabel!
    @IBOutlet weak var tbvMyRelationShip: UITableView!
    @IBOutlet weak var btFind: NSLayoutConstraint!
    
    var listMyRelationShip: [RelationShipsModel] = []
    
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
    
    var TypeDropdown = DropDown()
    var arrString:[String] = []
    var arr: [[String:String]] = []
    var listGroupId: [Int] = []
    var listUserId: [Int] = []
    
    var vCheckBox: ViewShowListCheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showProgressHub()
        self.setupUI()
        self.setupTypeDropdown()
        self.setupTableView()
        self.getListRelationShipFilter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        self.tbvMyRelationShip.register(UINib(nibName: "MyRelationShip1TableViewCell", bundle: nil), forCellReuseIdentifier: "MyRelationShip1TableViewCell")

        self.tbvMyRelationShip.delegate = self
        self.tbvMyRelationShip.dataSource = self
        self.tbvMyRelationShip.separatorColor = UIColor.clear
        self.tbvMyRelationShip.separatorInset = UIEdgeInsets.zero
        self.tbvMyRelationShip.estimatedRowHeight = 300
        self.tbvMyRelationShip.rowHeight = UITableView.automaticDimension
        self.tbvMyRelationShip.addSubview(refreshControl)
    }
    
    func setupTypeDropdown(){
        TypeDropdown.anchorView = self.lbFilterJob
        self.arr = BaseViewController.arrayJobs
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
        self.getListRelationShipFilter()
        refreshControl.endRefreshing()
    }
    
    func getListRelationShipFilter(){
        RelationShipsManager.shareRelationShipsManager().getListRelationShipFilter(careerId: self.indexJob, fullName: self.tfInputName.text ?? "", page: currentPage, pageSize: pageSize) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                if self.currentPage == 1 {
                    self.isLoadMore = true
                    self.listMyRelationShip.removeAll()
                    self.listMyRelationShip = [RelationShipsModel]()
                }
                if data.count < self.pageSize {
                    self.isLoadMore = false
                }
                for model in data {
                    self.listMyRelationShip.append(model)
                }
                self.tbvMyRelationShip.reloadData()
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
        self.getListRelationShipFilter()
    }
    
    func hiddenRelationShip(index: Int){
        let model = self.listMyRelationShip[index]
        let childrenId = model.id ?? 0
        RelationShipsManager.shareRelationShipsManager().hideRelationShip(childrenId: childrenId) { [unowned self](response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: "Ẩn mối quan hệ thành công", vc: self) {[unowned self] (str) in
                    self.listMyRelationShip.remove(at: index)
                    self.tbvMyRelationShip.reloadData()
                }
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func setupVCheckBox(userId: Int){
        if vCheckBox == nil {
            vCheckBox = ViewShowListCheckBox.instanceFromNib()
            vCheckBox.userId = userId
            vCheckBox.tag = 10
            self.view.window?.addSubview(vCheckBox)
            vCheckBox.delegate = self
            self.vCheckBox.configFrame()
        }
    }
    
}

extension MyRelationShipViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMyRelationShip.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRelationShip1TableViewCell") as! MyRelationShip1TableViewCell
        cell.delegate = self
        let model = listMyRelationShip[indexPath.row]
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
                }
            }
        }
        cell.lbTime.text = strCareer
        cell.indexStar = model.totalStar ?? 0.0
        cell.lbCoin.text = "\(Double(model.totalBenefited ?? 0).formatnumber()) Godcoin"
        cell.lbTitle.text = model.fullName
        cell.lbEmail.text = model.email
        cell.imgPhone.isHidden = true
        cell.lbPhone.text = ""
        if let phone = model.phoneNumber, phone.count > 0 {
            cell.lbPhone.text = phone
            cell.imgPhone.isHidden = false
        }else{
            cell.constraintHeightPhone.constant = 0
        }
        cell.lbCity.text = model.address
        cell.lbDayLeft.text = "\(model.datesLeft ?? 0) ngày"
        cell.setupUI()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = listMyRelationShip[indexPath.row]
        let searchBarDetail = SearchBarDetailViewController()
        searchBarDetail.userId = model.id ?? 0
        self.navigationController?.pushViewController(searchBarDetail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLoadMore {
            if indexPath.row == listMyRelationShip.count - 3 {
                currentPage = currentPage + 1
                self.getListRelationShipFilter()
            }
        }
    }
    
    
}

extension MyRelationShipViewController: MyRelationShip1TableViewCellProtocol{
    func didMoreRelationShip(index: Int) {
        let alertControl = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let action2 = UIAlertAction.init(title: "Ẩn mối quan hệ", style: .default) { [unowned self] (action) in
            alertControl.dismiss(animated: true, completion: nil)
            self.showProgressHub()
            self.hiddenRelationShip(index: index)
        }
        let action3 = UIAlertAction.init(title: "Báo xấu", style: .default) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
            let help = HelpViewController()
            self.navigationController?.pushViewController(help, animated: true)
        }
        let action4 = UIAlertAction.init(title: "Xoá mối quan hệ", style: .default) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
            Settings.ShareInstance.showAlertView(message: "Coming soon", vc: self)
        }
        let actionCancel = UIAlertAction.init(title: "Huỷ", style: .cancel) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        let action5 = UIAlertAction.init(title: "Gia hạn mối quan hệ", style: .default) {[unowned self] (action) in
            alertControl.dismiss(animated: true, completion: nil)
            let model = self.listMyRelationShip[index]
            let continueMyRelation = ContinueMyRelationShipViewController()
            continueMyRelation.userId = model.id ?? 0
            self.navigationController?.pushViewController(continueMyRelation, animated: true)
        }
        
        let action6 = UIAlertAction.init(title: "Thêm mối quan hệ vào nhóm", style: .default) { [unowned self] (action) in
            alertControl.dismiss(animated: true, completion: nil)
            let model = self.listMyRelationShip[index]
            self.listUserId.append(model.id ?? 0)
            self.setupVCheckBox(userId: model.id ?? 0)
        }
        alertControl.addAction(action5)
        alertControl.addAction(action2)
        alertControl.addAction(action6)
        alertControl.addAction(action3)
        alertControl.addAction(action4)
        alertControl.addAction(actionCancel)
        self.navigationController?.present(alertControl, animated: true, completion: nil)
    }
}

extension MyRelationShipViewController: ViewShowListCheckBoxProtocol{
    func tapDone(_ list: [Int]) {
        if list.count == 0 {
            Settings.ShareInstance.showAlertView(message: "Vui lòng chọn nhóm quan hệ", vc: self)
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
