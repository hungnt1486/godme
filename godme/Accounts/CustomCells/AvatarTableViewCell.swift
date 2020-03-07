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
}

class AvatarTableViewCell: UITableViewCell {

    @IBOutlet weak var imgAvatar: UIImageView!
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
    }
    
    @objc func touchImg(){
        delegate?.didImg()
    }
    
    func didUpdateImg(img: UIImage){
        imgAvatar.image = img
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
