//
//  DefaultTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/30/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class DefaultTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lbTitle.text = Settings.ShareInstance.translate(key: "label_you_dont_have_services")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
