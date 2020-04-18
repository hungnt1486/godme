//
//  InputTextTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/4/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

@objc protocol InputTextTableViewCellProtocol {
    @objc optional
    func getTextInput(_ string: String)
    @objc optional
    func getTextInput(_ string: String, type: typeCellRegister)
}

class InputTextTableViewCell: UITableViewCell {

    @IBOutlet weak var tfText: UITextField!
    var delegate:InputTextTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }
    
    func setupUI(){
        self.tfText = Settings.ShareInstance.setupTextField(textField: self.tfText)
        self.tfText.ShadowTextField()
        self.tfText.addTarget(self, action: #selector(tfTextDidChange(_:)), for: .editingChanged)
    }
    
    @objc func tfTextDidChange(_ textField: UITextField){
        self.getPriceText(string: textField.text ?? "")
    }
    
    @objc func getPriceText(string: String){
        delegate?.getTextInput?(string, type: typeCellRegister(rawValue: self.tfText.tag)!)
        delegate?.getTextInput?(string)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
