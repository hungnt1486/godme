//
//  StartEndTimeTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/15/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol StartEndTimeTableViewCellProtocol {
    func didStartTime(index: Int)
    func didEndTime(index: Int)
}

class StartEndTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbStartTime: UILabel!
    @IBOutlet weak var lbEndTime: UILabel!
    var delegate: StartEndTimeTableViewCellProtocol?
    var indexLabel = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
            self.setupUI()
        }
    }
    
    func setupUI(){
        self.lbStartTime = Settings.ShareInstance.setupBTLabelView(v: self.lbStartTime)
        self.lbEndTime = Settings.ShareInstance.setupBTLabelView(v: self.lbEndTime)
        
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(touchStartTime))
        self.lbStartTime.isUserInteractionEnabled = true
        self.lbStartTime.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(touchEndTime))
        self.lbEndTime.isUserInteractionEnabled = true
        self.lbEndTime.addGestureRecognizer(tap2)
    }
    
    @objc func touchStartTime(){
        delegate?.didStartTime(index: self.lbStartTime.tag)
    }
    
    @objc func touchEndTime(){
        delegate?.didEndTime(index: self.lbEndTime.tag)
    }
    
    func updateDate(str: String, index: Int){
        print("index = \(index)")
        if index == 1 {
            self.lbStartTime.text = str
        }else{
            self.lbEndTime.text = str
        }
//        self.lbTypeCar.text = str
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
