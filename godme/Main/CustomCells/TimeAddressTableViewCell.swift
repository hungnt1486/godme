//
//  TimeAddressTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/9/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class TimeAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbLanguages: UILabel!
    @IBOutlet weak var lbNumberBooked: UILabel!
    @IBOutlet weak var contraintHeightV1: NSLayoutConstraint!
    @IBOutlet weak var v1: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
