//
//  ListHiddenViewController.swift
//  godme
//
//  Created by fcsdev on 3/13/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class ListHiddenViewController: BaseViewController {

    @IBOutlet weak var vTop: UIView!
    @IBOutlet weak var tbvListHidden: UITableView!
    @IBOutlet weak var tfInputName: UITextField!
    @IBOutlet weak var lbFilterJob: UILabel!
    var listHidden: [RelationShipsModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.setupTableView()
        self.getListHidden()
    }
    
    func setupUI(){
        self.vTop = Settings.ShareInstance.setupView(v: self.vTop)
        
        self.tfInputName = Settings.ShareInstance.setupTextField(textField: self.tfInputName, isLeftView: true)
    }

    func setupTableView(){
        self.tbvListHidden.register(UINib(nibName: "MyRelationShipTableViewCell", bundle: nil), forCellReuseIdentifier: "MyRelationShipTableViewCell")

        self.tbvListHidden.delegate = self
        self.tbvListHidden.dataSource = self
        self.tbvListHidden.separatorColor = UIColor.clear
        self.tbvListHidden.separatorInset = UIEdgeInsets.zero
        self.tbvListHidden.estimatedRowHeight = 300
        self.tbvListHidden.rowHeight = UITableView.automaticDimension
    }
    
    func getListHidden(){
        RelationShipsManager.shareRelationShipsManager().getListHiden { [unowned self] (response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                
                for model in data {
                    self.listHidden.append(model)
                }
                self.tbvListHidden.reloadData()
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }

}

extension ListHiddenViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listHidden.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRelationShipTableViewCell") as! MyRelationShipTableViewCell
        cell.delegate = self
        
        let model = listHidden[indexPath.row]
        cell.imgAvatar.sd_setImage(with: URL.init(string: model.avatar ?? ""), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
            if error == nil {
                cell.imgAvatar.image = image
            }
        }
        cell.lbEmail.text = "Email: \(model.email ?? "")"
        cell.lbPhone.text = "Số điện thoại: \(model.phoneNumber ?? "")"
        cell.lbTitle.text = model.fullName
        cell.lbCity.text = "Địa chỉ: \(model.address ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension ListHiddenViewController: MyRelationShipTableViewCellProtocol{
    func didMoreRelationShip(index: Int) {
        let alertControl = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let action2 = UIAlertAction.init(title: "Hiển thị mối quan hệ", style: .default) { (action) in
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
