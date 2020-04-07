//
//  FollowTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class FollowTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitleConnect: UILabel!
    @IBOutlet weak var lbConnect: UILabel!
    @IBOutlet weak var lbTitleRelationShip: UILabel!
    @IBOutlet weak var lbRelationShip: UILabel!
    @IBOutlet weak var lbTitleService: UILabel!
    @IBOutlet weak var lbService: UILabel!
    @IBOutlet weak var lbTitleAuction: UILabel!
    @IBOutlet weak var lbAuction: UILabel!
    @IBOutlet weak var lbTitleEvent: UILabel!
    @IBOutlet weak var lbEvent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
