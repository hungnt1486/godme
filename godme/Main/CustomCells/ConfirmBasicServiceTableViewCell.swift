//
//  ConfirmBasicServiceTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/10/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import DropDown

protocol ConfirmBasicServiceTableViewCellProtocol {
    func getTextDateTime(_ index: Int)
}

class ConfirmBasicServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbFee: UILabel!
    @IBOutlet weak var lbMoney: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbDateTime: UILabel!
    @IBOutlet weak var lbDateTimeDetail: UILabel!
    var delegate: ConfirmBasicServiceTableViewCellProtocol?
    
    var TypeDropdown = DropDown()
    var arrString:[String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(showType))
        self.lbDateTimeDetail.isUserInteractionEnabled = true
        self.lbDateTimeDetail.addGestureRecognizer(tap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupTypeDropdown(){
        TypeDropdown.anchorView = self.lbDateTimeDetail
        TypeDropdown.bottomOffset = CGPoint(x: 0, y: self.lbDateTimeDetail.bounds.height)
//            for item in arr {
//                arrString.append(item["name"] ?? "")
//            }
        let typeDataSource = arrString
        TypeDropdown.dataSource = typeDataSource
        TypeDropdown.selectionAction = { [unowned self] (index, item) in
            self.lbDateTimeDetail.text = item
//            self.lbDateTimeDetail.tag = index
            self.delegate?.getTextDateTime(index)
        }
    }
        
    @objc func showType(){
        TypeDropdown.show()
    }
    
}
