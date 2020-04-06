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
    func eventGetTextTypeCar(_ string: String, index: Int)
    
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
    
    var arr = ["Bán xe", "Mua xe", "Cho thuê", "Cầm xe"]
    var arrString = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupTypeDropdown()
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(showType))
        self.lbTypeCar.addGestureRecognizer(tapGesture)
        self.lbTypeCar.isUserInteractionEnabled = true
    }
    
    func setupTypeDropdown(){
        TypeDropdown.anchorView = self.lbTypeCar
        TypeDropdown.bottomOffset = CGPoint(x: 0, y: self.lbTypeCar.bounds.height)
//        for item in arr {
//            arrString.append(item.Name!)
//        }
        let typeDataSource = arrString
        TypeDropdown.dataSource = typeDataSource
        TypeDropdown.selectionAction = { [unowned self] (index, item) in
            self.lbTypeCar.text = item
//            self.btChooseType.tag = index
            self.delegate?.eventGetTextTypeCar(item, index: index)
//            self.delegate?.eventGetTextWithType?(item, type: typeCellPost(rawValue: self.lbTypeCar.tag)!, index: index)
//            self.delegate?.eventGetTextWithRealEstate?(item, type: typeCellRealEstate(rawValue: self.lbTypeCar.tag)!, index: index)
//            self.delegate?.eventGetTextWithTour?(item, type: typeCellTour(rawValue: self.lbTypeCar.tag)!, index: index)
//            self.delegate?.eventGetTextWithBeauty?(item, type: typeCellBeauty(rawValue: self.lbTypeCar.tag)!, index: index)
//            self.delegate?.eventGetTextWithShop?(item, type: typeCellStore(rawValue: self.lbTypeCar.tag)!, index: index)
//            self.delegate?.eventGetTextWithPromotion?(item, type: typeCellPromotion(rawValue: self.lbTypeCar.tag)!, index: index)
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
