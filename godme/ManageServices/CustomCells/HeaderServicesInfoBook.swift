//
//  HeaderMyServices.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class HeaderServicesInfoBook: UITableViewHeaderFooterView {

    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let v = UIView()
        v.backgroundColor = UIColor.FlatColor.Gray.BGColor
        self.backgroundView = v
    }
}
