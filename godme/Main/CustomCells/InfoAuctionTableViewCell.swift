//
//  InfoAuctionTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/10/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol InfoAuctionTableViewCellProtocol {
    func didAuction()
    func didCoinConvert()
}

class InfoAuctionTableViewCell: UITableViewCell {

    @IBOutlet weak var lbStep: UILabel!
    @IBOutlet weak var lbStepMoney: UILabel!
    @IBOutlet weak var lbTitlePrice: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbTitleNumber: UILabel!
    @IBOutlet weak var lbNumber: UILabel!
    @IBOutlet weak var lbTitleWiner: UILabel!
    @IBOutlet weak var lbWiner: UILabel!
    @IBOutlet weak var tfMoney: UITextField!
    @IBOutlet weak var btAuction: UIButton!
    var delegate: InfoAuctionTableViewCellProtocol?
    @IBOutlet weak var lbCoinConvert: UILabel!
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
        self.btAuction = Settings.ShareInstance.setupButton(button: self.btAuction)
        self.tfMoney = Settings.ShareInstance.setupBTView(v: self.tfMoney)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(touchConvert))
        self.lbCoinConvert.isUserInteractionEnabled = true
        self.lbCoinConvert.addGestureRecognizer(tap)
    }
    
    @objc func touchConvert(){
        delegate?.didCoinConvert()
    }
    
    @IBAction func touchAuction(_ sender: Any) {
        delegate?.didAuction()
    }
    
}
