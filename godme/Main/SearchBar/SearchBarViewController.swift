//
//  SearchBarViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/11/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class SearchBarViewController: BaseViewController {

    @IBOutlet weak var tfJob: UITextField!
    @IBOutlet weak var tfLocation: UITextField!
    @IBOutlet weak var btCancel: UIButton!
    @IBOutlet weak var imgSearch: UIImageView!
    @IBOutlet weak var tbvSearchBar: UITableView!
    
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
    
    var vSearchMain: VSearchMain!
    var listSearchMain: [UserRegisterReturnModel] = []
    var modelUserSearch = userSearchParamsModel()
//    var arrayJobs: [[String: String]] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showProgressHub()
        self.setupUI()
        self.configButtonBack()
        self.setupTableView()
        modelUserSearch.nationCode = "VN"
        modelUserSearch.provinceCode = ""
        modelUserSearch.districtCode = ""
        modelUserSearch.wardCode = ""
        modelUserSearch.page = currentPage
        modelUserSearch.pageSize = pageSize
        self.getListSearch()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "find_job")
    }
    
    func setupUI(){
        self.tabBarController?.tabBar.isHidden = true
        
        let right = UIBarButtonItem.init(image: UIImage.init(named: "ic_filter")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(touchRight))
        self.navigationItem.rightBarButtonItem = right
    }
    
    func setupTableView(){
        self.tbvSearchBar.register(UINib(nibName: "SearchBarTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchBarTableViewCell")
        self.tbvSearchBar.register(UINib(nibName: "SearchBar1TableViewCell", bundle: nil), forCellReuseIdentifier: "SearchBar1TableViewCell")

        self.tbvSearchBar.delegate = self
        self.tbvSearchBar.dataSource = self
        self.tbvSearchBar.separatorColor = UIColor.clear
        self.tbvSearchBar.separatorInset = UIEdgeInsets.zero
        self.tbvSearchBar.estimatedRowHeight = 300
        self.tbvSearchBar.rowHeight = UITableView.automaticDimension
        self.tbvSearchBar.addSubview(refreshControl)
    }
    
    @objc func touchRight(){
        DispatchQueue.main.async {
            if self.vSearchMain == nil {
                self.vSearchMain = VSearchMain.instanceFromNib()
                self.vSearchMain.tag = 10
                self.view.addSubview(self.vSearchMain)
                self.vSearchMain.delegate = self
                self.vSearchMain.arrayJobs = BaseViewController.arrayJobs
                UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseOut, animations: {
                    self.vSearchMain.configVSearchMain(frameView: self.view.frame)
                }, completion: nil)
            }
        }
        
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        currentPage = 1
        modelUserSearch.nationCode = "VN"
        modelUserSearch.provinceCode = ""
        modelUserSearch.districtCode = ""
        modelUserSearch.wardCode = ""
        modelUserSearch.fullName = ""
        modelUserSearch.education = ""
        modelUserSearch.gender = ""
        modelUserSearch.keyword = ""
        modelUserSearch.career = ""
        modelUserSearch.page = currentPage
        modelUserSearch.pageSize = pageSize
        self.getListSearch()
        refreshControl.endRefreshing()
    }
    
    func getListSearch(){
        var model = userSearchParams()
        model.career = modelUserSearch.career
        model.districtCode = modelUserSearch.districtCode
        model.wardCode = modelUserSearch.wardCode
        model.nationCode = modelUserSearch.nationCode
        model.fullName = modelUserSearch.fullName
        model.education = modelUserSearch.education
        model.gender = modelUserSearch.gender
        model.page = modelUserSearch.page
        model.pageSize = modelUserSearch.pageSize
        model.keyword = modelUserSearch.keyword
        model.provinceCode = modelUserSearch.provinceCode
        UserManager.shareUserManager().getListSearch(model: model) {[unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                if self.currentPage == 1 {
                    self.isLoadMore = true
                    self.listSearchMain.removeAll()
                    self.listSearchMain = [UserRegisterReturnModel]()
                }
                if data.count < self.pageSize {
                    self.isLoadMore = false
                }
                for model in data {
                    self.listSearchMain.append(model)
                }
                self.tbvSearchBar.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func connectToUser(toUserId: Int){
        RelationShipsManager.shareRelationShipsManager().connectToUserRelationShip(toUserId: toUserId) { [unowned self](response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: "Gửi yêu cầu kết nối thành công", vc: self)
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
}

extension SearchBarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSearchMain.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = listSearchMain[indexPath.row]
        if model.isConnected == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBarTableViewCell") as! SearchBarTableViewCell
            
            cell.imgAvatar.sd_setImage(with: URL.init(string: model.avatar ?? ""), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
                if error == nil {
                    cell.imgAvatar.image = image
                }
            }
            cell.lbTitle.text = model.fullName
            cell.lbTime.text = Settings.ShareInstance.convertDOB(str: model.dob ?? "")
            cell.lbCity.text = model.gender == "NAM" ? "Nam" : "Nữ"
            cell.imgGender.image = UIImage.init(named: model.gender == "NAM" ? "ic_male" : "ic_female")
            cell.lbAddress.text = model.address
            cell.indexStar = model.totalStar ?? 0.0
            cell.setupUI()
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBar1TableViewCell") as! SearchBar1TableViewCell
            
            cell.imgAvatar.sd_setImage(with: URL.init(string: model.avatar ?? ""), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
                if error == nil {
                    cell.imgAvatar.image = image
                }
            }
            cell.lbTitle.text = model.fullName
            cell.lbTime.text = Settings.ShareInstance.convertDOB(str: model.dob ?? "")
            cell.lbCity.text = model.gender == "NAM" ? "Nam" : "Nữ"
            cell.imgGender.image = UIImage.init(named: model.gender == "NAM" ? "ic_male" : "ic_female")
            cell.lbAddress.text = model.address
            cell.indexStar = model.totalStar ?? 0.0
            cell.setupUI()
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = listSearchMain[indexPath.row]
        let detail = SearchBarDetailViewController()
        detail.modelDetail = model
        self.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLoadMore {
            if indexPath.row == listSearchMain.count - 3 {
                currentPage = currentPage + 1
                modelUserSearch.page = currentPage
                self.getListSearch()
            }
        }
    }
}

extension SearchBarViewController: VSearchMainProtocol{
    func didSearch(_ value: userSearchParamsModel) {
        self.showProgressHub()
        modelUserSearch = value
        self.getListSearch()
        vSearchMain.viewWithTag(10)?.removeFromSuperview()
        vSearchMain = nil
    }
//    func didSearch(_ value: [String : String]) {
//        print("value = \(value)")
////        let model = userSearchParams()
////        model.
//        vSearchMain.viewWithTag(10)?.removeFromSuperview()
//        vSearchMain = nil
//    }
    func didCancel() {
        vSearchMain.viewWithTag(10)?.removeFromSuperview()
        vSearchMain = nil
    }
}

extension SearchBarViewController: SearchBar1TableViewCellProtocol{
    func didConnect(_ index: Int) {
        self.showProgressHub()
        let model = listSearchMain[index]
        self.connectToUser(toUserId: model.id ?? 0)
    }
}
