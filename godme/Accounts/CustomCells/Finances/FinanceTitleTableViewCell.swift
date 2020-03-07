//
//  FinanceTitleTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class FinanceTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var lbConvertCurrent: UILabel!
    @IBOutlet weak var lbTotalCoin: UILabel!
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
        self.lbConvertCurrent = Settings.ShareInstance.setupLabel(label: self.lbConvertCurrent)
    }
    
}
