//
//  TypeCarTableViewCell.swift
//  hune
//
//  Created by Apple on 9/11/19.
//  Copyright © 2019 Tien. All rights reserved.
//

import UIKit

protocol JobTableViewCellProtocol {
//    func eventGetTextEditProfile(_ string: String, type: typeCellEditProfile, index: Int)
    func showPopup()
}

class JobTableViewCell: UITableViewCell {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTypeCar: UILabel!
    
    var delegate: JobTableViewCellProtocol?
    
    var arr: [[String: String]] = []// ["Bán xe", "Mua xe", "Cho thuê", "Cầm xe"]
    var arrString = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
            self.setupUI()
        }
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(showType))
        self.lbTypeCar.addGestureRecognizer(tapGesture)
        self.lbTypeCar.isUserInteractionEnabled = true
    }
    
    func setupUI(){
//        self.lbTypeCar = Settings.ShareInstance.setupBTLabelView(v: self.lbTypeCar)
    }
    
    @objc func showType(){
        delegate?.showPopup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
