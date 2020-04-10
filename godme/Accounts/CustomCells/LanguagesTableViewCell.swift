//
//  HelpTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 4/10/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class LanguagesTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imgChecked: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
