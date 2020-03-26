//
//  CompleteTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/5/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
protocol CompleteTableViewCellProtocol {
    func didComplete()
}

class CompleteTableViewCell: UITableViewCell {

    @IBOutlet weak var btComplete: UIButton!
    var delegate: CompleteTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.btComplete.backgroundColor = UIColor.FlatColor.Oranges.BGColor
        self.btComplete = Settings.ShareInstance.setupButton(button: self.btComplete)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func touchComplete(_ sender: Any) {
        delegate?.didComplete()
    }
}
