//
//  Main2CollectionViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class Main6CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var vSubContent: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }
    
    func setupUI(){
//        self.vContent = Settings.ShareInstance.setupView(v: self.vContent)
        self.vSubContent.layer.borderColor = UIColor.FlatColor.Gray.TextColor.cgColor
        self.vSubContent.layer.borderWidth = 0.5
    }
}
