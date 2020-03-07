//
//  FinanceOrangesButtonTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol FinanceOrangesButtonTableViewCellProtocol {
    func didButtonOranges(type: typeCellFinance)
}

class FinanceOrangesButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var btOranges: UIButton!
    var delegate: FinanceOrangesButtonTableViewCellProtocol?
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
        self.btOranges = Settings.ShareInstance.setupButton(button: self.btOranges)
    }
    
    @IBAction func touchOranges(_ sender: Any) {
        delegate?.didButtonOranges(type: typeCellFinance(rawValue: self.btOranges.tag)!)
    }
    
}
