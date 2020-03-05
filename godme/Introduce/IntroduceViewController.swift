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
        [kNDIntroPageTitle: "NDParallaxIntroView", kNDIntroPageDescription: "Now you can easily add your beautiful intro into your app with no hassle.", kNDIntroPageImageName: "parallax"],
        [kNDIntroPageTitle: "NDParallaxIntroView", kNDIntroPageDescription: "Now you can easily add your beautiful intro into your app with no hassle.", kNDIntroPageImageName: "workitout"],
        [kNDIntroPageTitle: "NDParallaxIntroView", kNDIntroPageDescription: "Now you can easily add your beautiful intro into your app with no hassle.", kNDIntroPageImageName: "colorskill"],
        [kNDIntroPageTitle: "NDParallaxIntroView", kNDIntroPageDescription: "Now you can easily add your beautiful intro into your app with no hassle.", kNDIntroPageImageName: "appreciate"],
        [kNDIntroPageTitle: "NDParallaxIntroView", kNDIntroPageDescription: "Now you can easily add your beautiful intro into your app with no hassle.", kNDIntroPageImageName: "firstImage"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        startIntro()
        for family: String in UIFont.familyNames
        {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
        
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
