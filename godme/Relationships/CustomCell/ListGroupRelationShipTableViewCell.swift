//
//  ListGroupRelationShipTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 4/4/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol ListGroupRelationShipTableViewCellProtocol {
    func didEdit(_ index: Int)
    func didDelete(_ index: Int)
}

class ListGroupRelationShipTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btEdit: UIButton!
    @IBOutlet weak var btDelete: UIButton!
    @IBOutlet weak var vSub: UIView!
    var delegate: ListGroupRelationShipTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
            self.setupUI()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        self.vSub = Settings.ShareInstance.setupBTV(v: self.vSub)
        self.btDelete = Settings.ShareInstance.setupButton(button: self.btDelete)
        self.btEdit = Settings.ShareInstance.setupButton(button: self.btEdit)
    }
    
    @IBAction func touchEdit(_ sender: Any) {
        delegate?.didEdit(self.btEdit.tag)
    }
    @IBAction func touchDelete(_ sender: Any) {
        delegate?.didDelete(self.btDelete.tag)
    }
    
}
