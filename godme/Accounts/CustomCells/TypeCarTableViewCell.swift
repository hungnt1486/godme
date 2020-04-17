//
//  TypeCarTableViewCell.swift
//  hune
//
//  Created by Apple on 9/11/19.
//  Copyright © 2019 Tien. All rights reserved.
//

import UIKit
import DropDown

@objc protocol TypeCarTableViewCellProtocol {
    @objc optional
    func eventGetTextTypeCreateService(_ string: String, type: typeCellCreateService1, index: Int)
    @objc optional
    func eventGetTextTypeCreateAuctionService(_ string: String, type: typeCellCreateAuction, index: Int)
    @objc optional
    func eventGetTextTypeCreateEventService(_ string: String, type: typeCellCreateEvent, index: Int)
    @objc optional
    func eventGetTextTypeCar(_ string: String, index: Int)
    
    func eventGetTextEditProfile(_ string: String, type: typeCellEditProfile, index: Int)
    
//    @objc optional
//    func eventGetTextWithType(_ string: String, type: typeCellPost, index: Int)
//    @objc optional
//    func eventGetTextWithRealEstate(_ string: String, type: typeCellRealEstate, index: Int)
//    @objc optional
//    func eventGetTextWithTour(_ string: String, type: typeCellTour, index: Int)
//    @objc optional
//    func eventGetTextWithBeauty(_ string: String, type: typeCellBeauty, index: Int)
//    @objc optional
//    func eventGetTextWithShop(_ string: String, type: typeCellStore, index: Int)
//    @objc optional
//    func eventGetTextWithPromotion(_ string: String, type: typeCellPromotion, index: Int)
}

class TypeCarTableViewCell: UITableViewCell {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTypeCar: UILabel!
    
    var TypeDropdown = DropDown()
    var delegate: TypeCarTableViewCellProtocol?
    
    var arr: [[String: String]] = []// ["Bán xe", "Mua xe", "Cho thuê", "Cầm xe"]
    var arrString = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupTypeDropdown()
        DispatchQueue.main.async {
            self.setupUI()
        }
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(showType))
        self.lbTypeCar.addGestureRecognizer(tapGesture)
        self.lbTypeCar.isUserInteractionEnabled = true
    }
    
    func setupUI(){
        self.lbTypeCar = Settings.ShareInstance.setupBTLabelView(v: self.lbTypeCar)
    }
    
    func setupTypeDropdown(){
        TypeDropdown.anchorView = self.lbTypeCar
        TypeDropdown.bottomOffset = CGPoint(x: 0, y: self.lbTypeCar.bounds.height)
        for item in arr {
            arrString.append(item["name"] ?? "")
        }
        let typeDataSource = arrString
        TypeDropdown.dataSource = typeDataSource
        TypeDropdown.selectionAction = { [unowned self] (index, item) in
            self.lbTypeCar.text = item
            self.delegate?.eventGetTextEditProfile(item, type: typeCellEditProfile(rawValue: self.lbTypeCar.tag)!, index: index)
            self.delegate?.eventGetTextTypeCar?(item, index: index)
            self.delegate?.eventGetTextTypeCreateService?(item, type: typeCellCreateService1(rawValue: self.lbTypeCar.tag)!, index: index)
            self.delegate?.eventGetTextTypeCreateAuctionService?(item, type: typeCellCreateAuction(rawValue: self.lbTypeCar.tag)!, index: index)
            self.delegate?.eventGetTextTypeCreateEventService?(item, type: typeCellCreateEvent(rawValue: self.lbTypeCar.tag)!, index: index)
        }
    }
    
    @objc func showType(){
        print("thanh cong")
        TypeDropdown.show()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
