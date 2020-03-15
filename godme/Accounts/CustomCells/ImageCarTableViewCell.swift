//
//  ImageCarTableViewCell.swift
//  hune
//
//  Created by Apple on 9/11/19.
//  Copyright © 2019 Tien. All rights reserved.
//

import UIKit

protocol ImageCarTableViewCellProtocol {
    func touchImg1()
    func touchImg2()
    func touchImg3()
}
class ImageCarTableViewCell: UITableViewCell {
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var imageThree: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    
    
    var delegate: ImageCarTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageTwo.layer.borderWidth = 1
        self.imageTwo.layer.borderColor = UIColor.FlatColor.Blue.BGColor
            .cgColor
        self.imageThree.layer.borderWidth = 1
        self.imageThree.layer.borderColor = UIColor.FlatColor.Blue.BGColor.cgColor
        touchImg1()
        touchImg2()
        touchImg3()
        
        if #available(iOS 13.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                self.imageOne?.image?.withRenderingMode(.alwaysTemplate)
                imageOne.tintColor = UIColor.white
            }
        } else {
            
        }
    }
    
    func touchImg1() {
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapImg1))
        imageOne.addGestureRecognizer(tapGesture)
        imageOne.isUserInteractionEnabled = true
    }
    
    @objc func tapImg1() -> Void {
        delegate?.touchImg1()
    }
    func touchImg2() {
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapImg2))
        imageTwo.addGestureRecognizer(tapGesture)
        imageTwo.isUserInteractionEnabled = true
    }
    
    @objc func tapImg2() -> Void {
        delegate?.touchImg2()
    }
    
    func touchImg3() {
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapImg3))
        imageThree.addGestureRecognizer(tapGesture)
        imageThree.isUserInteractionEnabled = true
    }
    
    @objc func tapImg3() -> Void {
        delegate?.touchImg3()
    }
    
    func updateImg(str: String, index: Int, img: UIImage){
        switch index {
        case 1:
            imageOne.contentMode = .scaleToFill
            imageOne.image = img
            break
        case 2:
            imageTwo.image = img
            break
        case 3:
            imageThree.image = img
            break
        default:
            break
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
