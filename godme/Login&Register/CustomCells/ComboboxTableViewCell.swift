//
//  ComboboxTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/4/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

@objc protocol ComboboxTableViewCellProtocol {
    @objc optional
    func didTouch()
}

class ComboboxTableViewCell: UITableViewCell {

    @IBOutlet weak var tfText: UITextField!
    @IBOutlet weak var btShow: UIButton!
    var delegate: ComboboxTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }
    
    func setupUI(){
        self.tfText = Settings.ShareInstance.setupTextField(textField: self.tfText)
        self.tfText.ShadowTextField()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func touchShow(_ sender: Any) {
        delegate?.didTouch?()
    }
}
