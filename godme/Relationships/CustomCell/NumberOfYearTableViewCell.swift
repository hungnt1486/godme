//
//  NumberOfYearTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 4/1/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
protocol NumberOfYearTableViewCellProtocol {
    func didMinus()
    func didPlus()
}

class NumberOfYearTableViewCell: UITableViewCell {

    @IBOutlet weak var lbNumberOfYear: UILabel!
    @IBOutlet weak var lbTitleCoin: UILabel!
    @IBOutlet weak var lbTitleCoinValue: UILabel!
    @IBOutlet weak var btMinus: UIButton!
    @IBOutlet weak var lbNumberOfYearValue: UILabel!
    @IBOutlet weak var btPlus: UIButton!
    var delegate: NumberOfYearTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func touchMinus(_ sender: Any) {
        delegate?.didMinus()
    }
    
    @IBAction func touchPlus(_ sender: Any) {
        delegate?.didPlus()
    }
}
