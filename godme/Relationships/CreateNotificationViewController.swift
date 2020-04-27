//
//  CreateNotificationViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/14/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class CreateNotificationViewController: BaseViewController {
    @IBOutlet weak var imgAddNew: UIImageView!
    @IBOutlet weak var tfInputTitle: UITextField!
    @IBOutlet weak var tvInputContent: UITextView!
    @IBOutlet weak var imgRelationships: UIImageView!
    @IBOutlet weak var lbRelationShips: UILabel!
    @IBOutlet weak var imgRelationShipsExpand: UIImageView!
    @IBOutlet weak var lbRelationShipsExpand: UILabel!
    @IBOutlet weak var btConfirm: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.configButtonBack()
    }
    
    func setupUI(){
        self.navigationItem.title = Settings.ShareInstance.translate(key: "label_notification")
        self.btConfirm = Settings.ShareInstance.setupButton(button: self.btConfirm)
        self.tfInputTitle = Settings.ShareInstance.setupTextField(textField: self.tfInputTitle, isLeftView: true)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(touchImgRelationShips))
        self.imgRelationships.isUserInteractionEnabled = true
        self.imgRelationships.addGestureRecognizer(tapGesture)
        
        self.lbRelationShips.isUserInteractionEnabled = true
        self.lbRelationShips.addGestureRecognizer(tapGesture)
        
        let tapGestureExpand = UITapGestureRecognizer.init(target: self, action: #selector(touchImgRelationShipsExpand))
        self.imgRelationShipsExpand.isUserInteractionEnabled = true
        self.imgRelationShipsExpand.addGestureRecognizer(tapGestureExpand)
        
        self.lbRelationShipsExpand.isUserInteractionEnabled = true
        self.lbRelationShipsExpand.addGestureRecognizer(tapGestureExpand)
    }
    
    @objc func touchImgRelationShips(){
        let img = UIImage(named: "ic_checked")
        if img == self.imgRelationships.image {
            self.imgRelationships.image = UIImage(named: "ic_uncheck")
        }else{
            self.imgRelationships.image = UIImage(named: "ic_checked")
        }
    }
    
    @objc func touchImgRelationShipsExpand(){
        let img = UIImage(named: "ic_checked")
        if img == self.imgRelationShipsExpand.image {
            self.imgRelationShipsExpand.image = UIImage(named: "ic_uncheck")
        }else{
            self.imgRelationShipsExpand.image = UIImage(named: "ic_checked")
        }
    }

    @IBAction func touchConfirm(_ sender: Any) {
        
    }

}
