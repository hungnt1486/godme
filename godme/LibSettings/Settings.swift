//
//  Settings.swift
//  MVVMRoot
//
//  Created by Lê Hùng on 8/8/18.
//  Copyright © 2018 Lê Hùng. All rights reserved.
//

import UIKit
import SwiftyJSON

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
    
    func getDictUser()-> UserLogin{
        var model = UserLogin()
        let dict = UserDefaults.standard.object(forKey: information_login) as! NSDictionary
        model.userId = dict.object(forKey: "userId") as? Int
        model.userName = dict.object(forKey: "userName") as! NSString as String
        model.access_token = dict.object(forKey: "access_token") as! NSString as String
        model.fullName = dict.object(forKey: "fullName") as! NSString as String
        model.permissions = dict.object(forKey: "permissions") as? [String]
        model.isFirstLogin = dict.object(forKey: "isFirstLogin") as? Bool
        return model
    }
    
//    func formatCurrency(Value: String) -> String{
//        let format = NumberFormatter()
//        format.numberStyle = .currency
//        format.currencyCode = "VND"
//        return format.string(from: NSNumber.init(value: Int(Value)!))!
//    }
    
    func formatCurrency(Value: String) -> String{
        let format = NumberFormatter()
        format.numberStyle = .currency
        format.currencyCode = "VND"
        if (Value.range(of: ".") != nil) {
//            let
//            let pos = Value.distance(from: Value.startIndex, to: idx)
//            print("Found \(needle) at position \(pos)")
            return format.string(from: NSNumber.init(value: Double(Value) ?? 0)) ?? ""
        }
        else {
            print("Not found")
            return format.string(from: NSNumber.init(value: Int(Value) ?? 0)) ?? ""
        }
        
//        return format.string(from: NSNumber.init(value: Float(Value)!))!
    }
    
    func setDictUser(data: UserLoginReturnModel){
        let dict = ["fullName": data.fullName ?? "",
                    "userName": data.userName ?? "",
                    "userId": data.userId ?? 0,
                    "access_token": data.access_token ?? "",
                    "isFirstLogin": data.isFirstLogin ?? "",
        "permissions": data.permissions ?? []] as [String: Any]
        
        UserDefaults.standard.set(dict, forKey: information_login)
        UserDefaults.standard.synchronize()
        BaseViewController.accessToken = data.access_token!
//        "result": {
//        "access_token": "toj0ndbtu3brpvt68imv4gdj82dfe1eq",
//        "permissions": [
//            "ROLE_ADMIN",
//            "ROLE_ALLOW_ACCESS_SYSTEM"
//        ],
//        "fullName": "Tai",
//        "userName": "+84admin",
//        "userId": 2
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
    
    func setupBTTextView(v: UITextView) -> UITextView {
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
    
    func setupTopV(v: UIView) -> UIView {
        let layer = CALayer.init()
        if #available(iOS 13.0, *) {
            layer.frame = CGRect.init(x: 0, y: 0.5, width: ((v as AnyObject).frame?.width)!, height: 0.5)
        } else {
            // Fallback on earlier versions
            layer.frame = CGRect.init(x: 0, y: 0.5, width: (v as AnyObject).size.width, height: 0.5)
        }
        layer.backgroundColor = UIColor.lightGray.cgColor
        (v as AnyObject).layer.addSublayer(layer)
        return v
    }
    
    func setupBTLabelView(v: UILabel) -> UILabel {
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
    
    func setupBTButtonView(v: UIButton) -> UIButton {
        let layer = CALayer.init()
        if #available(iOS 13.0, *) {
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
        let alert = UIAlertController.init(title: Settings.ShareInstance.translate(key: "label_alert"), message: message, preferredStyle: UIAlertController.Style.alert)
        let actionOk = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_ok"), style: .default) { (action) in
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
        let alert = UIAlertController.init(title: Settings.ShareInstance.translate(key: "label_alert"), message: message, preferredStyle: UIAlertController.Style.alert)
        let actionOk = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_ok"), style: .default) { (action) in
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
        let actionCancel = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_cancel"), style: .default) { (nil) in
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
                if #available(iOS 13.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    application.openURL(phoneCallURL as URL)
                    
                }
            }
        }
    }
    
    func openEmail(email: String){
        if let emailUrl = URL(string: "mailto:\(email)"){
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(emailUrl)) {
                if #available(iOS 13.0, *) {
                    application.open(emailUrl, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    application.openURL(emailUrl as URL)
                    
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
    
    func loadFileJson(name: String) -> JSON{
        var json: JSON?
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
//                json = try? JSONSerialization.jsonObject(with: data)
                json = try JSON.init(data: data, options: .fragmentsAllowed)
            } catch {
                // Handle error here
            }
        }
//        print(json)
        return json ?? JSON()
    }
    
    func getUDIDString() -> String {
        let udid = UIDevice.current.identifierForVendor?.uuidString
        return udid ?? ""
    }
    
    func loadProvince()-> [ProvinceArrModel] {
        let json = self.loadFileJson(name: "province")
        let data = ProvinceModel.init(json: json)
        return data!.ProvinceArr!
    }
    
    func loadCountry()-> [CountryArrModel] {
        let json = self.loadFileJson(name: "country")
        let data = CountryModel.init(json: json)
        return data!.CountryArr!
    }
    
    func loadDistrict()-> [DistrictArrModel] {
        let json = self.loadFileJson(name: "district")
        let data = DistrictModel.init(json: json)
        return data!.DistrictArr!
    }
    
    func loadWard()-> [WardArrModel] {
        let json = self.loadFileJson(name: "ward")
        let data = WardModel.init(json: json)
        return data!.WardArr!
    }
    
    func loadEducation() -> [EducationArrModel]{
        let json = self.loadFileJson(name: "educations")
        let data = EducationModel.init(json: json)
        return data!.EducationArr!
    }
    
    func Gender()->[GenderModel]{
        let jsonSex = "[{\"Name\":\"label_female\",\"Id\":NU}, {\"Name\":\"label_male\",\"Id\":NAM}]"
        let json = JSON.init(jsonSex)
        var arrGender: [GenderModel] = []
        for i in 0..<2 {
            switch i {
            case 0:
                let sexModel = GenderModel.init(json: json)
                sexModel?.Id = "NU"
                sexModel?.Name = "label_female"
                arrGender.append(sexModel!)
                break
            case 1:
                let sexModel = GenderModel.init(json: json)
                sexModel?.Id = "NAM"
                sexModel?.Name = "label_male"
                arrGender.append(sexModel!)
                break
            default:
                break
            }
        }
        return arrGender
    }
    
    func Languages() -> [GenderModel] {
        let jsonSex = "[{\"Name\":\"vietnamese\",\"Id\":vn}, {\"Name\":\"english\",\"Id\":en}]"
        let json = JSON.init(jsonSex)
        var arrGender: [GenderModel] = []
        for i in 0..<2 {
            switch i {
            case 0:
                let sexModel = GenderModel.init(json: json)
                sexModel?.Id = "vn"
                sexModel?.Name = "vietnamese"
                arrGender.append(sexModel!)
                break
            case 1:
                let sexModel = GenderModel.init(json: json)
                sexModel?.Id = "en"
                sexModel?.Name = "english"
                arrGender.append(sexModel!)
                break
            default:
                break
            }
        }
        return arrGender
    }
    
    func convertTimeIntervalToDateTime(timeInterval: Double)-> String{
        if timeInterval == 0 {
            return ""
        }
        let date = NSDate.init(timeIntervalSince1970: timeInterval/1000)
        let formatDate = DateFormatter.init()
        formatDate.dateFormat = "HH:mm, EEEE, dd/MM/yyyy"//"yyyy-MM-dd HH:mm"
        formatDate.locale = Locale.current
        let dateConvert = formatDate.string(from: date as Date)
        return dateConvert
    }
    
    func convertTimeIntervalToDateTimeForCountDown(timeInterval: Double)-> String{
        if timeInterval == 0 {
            return ""
        }
        let date = NSDate.init(timeIntervalSince1970: timeInterval/1000)
        let formatDate = DateFormatter.init()
        formatDate.dateFormat = "yyyy/MM/dd/HH/mm/ss"//"yyyy-MM-dd HH:mm"
        formatDate.locale = Locale.current
        let dateConvert = formatDate.string(from: date as Date)
        return dateConvert
    }
    
    func convertTimeIntervalToDate(timeInterval: Double)-> String{
        if timeInterval == 0 {
            return ""
        }
        let date = NSDate.init(timeIntervalSince1970: timeInterval/1000)
        let formatDate = DateFormatter.init()
        formatDate.dateFormat = "dd/MM/yyyy"//"yyyy-MM-dd HH:mm"
        formatDate.locale = Locale.current
        let dateConvert = formatDate.string(from: date as Date)
        return dateConvert
    }
    
    func convertDateToTimeInterval(date: Date) -> Double{
        return date.timeIntervalSince1970*1000
    }
    
    func convertDOB(str: String)-> String{
        let arr = str.split(separator: "T")
        if arr.count > 0 {
            let arr1 = arr[0].split(separator: "-")
            return "\(arr1[0])-\(arr1[1])-\(arr1[2])"
        }
        return ""
    }
     
}

class customButton: UIButton {
    var indexPath: IndexPath?
}
