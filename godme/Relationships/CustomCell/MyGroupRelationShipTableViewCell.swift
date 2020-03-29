//
//  MyServicesTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol MyGroupRelationShipTableViewCellProtocol {
    func didMoreGroupRelationShip(index: Int)
}

class MyGroupRelationShipTableViewCell: UITableViewCell {

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbCity: UILabel!
    @IBOutlet weak var lbVote: UILabel!
    @IBOutlet weak var vImgStar: UIView!
    @IBOutlet weak var imgMore: UIImageView!
    var vImgStars: VImageStars!
    var delegate: MyGroupRelationShipTableViewCellProtocol?
    var indexStar: Float = 0.0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        DispatchQueue.main.async {
        self.setupUI()
//        }
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(touchMore))
        self.imgMore.isUserInteractionEnabled = true
        self.imgMore.addGestureRecognizer(tapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func touchMore(){
        delegate?.didMoreGroupRelationShip(index: self.imgMore.tag)
    }
    
    func setupUI(){
        self.vContent = Settings.ShareInstance.setupView(v: self.vContent)
        vImgStars = VImageStars.instanceFromNib()
        
        self.vImgStar.addSubview(vImgStars)
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseOut, animations: {
            self.vImgStars.configVImageStars(frameView: self.vImgStar.frame, index: self.indexStar)
        }, completion: nil)
    }
    
}
