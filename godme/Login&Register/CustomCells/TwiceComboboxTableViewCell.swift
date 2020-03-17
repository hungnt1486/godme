//
//  TwiceComboboxTableViewCell.swift
//  godme
//
//  Created by fcsdev on 3/4/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import DropDown

@objc protocol TwiceComboboxTableViewCellProtocol{
    @objc optional
    func didTouch1()
    @objc optional
    func didTouch2()
}

class TwiceComboboxTableViewCell: UITableViewCell {

    @IBOutlet weak var tfText1: UITextField!
    @IBOutlet weak var btShow1: UIButton!
    @IBOutlet weak var tfText2: UITextField!
    @IBOutlet weak var btShow2: UIButton!
    var TypeDropdown = DropDown()
    var delegate: TwiceComboboxTableViewCellProtocol?
    var arr:[String] = ["Bán xe", "Mua xe", "Cho thuê", "Cầm xe"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        self.tfText1 = Settings.ShareInstance.setupTextField(textField: self.tfText1)
        self.tfText2 = Settings.ShareInstance.setupTextField(textField: self.tfText2)
        self.tfText1.ShadowTextField()
        self.tfText2.ShadowTextField()
        self.tfText1.isUserInteractionEnabled = false
        self.tfText2.isUserInteractionEnabled = false
    }
    
    func setupTypeDropdown(){
            TypeDropdown.anchorView = self.btShow1
            TypeDropdown.bottomOffset = CGPoint(x: 0, y: self.btShow1.bounds.height)
//            for item in arr {
//                arrString.append(item.Name!)
//            }
            let typeDataSource = arr//arrString
            TypeDropdown.dataSource = typeDataSource
            TypeDropdown.selectionAction = { [unowned self] (index, item) in
                self.tfText1.text = item
    //            self.btChooseType.tag = index
//                self.delegate?.eventGetTextTypeCar(item, index: index)
//                self.delegate?.eventGetTextWithType?(item, type: typeCellPost(rawValue: self.lbTypeCar.tag)!, index: index)
//                self.delegate?.eventGetTextWithRealEstate?(item, type: typeCellRealEstate(rawValue: self.lbTypeCar.tag)!, index: index)
//                self.delegate?.eventGetTextWithTour?(item, type: typeCellTour(rawValue: self.lbTypeCar.tag)!, index: index)
//                self.delegate?.eventGetTextWithBeauty?(item, type: typeCellBeauty(rawValue: self.lbTypeCar.tag)!, index: index)
//                self.delegate?.eventGetTextWithShop?(item, type: typeCellStore(rawValue: self.lbTypeCar.tag)!, index: index)
//                self.delegate?.eventGetTextWithPromotion?(item, type: typeCellPromotion(rawValue: self.lbTypeCar.tag)!, index: index)
            }
        }
        
        @objc func showType(){
            print("thanh cong")
            TypeDropdown.show()
        }
    
    @IBAction func touchShow1(_ sender: Any) {
        self.showType()
    }
    
    @IBAction func touchShow2(_ sender: Any) {
        
    }
    
}
