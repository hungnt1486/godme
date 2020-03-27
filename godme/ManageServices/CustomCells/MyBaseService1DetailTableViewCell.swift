//
//  ServicesInfoBookTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol MyBaseService1DetailTableViewCellProtocol {
    func didConfirm(_ index: Int)
    func didCancel(_ index: Int)
}

class MyBaseService1DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var vSub: UIView!
    @IBOutlet weak var btConfirm: UIButton!
    @IBOutlet weak var btCancel: UIButton!
    var delegate: MyBaseService1DetailTableViewCellProtocol?
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
        self.vContent = Settings.ShareInstance.setupView(v: self.vContent)
        self.vSub = Settings.ShareInstance.setupTopV(v: self.vSub)
    }
    
    @IBAction func touchConfirm(_ sender: Any) {
        delegate?.didConfirm(self.btConfirm.tag)
    }
    @IBAction func touchCancel(_ sender: Any) {
        delegate?.didCancel(self.btCancel.tag)
    }
}
