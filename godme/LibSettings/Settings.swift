//
//  Settings.swift
//  MVVMRoot
//
//  Created by Lê Hùng on 8/8/18.
//  Copyright © 2018 Lê Hùng. All rights reserved.
//

import UIKit

class Settings: NSObject {
    
    static var bundle = Bundle()
    // declare singleton
    static let ShareInstance = Settings()
    
    // callback
    fileprivate var showAlerCallback: ((_ message: String) -> Void)?
    public func setOnShowAlertCallback(callback: ((_ message: String) -> Void)?) {
        showAlerCallback = callback
    }
    // call back
    // function selected text
//    fileprivate var selectedTextCallback: ((_ text: String, _ textField: UITextField, _ dictAddressForm: [String:String]) -> Void)?
//    public func setOnSelectedTextCallback(callback: ((_ text: String, _ textField: UITextField, _ dictAddressForm: [String:String]) -> Void)?) {
//        selectedTextCallback = callback
//    }
    
//    // function set text change
//    fileprivate var setTextChangeCallback: ((_ text: String, _ textField: UITextField) ->Void)?
//    public func setOnTextChangeCallback(callback: ((_ text: String, _ textField: UITextField) ->Void)?) {
//        setTextChangeCallback = callback
//    }
    
//    func getDictUser() -> LoginModel {
//        var model = LoginModel()
////        var GUID: String?
////        var FullName: String?
////        var Email: String?
////        var PhoneNumber: String?
////        var TokenLogin: String?
////        var Sex: Int?
////        var Thumbnail: String?
////        var IsSale: String?
//        // IsSale = user thi ko the create land, an button tao dich vu o home
//        let dict = UserDefaults.standard.object(forKey: information_login) as! NSDictionary
//        model.FullName = dict.object(forKey: "FullName") as! NSString as String
//        model.TokenLogin = dict.object(forKey: "TokenLogin") as! NSString as String
//        model.Sex = dict.object(forKey: "Sex") as? Int
//        model.GUID = dict.object(forKey: "GUID") as! NSString as String
//        model.Email = dict.object(forKey: "Email") as! NSString as String
//        model.PhoneNumber = dict.object(forKey: "PhoneNumber") as! NSString as String
//        model.Thumbnail = dict.object(forKey: "Thumbnail") as? String
//        model.IsSale = dict.object(forKey: "IsSale") as! NSString as String
//        model.Password = dict.object(forKey: "Password") as! NSString as String
//        model.MaintenaceBus = (dict.object(forKey: "MaintenaceBus") as! Bool)
//        model.MaintenaceLand = (dict.object(forKey: "MaintenaceLand") as! Bool)
//        model.MaintenaceService = (dict.object(forKey: "MaintenaceService") as! Bool)
//        model.MaintenaceTour = (dict.object(forKey: "MaintenaceTour") as! Bool)
//        return model
//    }
    
    func formatCurrency(Value: String) -> String{
        let format = NumberFormatter()
        format.numberStyle = .currency
        format.currencyCode = "VND"
        return format.string(from: NSNumber.init(value: Int(Value)!))!
    }
    
//    func setDictUser(data: RegisterModel, password: String = "", rememberMe: Bool = false) -> Void {
//        let dict = ["FullName": data.FullName ?? "", "TokenLogin": data.TokenLogin ?? "", "Email": data.Email as Any, "Sex": data.Sex as Any, "Thumbnail" : data.Thumbnail as Any, "GUID" : data.GUID as Any, "IsSale" : data.IsSale as Any, "PhoneNumber" : data.PhoneNumber as Any, "Password" : rememberMe == true ? password : "", "MaintenaceBus" : data.MaintenaceBus as Any, "MaintenaceLand" : data.MaintenaceLand as Any, "MaintenaceService" : data.MaintenaceService as Any, "MaintenaceTour" : data.MaintenaceTour as Any] as [String : Any]
//
//        print("dict = \(dict)")
//        UserDefaults.standard.set(dict, forKey: information_login)
//        UserDefaults.standard.synchronize()
//        BaseViewController.accessToken = data.TokenLogin!
//    }
    
    func getVersionApp () -> String {
        let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        return appVersion!
    }
    
    private func setRadius (uiType: Any) -> Void {
        (uiType as AnyObject).layer.cornerRadius = 15.0
//        if buttonType == ButtonType.ButtonCancelOrder {
//            (uiType as AnyObject).layer.cornerRadius = 5.0
//        } else {
//            (uiType as AnyObject).layer.cornerRadius = 5.0
//        }
        
//        switch Define_Screen_Size.sizeHeightScreen {
//        case Define_Screen_Size.Heigh.IP5 :
//            (uiType as AnyObject).layer.cornerRadius = (uiType as AnyObject).frame.size.height/2 - 8
//            break
//        case Define_Screen_Size.Heigh.IP6:
//            (uiType as AnyObject).layer.cornerRadius = (uiType as AnyObject).frame.size.height/2 - 5
//            break
//        case Define_Screen_Size.Heigh.IP6P:
//            (uiType as AnyObject).layer.cornerRadius = (uiType as AnyObject).frame.size.height/2 - 2
//            break
//        case Define_Screen_Size.Heigh.IPX:
//            (uiType as AnyObject).layer.cornerRadius = (uiType as AnyObject).frame.size.height/2
//            break
//        default:
//            (uiType as AnyObject).layer.cornerRadius = (uiType as AnyObject).frame.size.height/2
//            break
//        }
    }
    
    private func setRadiusForTF (uiType: UITextField) {
        uiType.layer.cornerRadius = 5.0
    }
    
    func setupLabel(label: UILabel) -> UILabel{
        label.layer.cornerRadius = 12.0
        label.clipsToBounds = true
        return label
    }
    
    func setupButton(button: UIButton) -> UIButton {
        // button login
//        if buttonType == ButtonType.ButtonLogin {
//            button.backgroundColor = UIColor.FlatColor.Green.GreenLogin
//            button.setTitleColor(UIColor.FlatColor.White.White, for: .normal)
//        } else if buttonType == ButtonType.ButtonLoginFB {
//            button.backgroundColor = UIColor.FlatColor.Green.GreenLogin
//            button.setTitleColor(UIColor.FlatColor.White.White, for: .normal)
//        } else if buttonType == ButtonType.ButtonLoginInstagram {
//            button.backgroundColor = UIColor.FlatColor.Pink.PinkInstagram
//            button.setTitleColor(UIColor.FlatColor.White.White, for: .normal)
//        } else if buttonType == ButtonType.ButtonRegister {
//            button.backgroundColor = UIColor.FlatColor.Oranges.OrangesBGRegister
//            button.setTitleColor(UIColor.FlatColor.White.White, for: .normal)
//        } else if buttonType == ButtonType.ButtonChooseCFS {
//            button.backgroundColor = UIColor.FlatColor.White.White
//            button.setTitleColor(UIColor.FlatColor.Gray.GrayContent, for: .normal)
//            button.layer.borderColor = UIColor.FlatColor.Gray.GrayBorderTF.cgColor
//            button.layer.borderWidth = 2.0
//            button.clipsToBounds = true
//            button.layer.cornerRadius = 5.0
//        }
        
        setRadius(uiType: button)
        return button
    }
    
    func setupTextField(textField: UITextField, isLeftView: Bool = false) -> UITextField {
        if isLeftView {
            let leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.size.height))
            textField.leftView = leftView
            textField.leftViewMode = UITextField.ViewMode.always
        }
        textField.backgroundColor = UIColor.white
        textField.layer.borderColor = UIColor.FlatColor.Gray.BGColor.cgColor
        textField.layer.borderWidth = 1.0
        textField.clipsToBounds = true
//        setRadius(uiType: textField)
        setRadiusForTF(uiType: textField)
        return textField
    }
    
    func setupTextFieldRadius(textField: UITextField, isLeftView: Bool = false) -> UITextField{
        if isLeftView {
            let leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.size.height))
            textField.leftView = leftView
            textField.leftViewMode = UITextField.ViewMode.always
        }
        textField.layer.cornerRadius = 15.0
        textField.clipsToBounds = true
        textField.backgroundColor = UIColor.white
        return textField
    }
    
    
    func setupView(v: UIView) -> UIView {
//        v.backgroundColor = UIColor.FlatColor.White.White
//        v.layer.borderColor = UIColor.FlatColor.Gray.GrayBorderTF.cgColor
        v.clipsToBounds = true
        v.layer.cornerRadius = 20.0
//        setRadius(uiType: v)
        return v
    }
    
    func setupViewChoose(v: UIView) -> UIView {
//        v.backgroundColor = UIColor.FlatColor.White.White
//        v.layer.borderColor = UIColor.FlatColor.Gray.GrayBorderTF.cgColor
//        v.layer.borderWidth = 2.0
        v.clipsToBounds = true
        v.layer.cornerRadius = 5.0
        //        setRadius(uiType: v)
        return v
    }
    
    func setupBTView(v: UITextField) -> UITextField {
        let layer = CALayer.init()
        if #available(iOS 12.0, *) {
            layer.frame = CGRect.init(x: 0, y: (v as AnyObject).frame.size.height + 5, width: ((v as AnyObject).frame?.width)!, height: 0.5)
        } else {
            // Fallback on earlier versions
            layer.frame = CGRect.init(x: 0, y: (v as AnyObject).size.height + 5, width: (v as AnyObject).size.width, height: 0.5)
        }
        layer.backgroundColor = UIColor.lightGray.cgColor
        (v as AnyObject).layer.addSublayer(layer)
        return v
    }
    
    func setupBTV(v: UIView) -> UIView {
        let layer = CALayer.init()
        if #available(iOS 13.0, *) {
            layer.frame = CGRect.init(x: 0, y: (v as AnyObject).frame.size.height - 0.5, width: ((v as AnyObject).frame?.width)!, height: 0.5)
        } else {
            // Fallback on earlier versions
            layer.frame = CGRect.init(x: 0, y: (v as AnyObject).size.height - 0.5, width: (v as AnyObject).size.width, height: 0.5)
        }
        layer.backgroundColor = UIColor.lightGray.cgColor
        (v as AnyObject).layer.addSublayer(layer)
        return v
    }
    
    func setupBTLabelView(v: UILabel) -> UILabel {
        let layer = CALayer.init()
        if #available(iOS 12.0, *) {
            layer.frame = CGRect.init(x: 0, y: (v as AnyObject).frame.size.height + 5, width: ((v as AnyObject).frame?.width)!, height: 0.5)
        } else {
            // Fallback on earlier versions
            layer.frame = CGRect.init(x: 0, y: (v as AnyObject).size.height + 5, width: (v as AnyObject).size.width, height: 0.5)
        }
        layer.backgroundColor = UIColor.lightGray.cgColor
        (v as AnyObject).layer.addSublayer(layer)
        return v
    }
    
    func setupBTButtonView(v: UIButton) -> UIButton {
        let layer = CALayer.init()
        if #available(iOS 12.0, *) {
            layer.frame = CGRect.init(x: 0, y: (v as AnyObject).frame.size.height + 5, width: ((v as AnyObject).frame?.width)!, height: 0.5)
        } else {
            // Fallback on earlier versions
            layer.frame = CGRect.init(x: 0, y: (v as AnyObject).size.height + 5, width: (v as AnyObject).size.width, height: 0.5)
        }
        layer.backgroundColor = UIColor.lightGray.cgColor
        (v as AnyObject).layer.addSublayer(layer)
        return v
    }
    
    func isValidEmail(strEmail:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let email = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return email.evaluate(with: strEmail)
    }
    
    func showAlertView(message: String, vc: UIViewController, showAlerCallback: ((_ message: String) -> Void)? = nil) -> Void {
        let alert = UIAlertController.init(title: "Thông báo", message: message, preferredStyle: UIAlertController.Style.alert)
        let actionOk = UIAlertAction.init(title: "Ok", style: .default) { (action) in
            switch action.style {
                
            case .default:
                if let callback = showAlerCallback {
//                    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { (time) in
                        callback(message)
//                    })
                }
            case .cancel:
                break
            case .destructive:
                break
            }
            vc.dismiss(animated: true, completion: nil)
        }
        alert.addAction(actionOk)
        vc.present(alert, animated: true, completion: nil)
    }
    
    func showAlertViewWithOkCancel(message: String, vc: UIViewController, showAlerCallback: ((_ message: String) -> Void)? = nil) -> Void {
        let alert = UIAlertController.init(title: "Thông báo", message: message, preferredStyle: UIAlertController.Style.alert)
        let actionOk = UIAlertAction.init(title: "Ok", style: .default) { (action) in
            switch action.style {
                
            case .default:
                if let callback = showAlerCallback {
                    //                    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { (time) in
                    callback(message)
                    //                    })
                }
            case .cancel:
                break
            case .destructive:
                break
            }
            vc.dismiss(animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction.init(title: "Huỷ", style: .default) { (nil) in
            vc.dismiss(animated: true, completion: nil)
        }
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        vc.present(alert, animated: true, completion: nil)
    }
    
    func callPhoneNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    application.openURL(phoneCallURL as URL)
                    
                }
            }
        }
    }
    
    func openWebsite(link: String){
        if let url = URL(string: link) {
            UIApplication.shared.open(url)
        }
    }
    
    func getCurrentLanguage() -> String{
        if UserDefaults.standard.object(forKey: info_language) != nil {
            let lang = UserDefaults.standard.object(forKey: info_language) as! String
            if (lang != "") {
                return lang
            }else{
                let language = Locale.preferredLanguages[0]
                return language.contains("vi") ? "vi" : "en"
            }
        }
        return "vi"
    }
    
    func translate(key: String) -> String{
        if !Settings.bundle.isLoaded {
            let language = self.getCurrentLanguage()
            let filePath = Bundle.main.path(forResource: language, ofType: "lproj")
            Settings.bundle = Bundle(path: filePath!)!
        }
        var result = Settings.bundle.localizedString(forKey: key, value: nil, table: nil)
        if result == "" {
            result = key
        }
        return result
    }
}

class customButton: UIButton {
    var indexPath: IndexPath?
}
