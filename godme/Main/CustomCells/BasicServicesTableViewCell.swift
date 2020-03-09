//
//  MyServicesTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class BasicServicesTableViewCell: UITableViewCell {

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbCity: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbCoin: UILabel!
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
        self.vContent = Settings.ShareInstance.setupView(v: self.vContent)
    }
    
}
