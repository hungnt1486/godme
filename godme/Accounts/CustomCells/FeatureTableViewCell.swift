//
//  FeatureTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/6/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol FeatureTableViewCellProtocol {
//    func eventGetTextWithType(_ string: String, type: typeCellPost, index: Int)
//    func didOne(type: typeCellAccounts, index: Int)
//    func didTwo(type: typeCellAccounts, index: Int)
}

class FeatureTableViewCell: UITableViewCell {

    @IBOutlet weak var btOne: UIButton!
    @IBOutlet weak var btTwo: UIButton!
    var delegate: FeatureTableViewCellProtocol?
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
        self.btOne = Settings.ShareInstance.setupButton(button: self.btOne)
        self.btTwo = Settings.ShareInstance.setupButton(button: self.btTwo)
    }
    
    @IBAction func touchOne(_ sender: Any) {
//        delegate?.didOne(type: typeCellAccounts(rawValue: self.btOne.tag)!, index: self.btOne.tag)
    }
    
    @IBAction func touchTwo(_ sender: Any) {
//        delegate?.didTwo(type: typeCellAccounts(rawValue: self.btTwo.tag)!, index: self.btTwo.tag)
    }
    
}
