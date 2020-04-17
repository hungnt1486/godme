//
//  MyServicesTableViewCell.swift
//  godme
//
//  Created by Lê Hùng on 3/8/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

protocol MyAuctionServiceTableViewCellProtocol {
    func didCancel(index: Int)
}

class MyAuctionServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbCity: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbCoin: UILabel!
    @IBOutlet weak var btCancel: UIButton!
    var delegate: MyAuctionServiceTableViewCellProtocol?
    
    var dateTime: String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        self.vContent = Settings.ShareInstance.setupView(v: self.vContent)
    }
    
    @IBAction func touchCancel(_ sender: Any) {
        delegate?.didCancel(index: self.btCancel.tag)
    }
    
    func countDown(){
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTime), userInfo: nil, repeats: true)
        }
        
        @objc func UpdateTime() {
            let userCalendar = Calendar.current
            // Set Current Date
            let date = Date()
            let components = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date)
            let currentDate = userCalendar.date(from: components)!
            
            // Set Event Date
            let arr = dateTime.split(separator: "/")
            var eventDateComponents = DateComponents()
            eventDateComponents.year = Int(String(arr[0]))
            eventDateComponents.month = Int(String(arr[1]))
            eventDateComponents.day = Int(String(arr[2]))
            eventDateComponents.hour = Int(String(arr[3]))
            eventDateComponents.minute = Int(String(arr[4]))
            eventDateComponents.second = Int(String(arr[5]))
    //        eventDateComponents.timeZone = TimeZone(abbreviation: "GMT")
            
            // Convert eventDateComponents to the user's calendar
            let eventDate = userCalendar.date(from: eventDateComponents)!
            
            // Change the seconds to days, hours, minutes and seconds
            let timeLeft = userCalendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: eventDate)
            
            // Display Countdown
            self.lbTime.text = "\(timeLeft.day!) ngày \(timeLeft.hour!):\(timeLeft.minute!):\(timeLeft.second!)"
        }
    
}
