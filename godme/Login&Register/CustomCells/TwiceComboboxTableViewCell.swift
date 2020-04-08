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
    func didShowListJob()
    @objc optional
    func didShowDate()
    @objc optional
    func didTouch1(_ index: Int, type: typeCellRegister, str: String)
    @objc optional
    func didTouch2(_ index: Int, type: typeCellRegister, str: String)
}

class TwiceComboboxTableViewCell: UITableViewCell {

    @IBOutlet weak var tfText1: UITextField!
    @IBOutlet weak var btShow1: UIButton!
    @IBOutlet weak var tfText2: UITextField!
    @IBOutlet weak var btShow2: UIButton!
    var TypeDropdown = DropDown()
    var TypeDropdownSub = DropDown()
    var delegate: TwiceComboboxTableViewCellProtocol?
    var arr:[[String: String]] = []//["Bán xe", "Mua xe", "Cho thuê", "Cầm xe"]
    var arrString: [String] = []
    
    var arrSub:[[String: String]] = []
    var arrStringSub: [String] = []
    
    var isListJob: Int = 0 // = 0 show list string, = 1 show list job, = 2 show date picker
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
        for item in arr {
            arrString.append(item["name"]!)
        }
        let typeDataSource = arrString
        TypeDropdown.dataSource = typeDataSource
        TypeDropdown.selectionAction = { [unowned self] (index, item) in
            self.tfText1.text = item
            self.delegate?.didTouch1?(index, type: typeCellRegister(rawValue: self.btShow1.tag)!, str: item)
        }
    }
    
    func setupTypeDropdownSub(){
        TypeDropdownSub.anchorView = self.btShow2
        TypeDropdownSub.bottomOffset = CGPoint(x: 0, y: self.btShow2.bounds.height)
        for item in arrSub {
            arrStringSub.append(item["name"]!)
        }
        let typeDataSource = arrStringSub
        TypeDropdownSub.dataSource = typeDataSource
        TypeDropdownSub.selectionAction = { [unowned self] (index, item) in
            self.tfText2.text = item
            self.delegate?.didTouch2?(index, type: typeCellRegister(rawValue: self.btShow2.tag)!, str: item)
        }
    }
        
    @objc func showTypeSub(){
        print("thanh cong")
        TypeDropdownSub.show()
    }
    
    @objc func showType(){
        print("thanh cong")
        TypeDropdown.show()
    }
    
    @IBAction func touchShow1(_ sender: Any) {
        if isListJob == 1 {
            delegate?.didShowListJob?()
        }else if isListJob == 2 {
            delegate?.didShowDate?()
        }else{
            self.showType()
        }
    }
    
    @IBAction func touchShow2(_ sender: Any) {
        self.showTypeSub()
    }
    
}
