//
//  MainViewController.swift
//  godme
//
//  Created by fcsdev on 2/28/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: BaseViewController {

    @IBOutlet weak var tbvMain: UITableView!
    var stretchyHeaderView: HeaderMain?
    var vSearchBar: VSearchBar!
    
    var listBaseService: [BaseServiceModel] = []
    var listAuction:[AuctionServiceModel] = []
    var listEvents: [EventModel] = []
    var listCollaboration: [CollaborationModel] = []
    var listBlogs: [BlogModel] = []
    var listCharity: [BlogModel] = []
    var walletCharity: WalletCharityModel?
    var headerMain: HeaderMain?
    
    var locationManagerHome = CLLocationManager()
    var latt: Double = 0.0
    var longt: Double = 0.0
    var modelUser = Settings.ShareInstance.getDictUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupTableView()
        self.showProgressHub()
        self.getListBaseService()
        self.getListAuctionService()
        self.getListEventService()
        self.getListCollaborationService()
        self.getListBlogs()
        self.getListCharity()
        self.getAmountCharity()
        self.getListJobsMain()
        self.getListGroupRelationShip()
        if (modelUser.isFirstLogin ?? false) {
            Settings.ShareInstance.showAlertView(message: "Vui lòng cập nhật thông tin", vc: self) {[unowned self] (str) in
                let profile = EditProfileViewController()
                self.navigationController?.pushViewController(profile, animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tbvMain.reloadData()
        self.setupSearchBar()
        self.setupLocation()
        BaseViewController.Current_Lat = 0.0
        locationManagerHome.startUpdatingLocation()
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.locationManagerHome.stopUpdatingLocation()
        if vSearchBar != nil {
            vSearchBar.viewWithTag(5)?.removeFromSuperview()
            vSearchBar = nil
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if vSearchBar != nil {
            vSearchBar.viewWithTag(5)?.removeFromSuperview()
            vSearchBar = nil
        }
    }
    
    func setupLocation(){
        locationManagerHome.delegate = self
        locationManagerHome.requestWhenInUseAuthorization()
        locationManagerHome.requestLocation()
    }
    
    func setupSearchBar(){
        if vSearchBar == nil {
            vSearchBar = VSearchBar.instanceFromNib()
            vSearchBar.delegate = self
            vSearchBar.tag = 5
            vSearchBar.configVSearchBar(frameView: CGRect.init(x: (UIScreen.main.bounds.width - 200)/2, y: 0, width: 200, height: 50))
            self.navigationController?.navigationBar.addSubview(vSearchBar)
        }
    }
    
    func getListBaseService(){
        ManageServicesManager.shareManageServicesManager().getListBaseService(page: 1, pageSize: 1000, sorts: [["field":"createdOn", "order": "desc"]]) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listBaseService.append(model)
                }
                self.tbvMain.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func getListAuctionService(){
        ManageServicesManager.shareManageServicesManager().getListAuctionService(page: 1, pageSize: 1000, sorts: [["field":"createdOn", "order": "desc"]], ge: [["field": "endTime", "value": "\(Int(Settings.ShareInstance.convertDateToTimeInterval(date: Date())))"]]) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listAuction.append(model)
                }
                self.tbvMain.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func getListEventService(){
        ManageServicesManager.shareManageServicesManager().getListEventService(page: 1, pageSize: 1000, sorts: [["field":"createdOn", "order": "desc"]], ge: [["field": "endTime", "value": "\(Int(Settings.ShareInstance.convertDateToTimeInterval(date: Date())))"]]) { [unowned self](response) in
            switch response {

            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listEvents.append(model)
                }
                self.tbvMain.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func getListCollaborationService(){
        ManageServicesManager.shareManageServicesManager().getListCollaborationService(page: 1, pageSize: 1000, sorts: [["field":"createdOn", "order": "desc"]]) { [unowned self](response) in
            switch response {

            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listCollaboration.append(model)
                }
                self.tbvMain.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func getAmountCharity(){
        WalletManager.shareWalletManager().getAmountCharity {[unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                self.walletCharity = data
                let total = Double(self.walletCharity?.totalAmountGodmeCharity ?? "0.0")
                self.headerMain?.lbTotalMoney.text = Settings.ShareInstance.formatCurrency(Value: "\(total! * 1000)")
                self.headerMain?.lbMoney.text = Settings.ShareInstance.formatCurrency(Value: "\(Double(self.walletCharity?.totalAmountUserCharity ?? "0.0")! * 1000)")
                self.headerMain?.lbCharity.text = Settings.ShareInstance.translate(key: "label_charity_godme")
                self.tbvMain.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func getListBlogs(){
        ManageServicesManager.shareManageServicesManager().getListBlogsService { [unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listBlogs.append(model)
                }
                self.tbvMain.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func getListCharity(){
        ManageServicesManager.shareManageServicesManager().getListCharityService { [unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                for model in data {
                    self.listCharity.append(model)
                }
                self.tbvMain.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func setupUI(){
        let left = UIBarButtonItem.init(image: UIImage.init(named: "ic_people_white")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(touchLeft))
        self.navigationItem.leftBarButtonItem = left



        let right = UIBarButtonItem.init(image: UIImage.init(named: "ic_notification")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(touchRight))
        self.navigationItem.rightBarButtonItem = right
    }
    
    @objc func touchLeft(){
        self.editProfile()
    }
    
    @objc func touchRight(){
//        Settings.ShareInstance.showAlertView(message: "Coming soon", vc: self)
        let notification = NotificationsViewController()
        self.navigationController?.pushViewController(notification, animated: true)
    }
    
    func setupTableView(){
        self.tbvMain.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        self.tbvMain.register(UINib(nibName: "Main1TableViewCell", bundle: nil), forCellReuseIdentifier: "Main1TableViewCell")
        self.tbvMain.register(UINib(nibName: "Main2TableViewCell", bundle: nil), forCellReuseIdentifier: "Main2TableViewCell")
        self.tbvMain.register(UINib(nibName: "Main3TableViewCell", bundle: nil), forCellReuseIdentifier: "Main3TableViewCell")
        self.tbvMain.register(UINib(nibName: "Main4TableViewCell", bundle: nil), forCellReuseIdentifier: "Main4TableViewCell")
        self.tbvMain.register(UINib(nibName: "Main5TableViewCell", bundle: nil), forCellReuseIdentifier: "Main5TableViewCell")
        self.tbvMain.register(UINib(nibName: "Main6TableViewCell", bundle: nil), forCellReuseIdentifier: "Main6TableViewCell")
        self.tbvMain.register(UINib.init(nibName: "HeaderSubMain", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderSubMain")

        self.tbvMain.delegate = self
        self.tbvMain.dataSource = self
        self.tbvMain.separatorColor = UIColor.clear
        self.tbvMain.separatorInset = UIEdgeInsets.zero
        self.tbvMain.estimatedRowHeight = 300
        self.tbvMain.rowHeight = UITableView.automaticDimension
        
        headerMain = Bundle.main.loadNibNamed("HeaderMain", owner: self, options: nil)![0] as? HeaderMain

        
        self.stretchyHeaderView = headerMain//headerMain![0] as? HeaderMain
        self.tbvMain.addSubview(self.stretchyHeaderView!)
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderSubMain") as! HeaderSubMain
        header.backgroundColor = UIColor.FlatColor.Gray.BGColor
        header.delegate = self
        header.btMore.tag = section
        header.btMore.setTitle(Settings.ShareInstance.translate(key: "label_watch_more"), for: .normal)
        if section == 0 {
            header.lbTitle.text = Settings.ShareInstance.translate(key: "label_service_basic")
        }else if section == 1 {
            header.lbTitle.text = Settings.ShareInstance.translate(key: "label_service_auction")//"Đấu giá dịch vụ"
        }else if section == 2{
            header.lbTitle.text = Settings.ShareInstance.translate(key: "label_event")//"Sự kiện"
        }else if section == 3{
            header.lbTitle.text = Settings.ShareInstance.translate(key: "label_coop")//"Hợp tác"
        }else if section == 4{
            header.lbTitle.text = "Godme Charity"
        }else if section == 5{
            header.lbTitle.text = Settings.ShareInstance.translate(key: "label_coop_product")//"Sản phẩm liên kết"
        }else if section == 6{
            header.lbTitle.text = "Blogs"
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 || indexPath.section == 1 {
            return 130
        }else if indexPath.section == 2 || indexPath.section == 5 {
            return 290
        }else{
            return 180
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
            cell.delegate = self
            cell.listBaseService = self.listBaseService
            cell.collectionView.reloadData()
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Main1TableViewCell") as! Main1TableViewCell
            cell.delegate = self
            cell.listAuction = self.listAuction
            cell.collectionView.reloadData()
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Main2TableViewCell") as! Main2TableViewCell
            cell.delegate = self
            cell.listEvents = self.listEvents
            cell.collectionView.reloadData()
            return cell
        }
        else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Main3TableViewCell") as! Main3TableViewCell
            cell.delegate = self
            cell.listCollaboration = self.listCollaboration
            cell.collectionView.reloadData()
            return cell
        }
        else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Main4TableViewCell") as! Main4TableViewCell
            cell.delegate = self
            cell.listBlogs = self.listCharity
            cell.collectionView.reloadData()
            return cell
        }
        else if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Main5TableViewCell") as! Main5TableViewCell
//            cell.delegate = self
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Main6TableViewCell") as! Main6TableViewCell
            cell.delegate = self
            cell.listBlogs = self.listBlogs
            cell.collectionView.reloadData()
            return cell
        }
    }
}

extension MainViewController: MainTableViewCellProtocol{
    func didCell(index: Int) {
        let model = listBaseService[index]
        let detail = DetailBasicServiceViewController()
        detail.modelDetail = model
        self.navigationController?.pushViewController(detail, animated: true)
               
//        print("index = ", index)
//        let detail = DetailBasicServiceViewController()
//        self.navigationController?.pushViewController(detail, animated: true)
    }
}

extension MainViewController: Main1TableViewCellProtocol{
    func didCellMain1(index: Int) {
        let model = listAuction[index]
        let detailAuction = DetailAuctionViewController()
        detailAuction.modelDetail = model
        self.navigationController?.pushViewController(detailAuction, animated: true)
    }
}

extension MainViewController: Main2TableViewCellProtocol{
    func didCellMain2(index: Int) {
        let model = listEvents[index]
        let detailEvent = DetailEventViewController()
        detailEvent.modelDetail = model
        self.navigationController?.pushViewController(detailEvent, animated: true)
    }
}

extension MainViewController: Main3TableViewCellProtocol{
    func didCellMain3(index: Int) {
        print("index3 = ", index)
        let model = self.listCollaboration[index]
        let str = "\(model.title ?? "") \(model.id ?? 0)"
        Settings.ShareInstance.openWebsite(link: "\(URLs.linkWebCollaboration)\(str.convertedToSlug() ?? "")")
    }
}

extension MainViewController: Main4TableViewCellProtocol{
    func didCellMain4(index: Int) {
        print("index4 = ", index)
        let model = self.listCharity[index]
        let str = "\(model.title ?? "") \(model.id ?? 0)"
        Settings.ShareInstance.openWebsite(link: "\(URLs.linkwebBlog)\(str.convertedToSlug() ?? "")")
    }
}

extension MainViewController: Main6TableViewCellProtocol{
    func didCellMain6(index: Int) {
        print("index4 = ", index)
        let model = self.listBlogs[index]
        let str = "\(model.title ?? "") \(model.id ?? 0)"
        Settings.ShareInstance.openWebsite(link: "\(URLs.linkwebBlog)\(str.convertedToSlug() ?? "")")
    }
}

extension MainViewController: HeaderSubMainProtocol{
    func didMore(index: Int) {
        if index == 0 {
            // for case basic service
            let basicService = BasicServiceViewController()
            self.navigationController?.pushViewController(basicService, animated: true)
        }else if index == 1 {
            let auctionService = AuctionServiceViewController()
            self.navigationController?.pushViewController(auctionService, animated: true)
        }else if index == 2{
            let event = EventsViewController()
            self.navigationController?.pushViewController(event, animated: true)
        }else if index == 3 {
//            https://godme.org/coop
            Settings.ShareInstance.openWebsite(link: "\(URLs.linkHostName)/coop")
        }else if index == 4 {
            Settings.ShareInstance.openWebsite(link: "\(URLs.linkHostName)/charity")
        }else if index == 6 {
            Settings.ShareInstance.openWebsite(link: "\(URLs.linkHostName)/article/search")
        }
    }
}

extension MainViewController: VSearchBarProtocol{
    func didSearch(_ str: String) {
        print("search")
        let searchBar = SearchBarViewController()
        searchBar.strKeyWord = str.trimmingCharacters(in: .whitespacesAndNewlines)
        self.navigationController?.pushViewController(searchBar, animated: true)
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
            print("lat = , long =  \(lat),\(long)")
            latt = lat
            longt = long
            DispatchQueue.main.async {

               // self.getListBannerTransaction()
                BaseViewController.Current_Lat = self.latt
                BaseViewController.Current_Lng = self.longt
                BaseViewController.Lat = self.latt
                BaseViewController.Lng = self.longt
               // self.getListBannerTransaction(Skip: self.currentPage*self.pageSize, Take: self.pageSize)
            }
            
            locationManagerHome.stopUpdatingLocation()
            locationManagerHome.delegate = nil
            return
        } else {
            print("No coordinates")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
       
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("ge")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("status = \(status.rawValue)")
        // = 4 allow get location
        
        if status.rawValue > 0 {
            
        }
    }
    
}
