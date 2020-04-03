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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "events")
    }
    
    func setupUI(){
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
        cell.lbCoin.text = "Phí tham gia: \(Int(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
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
