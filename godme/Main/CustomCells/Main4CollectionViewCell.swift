//
//  Main2CollectionViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol Main4CollectionViewCellProtocol {
    func didJoin4(index: Int)
}

class Main4CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbCity: UILabel!
    @IBOutlet weak var lbNumberRegister: UILabel!
    @IBOutlet weak var lbFee: UILabel!
    @IBOutlet weak var btJoin: UIButton!
    @IBOutlet weak var vSubContent: UIView!
    var delegate: Main4CollectionViewCellProtocol?
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

    @IBAction func touchJoin(_ sender: Any) {
        delegate?.didJoin4(index: self.btJoin.tag)
    }
}
