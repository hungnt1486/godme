//
//  CheckBoxTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/30/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol CheckBoxTableViewCellProtocol {
    func didImg1(_ index: Int)
}

class CheckBoxTableViewCell: UITableViewCell {

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var lbTitle1: UILabel!
    @IBOutlet weak var bt1: UIButton!
    var delegate: CheckBoxTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func touchImg1(_ sender: Any) {
        delegate?.didImg1(self.bt1.tag)
    }
    
}
