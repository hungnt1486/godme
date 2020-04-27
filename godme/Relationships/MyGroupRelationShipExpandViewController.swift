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
    @IBOutlet weak var lbFilterJob: UILabel!
    @IBOutlet weak var tbvMyRelationShipExpand: UITableView!
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
    var indexJob: Int = 0
    
    var TypeDropdown = DropDown()
    var arrString:[String] = []
    var arr: [[String:String]] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
//        self.setupTypeDropdown()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getListGroupRelationShipFilter()
    }

    func setupUI(){
        self.vTop = Settings.ShareInstance.setupView(v: self.vTop)
        
        
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
            self.tbvMyRelationShipExpand.reloadData()
        }
    }
        
    @objc func showType(){
        TypeDropdown.show()
    }
    
    func getListGroupRelationShipFilter(){
        RelationShipsManager.shareRelationShipsManager().getSearchGroupRelationShip{ [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                self.arr.removeAll()
                self.arrString.removeAll()
                for (index, model) in data.enumerated() {
                    self.listRelationShipExpand.append(model)
                    self.arr.append(["name":model.name ?? "", "code": "\(index)"])
                    if index == 0 {
                        self.lbFilterJob.text = model.name
                    }
                }
                self.setupTypeDropdown()
                self.tbvMyRelationShipExpand.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
}

extension MyGroupRelationShipExpandViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listRelationShipExpand.count > 0 {
            let model = listRelationShipExpand[indexJob]
            return model.listUserInfo?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupRelationShipTableViewCell") as! MyGroupRelationShipTableViewCell
        cell.delegate = self
        let mod = listRelationShipExpand[indexJob]
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
                    break
                }
            }
        }
        cell.lbTime.text = strCareer
        cell.indexStar = model.totalStar ?? 0.0
        cell.lbTitle.text = model.fullName
        cell.lbCity.text = model.address
        cell.setupUI()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let modelMain = self.listRelationShipExpand[0]
        let model = modelMain.listUserInfo?[indexPath.row]
        let searchBarDetail = SearchBarDetailViewController()
        searchBarDetail.userId = model?.id ?? 0
        self.navigationController?.pushViewController(searchBarDetail, animated: true)
    }
    
}

extension MyGroupRelationShipExpandViewController: MyGroupRelationShipTableViewCellProtocol{
    func didMoreGroupRelationShip(index: Int) {
        let alertControl = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
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
        alertControl.addAction(action3)
        alertControl.addAction(action4)
        alertControl.addAction(actionCancel)
        self.navigationController?.present(alertControl, animated: true, completion: nil)
    }
}
