//
//  ServicesInfoBookTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class ServicesInfoBookTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbCoin: UILabel!
    @IBOutlet weak var lbStatusResult: UILabel!
    @IBOutlet weak var lbTimeResult: UILabel!
    @IBOutlet weak var lbCoinResult: UILabel!
    @IBOutlet weak var vContent: UIView!
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
