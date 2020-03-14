//
//  MyRelationShipExpandViewController.swift
//  godme
//
//  Created by fcsdev on 3/13/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class MyRelationShipExpandViewController: BaseViewController {

    @IBOutlet weak var vTop: UIView!
    @IBOutlet weak var tfInputName: UITextField!
    @IBOutlet weak var lbFilterJob: UILabel!
    @IBOutlet weak var tbvMyRelationShipExpand: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupTableView()
    }

    func setupUI(){
        self.vTop = Settings.ShareInstance.setupView(v: self.vTop)
        
        self.tfInputName = Settings.ShareInstance.setupTextField(textField: self.tfInputName, isLeftView: true)
    }

    func setupTableView(){
        self.tbvMyRelationShipExpand.register(UINib(nibName: "MyRelationShipTableViewCell", bundle: nil), forCellReuseIdentifier: "MyRelationShipTableViewCell")

        self.tbvMyRelationShipExpand.delegate = self
        self.tbvMyRelationShipExpand.dataSource = self
        self.tbvMyRelationShipExpand.separatorColor = UIColor.clear
        self.tbvMyRelationShipExpand.separatorInset = UIEdgeInsets.zero
        self.tbvMyRelationShipExpand.estimatedRowHeight = 300
        self.tbvMyRelationShipExpand.rowHeight = UITableView.automaticDimension
    }

}

extension MyRelationShipExpandViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRelationShipTableViewCell") as! MyRelationShipTableViewCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension MyRelationShipExpandViewController: MyRelationShipTableViewCellProtocol{
    func didMoreRelationShip(index: Int) {
        let alertControl = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let action2 = UIAlertAction.init(title: "Ẩn mối quan hệ", style: .default) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        let action3 = UIAlertAction.init(title: "Báo xấu", style: .default) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        let action4 = UIAlertAction.init(title: "Xoá mối quan hệ", style: .default) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction.init(title: "Huỷ", style: .cancel) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        
        alertControl.addAction(action2)
        alertControl.addAction(action3)
        alertControl.addAction(action4)
        alertControl.addAction(actionCancel)
        self.navigationController?.present(alertControl, animated: true, completion: nil)
    }
}
