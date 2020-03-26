//
//  TimeTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/15/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

//protocol TimeTableViewCellProtocol {
//    func didSetText(str: String)
//}

class TimeTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTime: UILabel!
//    var delegate: TimeTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
            self.setupUI()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        self.lbTime = Settings.ShareInstance.setupBTLabelView(v: self.lbTime)
    }
    
}
