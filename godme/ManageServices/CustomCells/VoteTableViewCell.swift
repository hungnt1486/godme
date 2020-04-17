//
//  VoteTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 4/17/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol VoteTableViewCellProtocol {
    func didImg1()
    func didImg2()
    func didImg3()
    func didImg4()
    func didImg5()
}

class VoteTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbResult: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    var delegate: VoteTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }
    
    func setupUI(){
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(touchImg1))
        self.img1.isUserInteractionEnabled = true
        self.img1.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(touchImg2))
        self.img2.isUserInteractionEnabled = true
        self.img2.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer.init(target: self, action: #selector(touchImg3))
        self.img3.isUserInteractionEnabled = true
        self.img3.addGestureRecognizer(tap3)
        let tap4 = UITapGestureRecognizer.init(target: self, action: #selector(touchImg4))
        self.img4.isUserInteractionEnabled = true
        self.img4.addGestureRecognizer(tap4)
        let tap5 = UITapGestureRecognizer.init(target: self, action: #selector(touchImg5))
        self.img5.isUserInteractionEnabled = true
        self.img5.addGestureRecognizer(tap5)
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
    
    @objc func touchImg1(){
        delegate?.didImg1()
    }
    
    @objc func touchImg2(){
        delegate?.didImg2()
    }
    @objc func touchImg3(){
        delegate?.didImg3()
    }
    @objc func touchImg4(){
        delegate?.didImg4()
    }
    @objc func touchImg5(){
        delegate?.didImg5()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
