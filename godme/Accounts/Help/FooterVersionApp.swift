//
//  FooterVersionApp.swift
//  godme
//
//  Created by Lê Hùng on 5/14/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class FooterVersionApp: UITableViewHeaderFooterView {

    @IBOutlet weak var lbVersion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let v = UIView()
        v.backgroundColor = UIColor.white
        self.backgroundView = v
    }
}
