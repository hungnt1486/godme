//
//  MyServicesTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol MyRelationShip1TableViewCellProtocol {
    func didMoreRelationShip(index: Int)
    func didEmail(index: Int)
    func didPhoneNumber(index: Int)
}

class MyRelationShip1TableViewCell: UITableViewCell {

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbCity: UILabel!
    @IBOutlet weak var lbVote: UILabel!
    @IBOutlet weak var vImgStar: UIView!
    @IBOutlet weak var lbCoin: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var imgMore: UIImageView!
    @IBOutlet weak var imgPhone: UIImageView!
    @IBOutlet weak var lbDayLeft: UILabel!
    var vImgStars: VImageStars!
    var delegate: MyRelationShip1TableViewCellProtocol?
    var indexStar: Float = 0.0
    @IBOutlet weak var constraintHeightPhone: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        DispatchQueue.main.async {
//        self.setupUI()
//        }
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(touchMore))
        self.imgMore.isUserInteractionEnabled = true
        self.imgMore.addGestureRecognizer(tapGesture)
        let tapEmail = UITapGestureRecognizer.init(target: self, action: #selector(touchEmail))
        self.lbEmail.isUserInteractionEnabled = true
        self.lbEmail.addGestureRecognizer(tapEmail)
        let tapPhoneNumber = UITapGestureRecognizer.init(target: self, action: #selector(touchPhoneNumber))
        self.lbPhone.isUserInteractionEnabled = true
        self.lbPhone.addGestureRecognizer(tapPhoneNumber)
        
        self.lbVote.text = Settings.ShareInstance.translate(key: "label_rate")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func touchEmail(){
        delegate?.didEmail(index: self.lbEmail.tag)
    }
    
    @objc func touchPhoneNumber(){
        delegate?.didPhoneNumber(index: self.lbPhone.tag)
    }
    
    @objc func touchMore(){
        delegate?.didMoreRelationShip(index: self.imgMore.tag)
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
