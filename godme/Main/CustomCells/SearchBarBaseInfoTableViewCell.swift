//
//  SearchBarBaseInfoTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/13/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class SearchBarBaseInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitleInfoBase: UILabel!
    @IBOutlet weak var lbGender: UILabel!
    @IBOutlet weak var lbDOB: UILabel!
    @IBOutlet weak var lbJob: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbShowInfo: UILabel!
    @IBOutlet weak var lbContentShowInfo: UILabel!
    @IBOutlet weak var lbExperience: UILabel!
    @IBOutlet weak var lbContentExperience: UILabel!
    @IBOutlet weak var lbPosition: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbEducation: UILabel!
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
        
    }
    
}
