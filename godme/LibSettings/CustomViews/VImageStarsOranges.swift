//
//  VImageStars.swift
//  godme
//
//  Created by Lê Hùng on 3/11/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit


class VImageStarsOranges: UIView {

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    
    
    class func instanceFromNib() ->VImageStarsOranges{
        return UINib.init(nibName: "VImageStarsOranges", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! VImageStarsOranges
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configVImageStarsOranges(frameView: CGRect, index: Float = 1.0) {
        self.setupUI(index: index)
        self.frame = CGRect(x: 0, y: 0, width: frameView.size.width, height: frameView.size.height)
    }
    
    func setupUI(index: Float){
        switch index {
        case 1:
            self.img1.image = UIImage.init(named: "ic_star_active_oranges")
            break
        case 2:
            self.img1.image = UIImage.init(named: "ic_star_active_oranges")
            self.img2.image = UIImage.init(named: "ic_star_active_oranges")
            break
        case 3:
            self.img1.image = UIImage.init(named: "ic_star_active_oranges")
            self.img2.image = UIImage.init(named: "ic_star_active_oranges")
            self.img3.image = UIImage.init(named: "ic_star_active_oranges")
            break
        case 4:
            self.img1.image = UIImage.init(named: "ic_star_active_oranges")
            self.img2.image = UIImage.init(named: "ic_star_active_oranges")
            self.img3.image = UIImage.init(named: "ic_star_active_oranges")
            self.img4.image = UIImage.init(named: "ic_star_active_oranges")
            break
        case 5:
            self.img1.image = UIImage.init(named: "ic_star_active_oranges")
            self.img2.image = UIImage.init(named: "ic_star_active_oranges")
            self.img3.image = UIImage.init(named: "ic_star_active_oranges")
            self.img4.image = UIImage.init(named: "ic_star_active_oranges")
            self.img5.image = UIImage.init(named: "ic_star_active_oranges")
            break
        default:
//            self.img1.image = UIImage.init(named: "ic_star_active_oranges")
            break
        }
    }

}
