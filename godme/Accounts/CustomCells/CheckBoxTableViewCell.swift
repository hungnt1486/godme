//
//  CheckBoxTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/30/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol CheckBoxTableViewCellProtocol {
    func didImg1()
    func didImg2()
    func didImg3()
}

class CheckBoxTableViewCell: UITableViewCell {

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var lbTitle1: UILabel!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var lbTitle2: UILabel!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var lbTitle3: UILabel!
    @IBOutlet weak var bt1: UIButton!
    @IBOutlet weak var bt2: UIButton!
    @IBOutlet weak var bt3: UIButton!
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
        delegate?.didImg1()
    }
    @IBAction func touchImg2(_ sender: Any) {
        delegate?.didImg2()
    }
    @IBAction func touchImg3(_ sender: Any) {
        delegate?.didImg3()
    }
    
}
