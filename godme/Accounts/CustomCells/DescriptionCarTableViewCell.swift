//
//  DescriptionCarTableViewCell.swift
//  hune
//
//  Created by Apple on 9/11/19.
//  Copyright © 2019 Tien. All rights reserved.
//

import UIKit

@objc protocol DescriptionCarTableViewCellProtocol {
    func getDescriptionText(_ string: String)
//    @objc optional
//    func getDescriptionText(_ string: String, type: typeCellTour)
    @objc optional
    func getDescriptionTextEditProfile(_ string: String, type: typeCellEditProfile)
}

class DescriptionCarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var textView: UITextView!
    var delegate:DescriptionCarTableViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textView.delegate = self
        DispatchQueue.main.async {
            self.setupUI()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        self.textView = Settings.ShareInstance.setupBTTextView(v: self.textView)
    }
    
}

extension DescriptionCarTableViewCell: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.getDescriptionText(textView.text)
        self.delegate?.getDescriptionTextEditProfile?(textView.text, type: typeCellEditProfile(rawValue: self.textView.tag)!)
//        self.delegate?.getDescriptionText?(textView.text, type: typeCellTour(rawValue: textView.tag)!)
    }
}
