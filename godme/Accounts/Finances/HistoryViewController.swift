//
//  HistoryViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class HistoryViewController: BaseViewController {

    @IBOutlet weak var tbvHistory: UITableView!
    @IBOutlet weak var btFromDate: UIButton!
    @IBOutlet weak var btToDate: UIButton!
    @IBOutlet weak var vFromDate: UIView!
    @IBOutlet weak var vToDate: UIView!
    var vDatePicker: ViewDatePicker1!
    var listTransaction: [TransactionModel] = []
    var fromDate: Double?, toDate: Double?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showProgressHub()
        DispatchQueue.main.async {
            self.setupUI()
        }
        self.setupTableView()
        self.configButtonBack()
        self.getListTransaction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "label_check_history")
    }
    
    func setupUI(){
        self.btFromDate = Settings.ShareInstance.setupButton(button: self.btFromDate)
        self.btFromDate.setTitle(Settings.ShareInstance.translate(key: "label_start_date"), for: .normal)
        self.btToDate.setTitle(Settings.ShareInstance.translate(key: "label_end_date"), for: .normal)
        self.btToDate = Settings.ShareInstance.setupButton(button: self.btToDate)
        self.vFromDate = Settings.ShareInstance.setupBTV(v: self.vFromDate)
        self.vToDate = Settings.ShareInstance.setupBTV(v: self.vToDate)
        
        let right = UIBarButtonItem.init(image: UIImage.init(named: "ic_search"), style: .plain, target: self, action: #selector(touchRight))
        self.navigationItem.rightBarButtonItem = right
    }
    
    func setupTableView(){
        self.tbvHistory.register(UINib(nibName: "HistoryLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryLabelTableViewCell")

        self.tbvHistory.delegate = self
        self.tbvHistory.dataSource = self
        self.tbvHistory.allowsSelection = false
        self.tbvHistory.estimatedRowHeight = 100
        self.tbvHistory.rowHeight = UITableView.automaticDimension
        self.tbvHistory.addSubview(refreshControl)
    }
    
    @objc func touchRight(){
        self.currentPage = 1
        self.getListTransactionFilter()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        currentPage = 1
        fromDate = 0.0
        toDate = 0.0
        self.btFromDate.setTitle(Settings.ShareInstance.translate(key: "label_start_date"), for: .normal)
        self.btToDate.setTitle(Settings.ShareInstance.translate(key: "label_end_date"), for: .normal)
        self.getListTransaction()
        refreshControl.endRefreshing()
    }
    
    func getListTransaction(){
        UserManager.shareUserManager().getListTransaction(page: currentPage, pageSize: pageSize, sorts: [["field":"createdOn", "order": "desc"]]) {[unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                if self.currentPage == 1 {
                    self.isLoadMore = true
                    self.listTransaction.removeAll()
                    self.listTransaction = [TransactionModel]()
                }
                if data.count < self.pageSize {
                    self.isLoadMore = false
                }
                for model in data {
                    self.listTransaction.append(model)
                }
                self.tbvHistory.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    func getListTransactionFilter(){
        UserManager.shareUserManager().getListTransactionFilter(page: currentPage, pageSize: pageSize, sorts: [["field":"createdOn", "order": "desc"]], ge: [["field":"createdOn", "value": "\(Int(self.fromDate ?? 0.0))"]], le: [["field":"createdOn", "value": "\(Int(self.toDate ?? 0.0))"]]) {[unowned self] (response) in
            switch response {
                
            case .success(let data):
                if self.currentPage == 1 {
                    self.isLoadMore = true
                    self.listTransaction.removeAll()
                    self.listTransaction = [TransactionModel]()
                }
                if data.count < self.pageSize {
                    self.isLoadMore = false
                }
                for model in data {
                    self.listTransaction.append(model)
                }
                self.tbvHistory.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
    @IBAction func touchFromDate(_ sender: Any) {
        self.view.endEditing(true)
        if vDatePicker == nil {
            vDatePicker = ViewDatePicker1.instanceFromNib()
            vDatePicker.datePicker.datePickerMode = .date
            vDatePicker.indexPosition = 1
            vDatePicker.tag = 11
            self.view.addSubview(vDatePicker)
            vDatePicker.delegate = self
        }
    }
    
    @IBAction func touchToDate(_ sender: Any) {
        self.view.endEditing(true)
        if vDatePicker == nil {
            vDatePicker = ViewDatePicker1.instanceFromNib()
            vDatePicker.datePicker.datePickerMode = .date
            vDatePicker.indexPosition = 2
            vDatePicker.tag = 11
            self.view.addSubview(vDatePicker)
            vDatePicker.delegate = self
        }
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listTransaction.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryLabelTableViewCell") as! HistoryLabelTableViewCell
        let model = self.listTransaction[indexPath.row]
        cell.lbTitleTransaction.text = "\(Settings.ShareInstance.translate(key: "label_transaction_type")):"
        cell.lbTitleMoney.text = "\(Settings.ShareInstance.translate(key: "label_amount")):"
        cell.lbTitleStatus.text = "\(Settings.ShareInstance.translate(key: "label_status"))"
        cell.lbTransaction.text = Settings.ShareInstance.translate(key: model.transactionType ?? "")
        cell.lbTitleDescription.text = "\(Settings.ShareInstance.translate(key: "label_description")):"
        cell.lbTitleDay.text = "\(Settings.ShareInstance.translate(key: "label_date")):"
        cell.lbStatus.text = Settings.ShareInstance.translate(key: model.status ?? "")
        cell.lbMoney.text = "\(Double(model.amount ?? "0")?.formatnumber() ?? "0") Godcoin"
        cell.lbDay.text = Settings.ShareInstance.convertTimeIntervalToDate(timeInterval: model.createdOn ?? 0.0)
        cell.lbDescription.text = model.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLoadMore {
            if indexPath.row == listTransaction.count - 3 {
                currentPage = currentPage + 1
                if fromDate ?? 0.0 > 0.0 {
                    self.getListTransactionFilter()
                }else {
                    self.getListTransaction()
                }
            }
        }
    }
}

extension HistoryViewController: ViewDatePicker1Protocol {
    
    func tapDone(_ index: Int) {
        print("tap done")
        let df = DateFormatter.init()
        df.locale = Locale.init(identifier: Settings.ShareInstance.getCurrentLanguage())
        df.dateFormat = "dd/MM/yyyy"
        if index == 1 {
            self.fromDate = Settings.ShareInstance.convertDateToTimeInterval(date: vDatePicker.datePicker.date)
            self.btFromDate.setTitle(df.string(from: vDatePicker.datePicker.date), for: .normal)
        }else {
            self.toDate = Settings.ShareInstance.convertDateToTimeInterval(date: vDatePicker.datePicker.date)
            self.btToDate.setTitle(df.string(from: vDatePicker.datePicker.date), for: .normal)
        }
        vDatePicker.viewWithTag(11)?.removeFromSuperview()
        vDatePicker = nil
    }
    
    func tapCancel() {
        print("tap cancel")
        vDatePicker.viewWithTag(11)?.removeFromSuperview()
        vDatePicker = nil
    }
    
    func tapGesture() {
        vDatePicker.viewWithTag(11)?.removeFromSuperview()
        vDatePicker = nil
    }
}
