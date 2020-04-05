//
//  ServicesInfoBookTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol MyBaseServiceDetailTableViewCellProtocol {
    func didTitle(_ index: Int)
}

class MyBaseServiceDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var vContent: UIView!
    var delegate: MyBaseServiceDetailTableViewCellProtocol?
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
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(touchTitle))
        tap.numberOfTouchesRequired = 1
        self.lbTitle.isUserInteractionEnabled = true
        self.lbTitle.addGestureRecognizer(tap)
    }
    
    @objc func touchTitle(){
        delegate?.didTitle(self.lbTitle.tag)
    }
    
}
