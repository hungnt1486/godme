//
//  IntroduceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/3/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import FirebaseAuth
//import NDParallaxIntroView

class IntroduceViewController: BaseViewController {
    
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    
    var introV: IntroView!
    
    var pages = [
        ["title": "label_intro_1",
         "description": "label_intro_des_1",
         "imageView": "ic_intro_1"],
        ["title": "label_intro_2",
         "description": "label_intro_des_2",
         "imageView": "ic_intro_2"],
        ["title": "label_intro_3",
         "description": "label_intro_des_3",
         "imageView": "ic_intro_3"],
        ["title": "label_intro_4",
         "description": "label_intro_des_4",
         "imageView": "ic_intro_4"],
        ["title": "label_intro_5",
         "description": "label_intro_des_5",
         "imageView": "ic_intro_6"],
        ["title": "label_intro_6",
         "description": "label_intro_des_6",
         "imageView": "ic_intro_5"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.setupUI()
        }
        
//        PhoneAuthProvider.provider().verifyPhoneNumber("+84909301378", uiDelegate: nil) { (verificationID, error) in
//          if let error = error {
//            Settings.ShareInstance.showAlertView(message: error.localizedDescription, vc: self)
//            return
//          }
//          // Sign in using the verificationID and the code sent to the user
//          // ...
//        }
        
//        var date = Date(timeIntervalSince1970: 1415639000.67457)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd, MMM yyyy HH:mm:a"
////        dateFormatter.timeStyle = .long //Set time style
////        dateFormatter.dateStyle = .long //Set date style
////        dateFormatter.timeZone = TimeZone.ini
//        dateFormatter.locale = Locale(identifier: "UTC")
//        let localDate = dateFormatter.string(from: date)
//        print("localDate = \(localDate)")
//
//        let milliseconds=1578330000000
//
//        date = Date(timeIntervalSince1970: TimeInterval(milliseconds/1000))
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
//        formatter.locale = Locale(identifier: "en_US")//NSLocale(localeIdentifier: "en_US") as Locale!
//        print(formatter.string(from: date as Date))
////        Date.init()
//        print("guyg \(Date.currentTimeStamp)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        if UserDefaults.standard.object(forKey: information_login) != nil {
            DispatchQueue.main.async {
                self.setupUI()
                let modelUser = Settings.ShareInstance.getDictUser()
                BaseViewController.accessToken = modelUser.access_token ?? ""
                self.loginSuccess()
            }
        }else{
            DispatchQueue.main.async {
                self.setupUI()
            }
        }
    }
    
    func setupUI(){
    
        scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.FlatColor.Gray.BGColor
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        for index in 0..<pages.count {
            print(index)
            introV = IntroView.instanceFromNib()
            introV.delegate = self
            introV.tag = 10
            introV.data = pages[index]
            introV.configIntroView(frameView: self.view.frame, index: index)
            scrollView.addSubview(introV)
        }
        scrollView.contentSize = CGSize.init(width: UIScreen.main.bounds.width*CGFloat(pages.count), height: scrollView.frame.height)

        scrollView.bounces = false
        
        pageControl = UIPageControl.init(frame: CGRect.init(x: 0, y: UIScreen.main.bounds.height*0.6 - 30, width: 100, height: 10))
        pageControl.center.x = self.view.center.x
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = pages.count
        self.view.addSubview(pageControl)
    }
    
    func setupVIntro(){
        if introV == nil {
            for index in 0..<pages.count {
                print(index)
                introV = IntroView.instanceFromNib()
                introV.delegate = self
                introV.tag = 10
                introV.data = pages[index]
                introV.configIntroView(frameView: self.view.frame, index: index)
                scrollView.addSubview(introV)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if introV != nil {
            introV.viewWithTag(10)?.removeFromSuperview()
            introV = nil
        }
    }
}

extension IntroduceViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = UIScreen.main.bounds.width
        let pageFraction = self.scrollView.contentOffset.x/width
        self.pageControl.currentPage = Int(round(CGFloat(pageFraction)))
    }
}

extension IntroduceViewController: IntroViewProtocol{
    func didStart() {
        introV.viewWithTag(10)?.removeFromSuperview()
        introV = nil
        let login = LoginViewController()
        self.navigationController?.pushViewController(login, animated: true)
    }
    
    func didVN() {
        if introV != nil {
            introV.viewWithTag(10)?.removeFromSuperview()
            introV = nil
        }
        UserDefaults.standard.setValue("vi", forKey: info_language)
        UserDefaults.standard.synchronize()
        
        self.setupVIntro()
        print("viet nam")
        
//        var arrModel: [ProvinceArrModel] = []
//        let json = Settings.ShareInstance.loadFileJson(name: "province")
//        let data = ProvinceModel.init(json: json)
//        arrModel = data!.ProvinceArr!
//        print("gwgrg = ", arrModel[0].name)
//        let provinceModel = data![]
//        print("data = ", data)
        
    }
    
    func didEnglish() {
        if introV != nil {
            introV.viewWithTag(10)?.removeFromSuperview()
            introV = nil
        }
        UserDefaults.standard.setValue("en", forKey: info_language)
        UserDefaults.standard.synchronize()
        self.setupVIntro()
        print("english")
    }
    
    
}

//extension Double {
//    func getDateStringFromUTC() -> String {
//        let date = Date(timeIntervalSince1970: self)
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale.current//Locale(identifier: "en_US")
//        dateFormatter.dateStyle = .medium
//
//        return dateFormatter.string(from: date)
//    }
//}
//
//extension Date {
//    static var currentTimeStamp: Int64{
//        return Int64(Date().timeIntervalSince1970 * 1000)
//    }
//}
