//
//  TitleTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/15/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

@objc protocol Title1TableViewCellProtocol {
    @objc optional
    func getTextBaseService1(_ str: String, type: typeCellCreateService1)
}

class Title1TableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfInput: UITextField!
    var delegate: Title1TableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        DispatchQueue.main.async {
            self.setupUI()
        }
        self.tfInput.addTarget(self, action: #selector(getText), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func getText(){
        delegate?.getTextBaseService1?(self.tfInput.text ?? "", type: typeCellCreateService1(rawValue: self.tfInput.tag)!)
    }
    
    func setupUI(){
        self.tfInput = Settings.ShareInstance.setupBTView(v: self.tfInput)
    }
    
}
