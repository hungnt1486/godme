//
//  MyServicesTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class SearchBarTableViewCell: UITableViewCell {

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbCity: UILabel!
    @IBOutlet weak var lbVote: UILabel!
    @IBOutlet weak var vImgStar: UIView!
    var vImgStars: VImageStarsOranges!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var imgGender: UIImageView!
    var indexStar: Float = 0.0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        DispatchQueue.main.async {
//            self.setupUI()
//        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        self.lbVote.text = Settings.ShareInstance.translate(key: "label_rate")
        self.vContent = Settings.ShareInstance.setupView(v: self.vContent)
        vImgStars = VImageStarsOranges.instanceFromNib()
        
        self.vImgStar.addSubview(vImgStars)
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseOut, animations: {
            self.vImgStars.configVImageStarsOranges(frameView: self.vImgStar.frame, index: self.indexStar)
        }, completion: nil)
    }
    
}
