//
//  MainCollectionViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class Main1CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbCity: UILabel!
    @IBOutlet weak var lbTitleDetail: UILabel!
    @IBOutlet weak var vSubContent: UIView!
    @IBOutlet weak var lbGodcoin: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }
    
    func setupUI(){
        self.vContent = Settings.ShareInstance.setupView(v: self.vContent)
        self.vSubContent.layer.borderColor = UIColor.FlatColor.Gray.TextColor.cgColor
        self.vSubContent.layer.borderWidth = 0.5
    }

}
