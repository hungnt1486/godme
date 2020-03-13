//
//  SearchBarBaseInfoTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/13/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol SearchBarBaseInfoTableViewCellProtocol {
    func didMore()
}

class SearchBarBaseInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbNumberOfBookService: UILabel!
    @IBOutlet weak var lbVote: UILabel!
    @IBOutlet weak var vStars: UIView!
    @IBOutlet weak var lbNumberVote: UILabel!
    @IBOutlet weak var btMore: UIButton!
    var vImagesStar: VImageStarsOranges!
    var delegate: SearchBarBaseInfoTableViewCellProtocol?
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
        vImagesStar = VImageStarsOranges.instanceFromNib()
        
        self.vStars.addSubview(vImagesStar)
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseOut, animations: {
            self.vImagesStar.configVImageStarsOranges(frameView: self.vStars.frame, index: 4)
        }, completion: nil)
    }
    
    @IBAction func touchMore(_ sender: Any) {
        delegate?.didMore()
    }
    
}
