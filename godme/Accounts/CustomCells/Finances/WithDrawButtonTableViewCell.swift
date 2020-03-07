//
//  WithDrawButtonTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/7/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol WithDrawButtonTableViewCellProtocol {
    func didConfirm(type: typeCellWithDraw)
}

class WithDrawButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var btConfirm: UIButton!
    var delegate: WithDrawButtonTableViewCellProtocol?
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
        self.btConfirm = Settings.ShareInstance.setupButton(button: self.btConfirm)
    }
    
    @IBAction func touchConfirm(_ sender: Any) {
        delegate?.didConfirm(type: typeCellWithDraw(rawValue: self.btConfirm.tag)!)
    }
}
