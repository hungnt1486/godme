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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupTableView()
        self.configButtonBack()
        self.showProgressHub()
        self.getListEventService()
    }
    
    func setupUI(){
        self.navigationItem.title = Settings.ShareInstance.translate(key: "events")
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setupTableView(){
        self.tbvEvents.register(UINib(nibName: "EventsTableViewCell", bundle: nil), forCellReuseIdentifier: "EventsTableViewCell")
        self.tbvEvents.delegate = self
        self.tbvEvents.dataSource = self
        self.tbvEvents.separatorColor = UIColor.clear
        self.tbvEvents.separatorInset = UIEdgeInsets.zero
        self.tbvEvents.estimatedRowHeight = 300
        self.tbvEvents.rowHeight = UITableView.automaticDimension
    }
    
    func getListEventService(type: String = ""){
        ManageServicesManager.shareManageServicesManager().getListEventService(type: type) { [unowned self](response) in
            switch response {

            case .success(let data):
                self.hideProgressHub()
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
        cell.imgAvatar.sd_setImage(with: URL.init(string: model.userInfo?.avatar ?? ""), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
            if error == nil {
                cell.imgAvatar.image = image
            }
        }
        cell.lbCity.text = "Địa chỉ: \(model.userInfo?.address ?? "")"
        cell.lbName.text = model.userInfo?.userCategory
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = listEvents[indexPath.row]
        let detail = DetailEventViewController()
        detail.modelDetail = model
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    
}
