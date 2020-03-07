//
//  WithDraw1TableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol WithDraw1TableViewCellProtocol {
    func getTextWithDraw(_ text: String, type: typeCellWithDraw)
}

class WithDraw1TableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfInput: UITextField!
    var delegate: WithDraw1TableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
        self.tfInput.addTarget(self, action: #selector(getTextWithDraw(string:)), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        self.tfInput = Settings.ShareInstance.setupTextFieldRadius(textField: self.tfInput, isLeftView: true)
    }
    
    @objc func getTextWithDraw(string: String){
        delegate?.getTextWithDraw(string, type: typeCellWithDraw(rawValue: self.tfInput.tag)!)
    }
    
}
