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

protocol AddressPostCarTableViewCellProtocol {
    func getAddress()
    func getText(_ str: String)
}

class AddressPostCarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTypeCar: UILabel!
    
    private let geoCoder = GMSGeocoder()
    private var location: CLLocation?
    
    var delegate: AddressPostCarTableViewCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(touchAddress))
        self.lbTypeCar.addGestureRecognizer(gesture)
        self.lbTypeCar.isUserInteractionEnabled = true
        self.lbTypeCar = Settings.ShareInstance.setupBTLabelView(v: self.lbTypeCar)
    }
    
    @objc func touchAddress(){
        delegate?.getAddress()
    }
    
    func updateAddress(to newLocation: CLLocation?) -> Void {
        guard let newLocation = newLocation else {
            return 
        }
        location = newLocation
        geoCoder.reverseGeocodeCoordinate(newLocation.coordinate) { [weak self] (response, error) in
            guard let weakSelf = self,
                let location = response?.firstResult() else {
                    return
            }
            let address = location.lines?.joined(separator: ", ")
            weakSelf.lbTypeCar.text = address
            //            weakSelf.choosePlaceLB.text = address
            self?.delegate?.getText(address ?? "")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func actionLoadMap(_ sender: UIButton) {
    }
}
