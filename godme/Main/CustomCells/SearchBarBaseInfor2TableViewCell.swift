//
//  SearchBarBaseInfor2TableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/13/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol SearchBarBaseInfor2TableViewCellProtocol {
    func didMore(index: Int)
}

class SearchBarBaseInfor2TableViewCell: UITableViewCell {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbComment: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var imgMore: UIImageView!
    @IBOutlet weak var vImageStar: UIView!
    var vStarOranges: VImageStarsOranges!
    var delegate: SearchBarBaseInfor2TableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func touchMore(){
        delegate?.didMore(index: self.imgMore.tag)
    }
    
    func setupUI(){
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(touchMore))
        self.imgMore.isUserInteractionEnabled = true
        self.imgMore.addGestureRecognizer(tapGesture)
        
        vStarOranges = VImageStarsOranges.instanceFromNib()
        
        self.vImageStar.addSubview(vStarOranges)
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseOut, animations: {
            self.vStarOranges.configVImageStarsOranges(frameView: self.vImageStar.frame, index: 4)
        }, completion: nil)
    }
    
}
