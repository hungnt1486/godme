//
//  MyRelationShipExpandViewController.swift
//  godme
//
//  Created by fcsdev on 3/13/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import DropDown

class MyGroupRelationShipExpandViewController: BaseViewController {

    @IBOutlet weak var vTop: UIView!
    @IBOutlet weak var tfInputName: UITextField!
    @IBOutlet weak var lbFilterJob: UILabel!
    @IBOutlet weak var tbvMyRelationShipExpand: UITableView!
    @IBOutlet weak var btFind: UIButton!
    var listRelationShipExpand: [GroupRelationShipModel] = []
    
//    lazy var refreshControl: UIRefreshControl = {
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action:
//            #selector(self.handleRefresh(_:)),
//                                 for: UIControl.Event.valueChanged)
//        refreshControl.tintColor = UIColor.gray
//
//        return refreshControl
//    }()
//    var isLoadMore: Bool = true
//    var currentPage: Int = 1
//    var pageSize: Int = 10
    var indexJob: Int = 1
    
    var TypeDropdown = DropDown()
    var arrString:[String] = []
    var arr: [[String:String]] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupTypeDropdown()
        self.setupTableView()
        self.getListGroupRelationShipFilter()
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
        self.tbvMyRelationShipExpand.register(UINib(nibName: "MyGroupRelationShipTableViewCell", bundle: nil), forCellReuseIdentifier: "MyGroupRelationShipTableViewCell")

        self.tbvMyRelationShipExpand.delegate = self
        self.tbvMyRelationShipExpand.dataSource = self
        self.tbvMyRelationShipExpand.separatorColor = UIColor.clear
        self.tbvMyRelationShipExpand.separatorInset = UIEdgeInsets.zero
        self.tbvMyRelationShipExpand.estimatedRowHeight = 300
        self.tbvMyRelationShipExpand.rowHeight = UITableView.automaticDimension
//        self.tbvMyRelationShipExpand.addSubview(refreshControl)
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
    
//    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
//        currentPage = 1
//        self.getListGroupRelationShipFilter()
//        refreshControl.endRefreshing()
//    }
    
    func getListGroupRelationShipFilter(){
        RelationShipsManager.shareRelationShipsManager().searchGroupRelationShip(id: self.indexJob) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                
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
        self.getListGroupRelationShipFilter()
    }
    
}

extension MyGroupRelationShipExpandViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listRelationShipExpand.count > 0 {
            let model = listRelationShipExpand[0]
            return model.listUserInfo?.count ?? 0
        }
        return 0
//        return listRelationShipExpand.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupRelationShipTableViewCell") as! MyGroupRelationShipTableViewCell
        cell.delegate = self
        let mod = listRelationShipExpand[0]
        let model = mod.listUserInfo![indexPath.row]
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
//        cell.lbCoin.text = "Số tiền thụ hưởng: \(model.totalBenefited ?? 0) Godcoin"
//        cell.lbEmail.text = "Email: \(model.email ?? "")"
//        cell.lbPhone.text = "Số điện thoại: \(model.phoneNumber ?? "")"
        cell.lbTitle.text = model.fullName
        cell.lbCity.text = "Địa chỉ: \(model.address ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension MyGroupRelationShipExpandViewController: MyGroupRelationShipTableViewCellProtocol{
    func didMoreGroupRelationShip(index: Int) {
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
