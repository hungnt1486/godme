//
//  VotesTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 6/26/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class VotesTableViewCell: UITableViewCell {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbComment: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var vContent: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        self.vContent = Settings.ShareInstance.setupView(v: self.vContent)
    }
    
    func setupStar(index: Float){
        switch index {
        case 1:
            self.img1.image = UIImage.init(named: "ic_star_active_oranges")
            self.img2.image = UIImage.init(named: "ic_star_inactive_oranges")
            self.img3.image = UIImage.init(named: "ic_star_inactive_oranges")
            self.img4.image = UIImage.init(named: "ic_star_inactive_oranges")
            self.img5.image = UIImage.init(named: "ic_star_inactive_oranges")
            break
        case 2:
            self.img1.image = UIImage.init(named: "ic_star_active_oranges")
            self.img2.image = UIImage.init(named: "ic_star_active_oranges")
            self.img3.image = UIImage.init(named: "ic_star_inactive_oranges")
            self.img4.image = UIImage.init(named: "ic_star_inactive_oranges")
            self.img5.image = UIImage.init(named: "ic_star_inactive_oranges")
            break
        case 3:
            self.img1.image = UIImage.init(named: "ic_star_active_oranges")
            self.img2.image = UIImage.init(named: "ic_star_active_oranges")
            self.img3.image = UIImage.init(named: "ic_star_active_oranges")
            self.img4.image = UIImage.init(named: "ic_star_inactive_oranges")
            self.img5.image = UIImage.init(named: "ic_star_inactive_oranges")
            break
        case 4:
            self.img1.image = UIImage.init(named: "ic_star_active_oranges")
            self.img2.image = UIImage.init(named: "ic_star_active_oranges")
            self.img3.image = UIImage.init(named: "ic_star_active_oranges")
            self.img4.image = UIImage.init(named: "ic_star_active_oranges")
            self.img5.image = UIImage.init(named: "ic_star_inactive_oranges")
            break
        case 5:
            self.img1.image = UIImage.init(named: "ic_star_active_oranges")
            self.img2.image = UIImage.init(named: "ic_star_active_oranges")
            self.img3.image = UIImage.init(named: "ic_star_active_oranges")
            self.img4.image = UIImage.init(named: "ic_star_active_oranges")
            self.img5.image = UIImage.init(named: "ic_star_active_oranges")
            break
        default:
//            self.img1.image = UIImage.init(named: "ic_star_active_gray")
            break
        }
    }
    
}
