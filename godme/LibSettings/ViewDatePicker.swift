//
//  ViewDatePicker.swift
//  pCare
//
//  Created by Lê Hùng on 11/13/18.
//  Copyright © 2018 fcsdev. All rights reserved.
//

import UIKit

protocol ViewDatePickerProtocol {
    func tapDone()
    func tapCancel()
    func tapGesture()
}

class ViewDatePicker: UIView {

    @IBOutlet weak var vPopup: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btCancel: UIBarButtonItem!
    @IBOutlet weak var btDone: UIBarButtonItem!
    
    var strDateTime: String?
    
    
    var delegate: ViewDatePickerProtocol?
    
    //MARK: - Setup
    class func instanceFromNib() -> ViewDatePicker {
        return UINib(nibName: "ViewDatePicker", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ViewDatePicker
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
        configFrame()
        configDate()
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapGesture))
        self.addGestureRecognizer(tap)
    }
    
    func configDate() -> Void {
//        let calendar = Calendar(identifier: .gregorian)
//        let comps = DateComponents()
//        let maxDate = calendar.date(byAdding: comps, to: Date())
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
//        datePicker.maximumDate = maxDate
        let currentLanguage = Settings.ShareInstance.getCurrentLanguage()
        let locale = Locale.init(identifier: currentLanguage)
        datePicker.locale = locale
//        let formatter = DateFormatter.init()
//        formatter.date(from: "yyyy-MM-dd")
    }
    
    @objc func tapGesture() {
        delegate?.tapGesture()
    }
    
    func configUI() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        self.btCancel.title = Settings.ShareInstance.translate(key: "label_cancel")
        self.btDone.title = Settings.ShareInstance.translate(key: "label_done")
//        vPopup.layer.cornerRadius = 10.0
//        vPopup.layer.borderWidth = 1.0
//        vPopup.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
        vPopup.dropShadow()
//
//        viewFee.layer.borderWidth = 1.0
//        viewFee.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
//        viewCode.layer.borderWidth = 1.0
//        viewCode.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
//
//        btOrder.layer.cornerRadius = self.btOrder.frame.size.height/2
//        btOrder.layer.borderWidth = 1.0
//        btOrder.layer.borderColor = UIColor(hexString: Color.mainColor).cgColor
//
//        tfCode.layer.cornerRadius = tfCode.frame.size.height/2
//        tfCode.layer.borderWidth = 1.0
//        tfCode.layer.borderColor = UIColor.black.cgColor
//        tfCode.layer.masksToBounds = true
    }
    
    func configFrame() {
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    @IBAction func touchCancel(_ sender: Any) {
        delegate?.tapCancel()
    }
        
    @IBAction func touchDone(_ sender: Any) {
        delegate?.tapDone()
    }
}
