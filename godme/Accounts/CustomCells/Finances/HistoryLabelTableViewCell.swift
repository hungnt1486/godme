//
//  HistoryLabelTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class HistoryLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitleTransaction: UILabel!
    @IBOutlet weak var lbTransaction: UILabel!
    @IBOutlet weak var lbTitleMoney: UILabel!
    @IBOutlet weak var lbMoney: UILabel!
    @IBOutlet weak var lbTitleDay: UILabel!
    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var lbTitleStatus: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbTitleDescription: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

