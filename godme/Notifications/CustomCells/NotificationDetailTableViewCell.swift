//
//  NotificationDetailTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 6/5/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol NotificationDetailTableViewCellProtocol {
    func didTouchConnect()
}

class NotificationDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbConnect: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var constraintWidth: NSLayoutConstraint!
    var delegate: NotificationDetailTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(touchConnect))
        tap.numberOfTapsRequired = 1
        self.lbConnect.isUserInteractionEnabled = true
        self.lbConnect.addGestureRecognizer(tap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func touchConnect(){
        delegate?.didTouchConnect()
    }
    
}
