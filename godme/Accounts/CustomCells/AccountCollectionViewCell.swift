//
//  HomeCollectionViewCell.swift
//  hune
//
//  Created by Lê Hùng on 9/4/19.
//  Copyright © 2019 Tien. All rights reserved.
//

import UIKit

class AccountCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
//        vBG = Singleton.shared.setupView(v: vBG)
//        vBG.layer.borderColor = UIColor.FlatColor.Blue.BGHOME.cgColor
//        vBG.layer.cornerRadius = 20.0
//        vBG.clipsToBounds = true
//        viewShadow.layer.cornerRadius = 5.0
//        viewShadow.layer.borderColor = "278BED".colorFromHexString().withAlphaComponent(0.1).cgColor
//        viewShadow.layer.borderWidth = 1.0
//        viewShadow.clipsToBounds = true
//        shadow(viewShadow)
    }

}
