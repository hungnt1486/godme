//
//  FeatureTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/6/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class FeatureTableViewCell: UITableViewCell {

    @IBOutlet weak var btOne: UIButton!
    @IBOutlet weak var btTwo: UIButton!
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
    
    @IBAction func touchOne(_ sender: Any) {
        
    }
    
    @IBAction func touchTwo(_ sender: Any) {
        
    }
    
}
