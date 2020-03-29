//
//  VImageStars.swift
//  godme
//
//  Created by Lê Hùng on 3/11/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit


class VImageStars: UIView {

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    
    
    class func instanceFromNib() ->VImageStars{
        return UINib.init(nibName: "VImageStars", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! VImageStars
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configVImageStars(frameView: CGRect, index: Float = 1.0) {
        self.setupUI(index: index)
        self.frame = CGRect(x: 0, y: 0, width: frameView.size.width, height: frameView.size.height)
    }
    
    func setupUI(index: Float){
        switch index {
        case 1:
            self.img1.image = UIImage.init(named: "ic_star_active_gray")
            break
        case 2:
            self.img1.image = UIImage.init(named: "ic_star_active_gray")
            self.img2.image = UIImage.init(named: "ic_star_active_gray")
            break
        case 3:
            self.img1.image = UIImage.init(named: "ic_star_active_gray")
            self.img2.image = UIImage.init(named: "ic_star_active_gray")
            self.img3.image = UIImage.init(named: "ic_star_active_gray")
            break
        case 4:
            self.img1.image = UIImage.init(named: "ic_star_active_gray")
            self.img2.image = UIImage.init(named: "ic_star_active_gray")
            self.img3.image = UIImage.init(named: "ic_star_active_gray")
            self.img4.image = UIImage.init(named: "ic_star_active_gray")
            break
        case 5:
            self.img1.image = UIImage.init(named: "ic_star_active_gray")
            self.img2.image = UIImage.init(named: "ic_star_active_gray")
            self.img3.image = UIImage.init(named: "ic_star_active_gray")
            self.img4.image = UIImage.init(named: "ic_star_active_gray")
            self.img5.image = UIImage.init(named: "ic_star_active_gray")
            break
        default:
//            self.img1.image = UIImage.init(named: "ic_star_active_gray")
            break
        }
//        self.vContent = Settings.ShareInstance.setupBTV(v: self.vContent)
//        let tapGesture = UIGestureRecognizer.init(target: self, action: #selector(touchSearch))
//        self.lbTitle.isUserInteractionEnabled = true
//        self.iconSearch.isUserInteractionEnabled = true
//        self.lbTitle.addGestureRecognizer(tapGesture)
//        self.iconSearch.addGestureRecognizer(tapGesture)
    }

}
