//
//  ComboboxTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/4/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import DropDown

@objc protocol ComboboxTableViewCellProtocol {
    @objc optional
    func hideKeyboardCombobox()
    @objc optional
    func didTouch(str: String, type: typeCellRegister, index: Int)
    
    @objc optional
    func didTouchSearchMain(str: String, type: typeCellSearchMain, index: Int)
}

class ComboboxTableViewCell: UITableViewCell {

    
    var TypeDropdown = DropDown()
    var arrString:[String] = []
    var arr: [[String:String]] = []
    
    @IBOutlet weak var tfText: UITextField!
    @IBOutlet weak var btShow: UIButton!
    var delegate: ComboboxTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
        
        self.setupTypeDropdown()
    }
    
    func setupUI(){
        self.tfText = Settings.ShareInstance.setupTextField(textField: self.tfText)
        self.tfText.ShadowTextField()
        self.tfText.isUserInteractionEnabled = false
    }
    
    func setupTypeDropdown(){
        TypeDropdown.anchorView = self.btShow
        TypeDropdown.bottomOffset = CGPoint(x: 0, y: self.btShow.bounds.height)
            for item in arr {
                arrString.append(item["name"] ?? "")
            }
        let typeDataSource = arrString
        TypeDropdown.dataSource = typeDataSource
        TypeDropdown.selectionAction = { [unowned self] (index, item) in
            self.tfText.text = item
            self.delegate?.didTouch?(str: item, type: typeCellRegister(rawValue: self.btShow.tag)!, index: index)
            self.delegate?.didTouchSearchMain?(str: item, type: typeCellSearchMain(rawValue: self.btShow.tag)!, index: index)
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
        
    func showType(){
        print("thanh cong")
        TypeDropdown.show()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func touchShow(_ sender: Any) {
        delegate?.hideKeyboardCombobox?()
        self.showType()
    }
}
