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
    func getTextTitle(_ str: String)
    @objc optional
    func getTextBaseService(_ str: String, type: typeCellCreateService)
    @objc optional
    func getTextAuctionService(_ str: String, type: typeCellCreateAuction)
    @objc optional
    func getTextEventService(_ str: String, type: typeCellCreateEvent)
    @objc optional
    func getTextCollaborationService(_ str: String, type: typeCellCreateCollaborate)
    @objc optional
    func getTextHelp(_ str: String, type: typeCellHelp)
    @objc optional
    func getTextPushNotification(_ str: String, type: typeCellPushNotification)
    @objc optional
    func getTextEditProfile(_ str: String, type: typeCellEditProfile)
    @objc optional
    func getTextForgotPassword(_ str: String, type: typeCellForGot)
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
        delegate?.getTextHelp?(self.tfInput.text ?? "", type: typeCellHelp(rawValue: self.tfInput.tag)!)
        delegate?.getTextPushNotification?(self.tfInput.text ?? "", type: typeCellPushNotification(rawValue: self.tfInput.tag)!)
        delegate?.getTextTitle?(self.tfInput.text ?? "")
        delegate?.getTextEditProfile?(self.tfInput.text ?? "", type: typeCellEditProfile(rawValue: self.tfInput.tag)!)
        delegate?.getTextForgotPassword?(self.tfInput.text ?? "", type: typeCellForGot(rawValue: self.tfInput.tag)!)
    }
    
    func setupUI(){
        self.tfInput = Settings.ShareInstance.setupBTView(v: self.tfInput)
    }
    
}
