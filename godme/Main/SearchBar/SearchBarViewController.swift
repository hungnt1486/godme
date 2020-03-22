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
    
    var vSearchMain: VSearchMain!
    var listSearchMain: [UserRegisterReturnModel] = []
    var arrayJobs: [[String: String]] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showProgressHub()
        self.setupUI()
        self.configButtonBack()
        self.setupTableView()
        self.getListJobs()
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
    
    @objc func touchRight(){
        DispatchQueue.main.async {
            if self.vSearchMain == nil {
                self.vSearchMain = VSearchMain.instanceFromNib()
                self.vSearchMain.tag = 10
                self.view.addSubview(self.vSearchMain)
                self.vSearchMain.delegate = self
                self.vSearchMain.arrayJobs = self.arrayJobs
                UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseOut, animations: {
                    self.vSearchMain.configVSearchMain(frameView: self.view.frame)
                }, completion: nil)
            }
        }
        
    }
    
    func getListJobs(){
        UserManager.shareUserManager().getListJobs {[unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                if data.count > 0 {
                    for item in data {
                        self.arrayJobs.append(["name":item.name ?? "", "code": "\(item.id ?? 0)"])
                    }
                }
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func getListSearch(model: userSearchParams){
        UserManager.shareUserManager().getListSearch(model: model) {[unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                print("data = \(data)")
                self.listSearchMain.removeAll()
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
    
    func setupTableView(){
        self.tbvSearchBar.register(UINib(nibName: "SearchBarTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchBarTableViewCell")

        self.tbvSearchBar.delegate = self
        self.tbvSearchBar.dataSource = self
        self.tbvSearchBar.separatorColor = UIColor.clear
        self.tbvSearchBar.separatorInset = UIEdgeInsets.zero
        self.tbvSearchBar.estimatedRowHeight = 300
        self.tbvSearchBar.rowHeight = UITableView.automaticDimension
    }
    
    
}

extension SearchBarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSearchMain.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBarTableViewCell") as! SearchBarTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detail = SearchBarDetailViewController()
        self.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(detail, animated: true)
    }
}

extension SearchBarViewController: VSearchMainProtocol{
    func didSearch(_ value: userSearchParams) {
        self.showProgressHub()
        self.getListSearch(model: value)
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
