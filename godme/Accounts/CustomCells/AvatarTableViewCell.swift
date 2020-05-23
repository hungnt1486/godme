//
//  AvatarTableViewCell.swift
//  hune
//
//  Created by fcsdev on 9/20/19.
//  Copyright © 2019 Tien. All rights reserved.
//

import UIKit

protocol AvatarTableViewCellProtocol {
    func didImg()
    func didCopy()
}

class AvatarTableViewCell: UITableViewCell {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbCode: UILabel!
    @IBOutlet weak var lbCopy: UILabel!
    @IBOutlet weak var lbFullname: UILabel!
    @IBOutlet weak var lbPlus: UILabel!
    @IBOutlet weak var icKey1: UIImageView!
    var delegate: AvatarTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapImg = UITapGestureRecognizer.init(target: self, action: #selector(touchImg))
        tapImg.numberOfTapsRequired = 1
        imgAvatar.isUserInteractionEnabled = true
        imgAvatar.addGestureRecognizer(tapImg)
        imgAvatar.layer.cornerRadius = self.imgAvatar.frame.height/2
        imgAvatar.layer.borderWidth = 0
        imgAvatar.clipsToBounds = true
        self.lbCopy.text = "Sao chép Affiliate"
        let tapcopy = UITapGestureRecognizer.init(target: self, action: #selector(touchCopy))
        self.lbCopy.isUserInteractionEnabled = true
        self.lbCopy.addGestureRecognizer(tapcopy)
    }
    
    @objc func touchImg(){
        delegate?.didImg()
    }
    
    @objc func touchCopy(){
        delegate?.didCopy()
    }
    
    func didUpdateImg(img: UIImage){
        imgAvatar.image = img
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
