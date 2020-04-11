//
//  BasicServiceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/9/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import SDWebImage

class BasicServiceViewController: BaseViewController {

    @IBOutlet weak var tbvBasicService: UITableView!
    var listBaseService: [BaseServiceModel] = []
    
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
    
    var isGodcoin = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupTableView()
        self.configButtonBack()
        
        self.showProgressHub()
        self.getListBaseService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "basic_service")
    }
    
    func setupUI(){
        self.tabBarController?.tabBar.isHidden = true
        
        let right = UIBarButtonItem.init(title: "đ<->Godcoin", style: .plain, target: self, action: #selector(touchRight))
        right.tintColor = UIColor.FlatColor.Oranges.BGColor
        self.navigationItem.rightBarButtonItem = right
    }
    
    func setupTableView(){
        self.tbvBasicService.register(UINib(nibName: "BasicServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "BasicServicesTableViewCell")
        self.tbvBasicService.delegate = self
        self.tbvBasicService.dataSource = self
        self.tbvBasicService.separatorColor = UIColor.clear
        self.tbvBasicService.separatorInset = UIEdgeInsets.zero
        self.tbvBasicService.estimatedRowHeight = 300
        self.tbvBasicService.rowHeight = UITableView.automaticDimension
        self.tbvBasicService.addSubview(refreshControl)
    }
    
    @objc func touchRight(){
        isGodcoin = !isGodcoin
        self.tbvBasicService.reloadData()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        currentPage = 1
        self.getListBaseService()
        refreshControl.endRefreshing()
    }
    
    func getListBaseService(){
        ManageServicesManager.shareManageServicesManager().getListBaseService(page: self.currentPage, pageSize: self.pageSize,  sorts: [["field":"createdOn", "order": "desc"]]) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                if self.currentPage == 1 {
                    self.isLoadMore = true
                    self.listBaseService.removeAll()
                    self.listBaseService = [BaseServiceModel]()
                }
                if data.count < self.pageSize {
                    self.isLoadMore = false
                }
                for model in data {
                    self.listBaseService.append(model)
                }
                self.tbvBasicService.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
}

extension BasicServiceViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBaseService.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicServicesTableViewCell") as! BasicServicesTableViewCell
        let model = listBaseService[indexPath.row]
        cell.lbTitle.text = model.title
        let images = model.images
        let arrImgage = images?.split(separator: ",")
        var linkImg = ""
        if arrImgage!.count > 0 {
            linkImg = String(arrImgage?[0] ?? "")
        }
        cell.imgAvatar.sd_setImage(with: URL.init(string: linkImg), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
            if error == nil {
                cell.imgAvatar.image = image
            }
        }
        cell.lbCity.text = model.address
        cell.lbName.text = model.userInfo?.userCategory
        cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: model.dateTime1 ?? 0.0)
        if !isGodcoin {
            cell.lbCoin.text = Settings.ShareInstance.formatCurrency(Value: "\((Double(model.amount ?? "0") ?? 0)*1000)")
        }else{
            cell.lbCoin.text = "\(Double(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = listBaseService[indexPath.row]
        let detail = DetailBasicServiceViewController()
        detail.modelDetail = model
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLoadMore {
            if indexPath.row == listBaseService.count - 3 {
                currentPage = currentPage + 1
                self.getListBaseService()
            }
        }
    }
    
    
}
