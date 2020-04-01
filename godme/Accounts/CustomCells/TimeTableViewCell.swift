//
//  TimeTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/15/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol TimeTableViewCellProtocol {
//    func didSetText(str: String)
    func didLabel(_ index: Int)
}

class TimeTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTime: UILabel!
    var delegate: TimeTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
            self.setupUI()
        }
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(touchLabel))
        self.lbTime.isUserInteractionEnabled = true
        self.lbTime.addGestureRecognizer(tap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func touchLabel(){
//        delegate?.didSetText(str: <#T##String#>)
        delegate?.didLabel(self.lbTime.tag)
    }
    
    func setupUI(){
        self.lbTime = Settings.ShareInstance.setupBTLabelView(v: self.lbTime)
    }
    
}
