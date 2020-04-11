//
//  AuctionServiceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/9/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class EventsViewController: BaseViewController {

    @IBOutlet weak var tbvEvents: UITableView!
    var listEvents: [EventModel] = []
    
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
        self.getListEventService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "events")
    }
    
    func setupUI(){
        self.tabBarController?.tabBar.isHidden = true
        
        let right = UIBarButtonItem.init(title: "đ<->Godcoin", style: .plain, target: self, action: #selector(touchRight))
        right.tintColor = UIColor.FlatColor.Oranges.BGColor
        self.navigationItem.rightBarButtonItem = right
    }
    
    func setupTableView(){
        self.tbvEvents.register(UINib(nibName: "EventsTableViewCell", bundle: nil), forCellReuseIdentifier: "EventsTableViewCell")
        self.tbvEvents.delegate = self
        self.tbvEvents.dataSource = self
        self.tbvEvents.separatorColor = UIColor.clear
        self.tbvEvents.separatorInset = UIEdgeInsets.zero
        self.tbvEvents.estimatedRowHeight = 300
        self.tbvEvents.rowHeight = UITableView.automaticDimension
        self.tbvEvents.addSubview(refreshControl)
    }
    
    @objc func touchRight(){
        isGodcoin = !isGodcoin
        self.tbvEvents.reloadData()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        currentPage = 1
        self.getListEventService()
        refreshControl.endRefreshing()
    }
    
    func getListEventService(){
        ManageServicesManager.shareManageServicesManager().getListEventService(page: currentPage, pageSize: pageSize, sorts: [["field":"createdOn", "order": "desc"]], ge: [["field": "endTime", "value": "\(Int(Settings.ShareInstance.convertDateToTimeInterval(date: Date())))"]]) { [unowned self](response) in
            switch response {

            case .success(let data):
                self.hideProgressHub()
                if self.currentPage == 1 {
                    self.isLoadMore = true
                    self.listEvents.removeAll()
                    self.listEvents = [EventModel]()
                }
                if data.count < self.pageSize {
                    self.isLoadMore = false
                }
                for model in data {
                    self.listEvents.append(model)
                }
                self.tbvEvents.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsTableViewCell") as! EventsTableViewCell
        let model = listEvents[indexPath.row]
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
        cell.lbTime.text = Settings.ShareInstance.convertTimeIntervalToDateTime(timeInterval: model.startTime ?? 0.0)
        cell.lbName.text = "Số người đã đăng ký: \(model.totalOrder ?? 0)/\(model.maxOrder ?? 0)"
        if !isGodcoin {
            cell.lbCoin.text = "Phí tham gia: \(Settings.ShareInstance.formatCurrency(Value: "\((Double(model.amount ?? "0") ?? 0)*1000)"))"
        }else{
            cell.lbCoin.text = "Phí tham gia: \(Double(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
        }
//        cell.lbCoin.text = "Phí tham gia: \(Double(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = listEvents[indexPath.row]
        let detail = DetailEventViewController()
        detail.modelDetail = model
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLoadMore {
            if indexPath.row == listEvents.count - 3 {
                currentPage = currentPage + 1
                self.getListEventService()
            }
        }
    }
    
}
