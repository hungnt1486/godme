//
//  AddressPostCarTableViewCell.swift
//  hune
//
//  Created by Apple on 9/11/19.
//  Copyright © 2019 Tien. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

protocol DateTableViewCellProtocol {
    func getDateText(_ str: String)
    func showDatePicker()
}

class DateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTypeCar: UILabel!
    @IBOutlet weak var btCalendar: UIButton!
    
    var delegate: DateTableViewCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(touchAddress))
        self.lbTypeCar.addGestureRecognizer(gesture)
        self.lbTypeCar.isUserInteractionEnabled = true
        DispatchQueue.main.async {
            self.setupUI()
        }
    }
    
    func setupUI(){
        self.lbTypeCar = Settings.ShareInstance.setupBTLabelView(v: self.lbTypeCar)
    }
    
    @objc func touchAddress(){
        delegate?.showDatePicker()
    }
    @IBAction func touchCalendar(_ sender: Any) {
        delegate?.showDatePicker()
    }
    
    func updateDate(str: String){
        self.lbTypeCar.text = str
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
