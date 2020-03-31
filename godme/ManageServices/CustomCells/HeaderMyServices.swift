//
//  HeaderMyServices.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class HeaderMyServices: UITableViewHeaderFooterView {

    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let v = UIView()
        v.backgroundColor = UIColor.FlatColor.Gray.BGColor
        self.backgroundView = v
        DispatchQueue.main.async {
            self.setupUI()
        }
    }
    
    func setupUI(){
        self.lbTitle = Settings.ShareInstance.setupBTLabelView(v: self.lbTitle)
    }
}
