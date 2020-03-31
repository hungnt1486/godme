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
    
    var TypeDropdown = DropDown()
    var arrString:[String] = []
    var arr: [[String:String]] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupTypeDropdown()
        self.setupTableView()
        self.getListRelationShipExpandFilter()
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
        self.getListRelationShipExpandFilter()
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
                }
            }
        }
        cell.lbTime.text = strCareer
        cell.indexStar = model.totalStar ?? 0.0
        cell.lbCoin.text = "\(model.totalBenefited ?? 0) Godcoin"
        cell.lbEmail.text = model.email
        cell.imgPhone.isHidden = true
        cell.lbPhone.text = ""
        if let phone = model.phoneNumber, phone.count > 0 {
            cell.lbPhone.text = phone
            cell.imgPhone.isHidden = false
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
    func didMoreRelationShip(index: Int) {
        let alertControl = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let action2 = UIAlertAction.init(title: "Ẩn mối quan hệ", style: .default) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        let action1 = UIAlertAction.init(title: "Thêm mối quan hệ vào nhóm", style: .default) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        let action3 = UIAlertAction.init(title: "Báo xấu", style: .default) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        let action4 = UIAlertAction.init(title: "Xoá mối quan hệ", style: .default) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction.init(title: "Huỷ", style: .cancel) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        
        alertControl.addAction(action2)
        alertControl.addAction(action1)
        alertControl.addAction(action3)
        alertControl.addAction(action4)
        alertControl.addAction(actionCancel)
        self.navigationController?.present(alertControl, animated: true, completion: nil)
    }
}
