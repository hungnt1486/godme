//
//  IntroduceViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/3/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import NDParallaxIntroView

class IntroduceViewController: UIViewController {
    
    var intro = NDIntroView()
    
    var pages = [
        [kNDIntroPageTitle: "Quản trị mối quan hệ", kNDIntroPageDescription: "Giúp bạn quản lý thông tin chi tiết các mối quan hệ chất lượng.", kNDIntroPageImageName: "ic_intro_1"],
        [kNDIntroPageTitle: "Kết nối đúng người đúng việc", kNDIntroPageDescription: "Kết nối mở rộng mối quan hệ theo ngành, theo địa lý, hợp tác kinh doanh dự án.", kNDIntroPageImageName: "ic_intro_2"],
        [kNDIntroPageTitle: "Gia tăng thu nhập dựa trên những mối quan hệ bạn sở hữu", kNDIntroPageDescription: "Tạo dòng tài chính thu nhập thụ động từ những mối quan hệ chất lượng do bạn sở hữu.", kNDIntroPageImageName: "ic_intro_3"],
        [kNDIntroPageTitle: "Tự tạo ra dịch vụ từ giá trị bản thân", kNDIntroPageDescription: "Quản trị kiến thức và khả năng của bạn để tạo các dịch vụ chia sẽ giúp gia tăng mối quan hệ và tài chính.", kNDIntroPageImageName: "ic_intro_4"],
        [kNDIntroPageTitle: "Đóng góp xã hội cho quỹ từ thiện Godme", kNDIntroPageDescription: "Mỗi kết nối thành công trong hệ thống sẽ được trích tự động và công khai một phần tài chính vào quỹ từ thiện Godme Charity.", kNDIntroPageImageName: "ic_intro_5"],
        [kNDIntroPageTitle: "Đóng góp xã hội cho quỹ từ thiện Godme", kNDIntroPageDescription: "Mỗi kết nối thành công trong hệ thống sẽ được trích tự động và công khai một phần tài chính vào quỹ từ thiện Godme Charity.", kNDIntroPageImageName: "ic_intro_6"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        startIntro()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func startIntro(){
        self.intro = NDIntroView.init(frame: self.view.frame, parallaxImage: UIImage.init(named: "parallaxBgImage"), andData: pages)
        self.intro.delegate = self
        self.view.addSubview(self.intro)
        
        
    }
}

extension IntroduceViewController: NDIntroViewDelegate{
    func launchAppButtonPressed() {
        print("gwewgwg")
        let login = LoginViewController()
        self.navigationController?.pushViewController(login, animated: true)
    }
    
    
}
