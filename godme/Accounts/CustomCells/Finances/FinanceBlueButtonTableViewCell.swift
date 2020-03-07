//
//  FinanceBlueButtonTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol FinanceBlueButtonTableViewCellProtocol {
    func didButtonBlue(type: typeCellFinance)
}

class FinanceBlueButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var btBlue: UIButton!
    var delegate: FinanceBlueButtonTableViewCellProtocol?
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
        self.btBlue = Settings.ShareInstance.setupButton(button: self.btBlue)
    }
    
    @IBAction func touchBlue(_ sender: Any) {
        delegate?.didButtonBlue(type: typeCellFinance(rawValue: self.btBlue.tag)!)
    }
}
