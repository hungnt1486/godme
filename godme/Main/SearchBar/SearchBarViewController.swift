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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupUI(){
        self.tfJob = Settings.ShareInstance.setupTextField(textField: self.tfJob, isLeftView: true)
        self.tfLocation = Settings.ShareInstance.setupTextField(textField: self.tfLocation, isLeftView: true)
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(touchSearch))
        self.imgSearch.isUserInteractionEnabled = true
        self.imgSearch.addGestureRecognizer(tapGesture)
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
    
    @objc func touchSearch(){
        print("search")
    }

    @IBAction func touchCancel(_ sender: Any) {
        self.navigationItem.hidesBackButton = true
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

extension SearchBarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBarTableViewCell") as! SearchBarTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detail = SearchBarDetailViewController()
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    
}
