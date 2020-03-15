//
//  IntroduceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/3/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
//import NDParallaxIntroView

class IntroduceViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    
    var introV: IntroView!
    
    var pages = [
        ["title": "Quản trị mối quan hệ",
         "description": "Giúp bạn quản lý thông tin chi tiết các mối quan hệ chất lượng.",
         "imageView": "ic_intro_1"],
        ["title": "Kết nối đúng người đúng việc",
         "description": "Kết nối mở rộng mối quan hệ theo ngành, theo địa lý, hợp tác kinh doanh dự án.",
         "imageView": "ic_intro_2"],
        ["title": "Gia tăng thu nhập dựa trên những mối quan hệ bạn sở hữu",
         "description": "Tạo dòng tài chính thu nhập thụ động từ những mối quan hệ chất lượng do bạn sở hữu.",
         "imageView": "ic_intro_3"],
        ["title": "Tự tạo ra dịch vụ từ giá trị bản thân",
         "description": "Quản trị kiến thức và khả năng của bạn để tạo các dịch vụ chia sẽ giúp gia tăng mối quan hệ và tài chính.",
         "imageView": "ic_intro_4"],
        ["title": "Sản phẩm liên kết - Godme tạo một kho sản phẩm chất",
         "description": "Người dùng vừa có thể cung cấp sản phẩm vừa trở thành CTV liên kết bán hàng.",
         "imageView": "ic_intro_6"],
        ["title": "Đóng góp xã hội cho quỹ từ thiện Godme",
         "description": "Mỗi kết nối thành công trong hệ thống sẽ được trích tự động và công khai một phần tài chính vào quỹ từ thiện Godme Charity.",
         "imageView": "ic_intro_5"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.setupUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        DispatchQueue.main.async {
            self.setupUI()
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
