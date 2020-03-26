//
//  TitleTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/15/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

@objc protocol TitleTableViewCellProtocol {
    @objc optional
    func getTextBaseService(_ str: String, type: typeCellCreateService)
    @objc optional
    func getTextAuctionService(_ str: String, type: typeCellCreateAuction)
    @objc optional
    func getTextEventService(_ str: String, type: typeCellCreateEvent)
    @objc optional
    func getTextCollaborationService(_ str: String, type: typeCellCreateCollaborate)
}

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfInput: UITextField!
    var delegate: TitleTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
            self.setupUI()
        }
        
        self.tfInput.addTarget(self, action: #selector(getText), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func getText(){
        delegate?.getTextBaseService?(self.tfInput.text ?? "", type: typeCellCreateService(rawValue: self.tfInput.tag)!)
        delegate?.getTextAuctionService?(self.tfInput.text ?? "", type: typeCellCreateAuction(rawValue: self.tfInput.tag)!)
        delegate?.getTextEventService?(self.tfInput.text ?? "", type: typeCellCreateEvent(rawValue: self.tfInput.tag)!)
        delegate?.getTextCollaborationService?(self.tfInput.text ?? "", type: typeCellCreateCollaborate(rawValue: self.tfInput.tag)!)
    }
    
    func setupUI(){
        self.tfInput = Settings.ShareInstance.setupBTView(v: self.tfInput)
    }
    
}
