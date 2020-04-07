//
//  Extension+Color.swift
//  MVVMRoot
//
//  Created by Lê Hùng on 8/7/18.
//  Copyright © 2018 Lê Hùng. All rights reserved.
//

import UIKit
//239241243 border textfield
extension UIColor {
    struct FlatColor {
        struct Oranges {
            static let BGColor = UIColor(red: 254.0/255.0, green: 130.0/255.0, blue: 2.0/255.0, alpha: 1.0)
        }
        struct Blue {
//            003470
            static let BGColor = UIColor(red: 0.0/255.0, green: 52.0/255.0, blue: 112.0/255.0, alpha: 1.0)
            static let TextColor = UIColor(red: 11.0/255.0, green: 154.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        }
        struct Aquamarine {
            static let TextColor = UIColor(red: 81.0/255.0, green: 255.0/255.0, blue: 169.0/255.0, alpha: 1.0)
        }
        struct Green {
            static let NAVBG = UIColor(red: 73.0/255.0, green: 166.0/255.0, blue: 167.0/255.0, alpha: 1.0)
            static let TABBARBG = UIColor(red: 172.0/255.0, green: 227.0/255.0, blue: 227.0/255.0, alpha: 1.0)
            static let TFBG = UIColor(red: 237.0/255.0, green: 242.0/255.0, blue: 253.0/255.0, alpha: 1.0)
            static let CELLBG = UIColor(red: 246.0/255.0, green: 252.0/255.0, blue: 252.0/255.0, alpha: 1.0)
            static let TextColor  = UIColor(red: 12.0/255.0, green: 188.0/255.0, blue: 83.0/255.0, alpha: 1.0)
        }
        struct Red {
            static let BTBG = UIColor(red: 153.0/255.0, green: 31.0/255.0, blue: 31.0/255.0, alpha: 1.0)
            static let TextColor = UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.6)
        }
        struct Gray {
            static let BGColor = UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 248.0/255.0, alpha: 1.0)
            static let BGColorChoosePhone = UIColor(red: 226.0/255.0, green: 225.0/255.0, blue: 222.0/255.0, alpha: 1.0)
            
            static let TextColor = UIColor(red: 119.0/255.0, green: 119.0/255.0, blue: 119.0/255.0, alpha: 1.0)
        }
        struct Black {
            static let TextColor = UIColor(red: 4.0/255.0, green: 68.0/255.0, blue: 68.0/255.0, alpha: 1.0)
            static let TextColorPopup = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        }
   
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.shadowColor = UIColor.black.withAlphaComponent(0.7).cgColor
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
}

extension UITextField {
    func ShadowTextField(scale: Bool = true) {
        layer.shadowColor = UIColor.black.withAlphaComponent(0.7).cgColor
        layer.shadowOffset =  CGSize.zero
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        
//        textField.layer.shadowOpacity = 1
//        textField.layer.shadowRadius = 3.0
//        textField.layer.shadowOffset = CGSize.zero // Use any CGSize
//        textField.layer.shadowColor = UIColor.gray.cgColor
    }
}

extension UIButton {
    func setBorder(){
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.FlatColor.Gray.TextColor.cgColor
        layer.masksToBounds = false
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension UITableView {
    func setMessageTableViewEmpty(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width - 50, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.FlatColor.Gray.TextColor
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Roboto-Medium", size: 15.0)!
        messageLabel.sizeToFit()
        self.separatorStyle = .none
        
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension Int {
    func formatnumber() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value: self))!
    }
}

extension Double {
    func formatnumber() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value: self))!
    }
}

