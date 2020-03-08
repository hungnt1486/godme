//
//  HeaderMain.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import GSKStretchyHeaderView

class HeaderMain: GSKStretchyHeaderView {
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var lbCharity: UILabel!
    @IBOutlet weak var lbTotalMoney: UILabel!
    @IBOutlet weak var lbMoney: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup(){
        
    }
    
}
