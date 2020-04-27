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
        self.lbStep.text = Settings.ShareInstance.translate(key: "label_price_step")
        self.lbTitlePrice.text = Settings.ShareInstance.translate(key: "label_current_price")
        self.lbTitleNumber.text = Settings.ShareInstance.translate(key: "label_current_place")
        self.lbTitleWiner.text = Settings.ShareInstance.translate(key: "label_current_winner")
        self.btAuction.setTitle(Settings.ShareInstance.translate(key: "label_auction"), for: .normal)
        self.tfMoney.placeholder = Settings.ShareInstance.translate(key: "label_input_start_price")
        self.lbCoinConvert.text = Settings.ShareInstance.translate(key: "label_switch_wallet")
    }
    
    @objc func touchConvert(){
        delegate?.didCoinConvert()
    }
    
    @IBAction func touchAuction(_ sender: Any) {
        delegate?.didAuction()
    }
    
}
