//
//  StartEndTimeTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/15/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol StartEndTimeTableViewCellProtocol {
    func didStartTime()
    func didEndTime()
}

class StartEndTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbStartTime: UILabel!
    @IBOutlet weak var lbEndTime: UILabel!
    var delegate: StartEndTimeTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }
    
    func setupUI(){
        self.lbStartTime = Settings.ShareInstance.setupBTLabelView(v: self.lbStartTime)
        self.lbEndTime = Settings.ShareInstance.setupBTLabelView(v: self.lbEndTime)
        
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(touchStartTime))
        self.lbStartTime.isUserInteractionEnabled = true
        self.lbStartTime.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(touchEndTime))
        self.lbEndTime.isUserInteractionEnabled = true
        self.lbEndTime.addGestureRecognizer(tap2)
    }
    
    @objc func touchStartTime(){
        delegate?.didStartTime()
    }
    
    @objc func touchEndTime(){
        delegate?.didEndTime()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
