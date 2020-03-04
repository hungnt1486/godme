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
    }
    
    
    func startIntro(){
        
//        NSArray *pageContentArray = @[@{kNDIntroPageTitle : @"NDParallaxIntroView",
//                                        kNDIntroPageDescription : @"Now you can easily add your beautiful intro into your app with no hassle.",
//                                        kNDIntroPageImageName : @"parallax"
//                                        },
//                                      @{kNDIntroPageTitle : @"Work-It-Out",
//                                        kNDIntroPageDescription : @"A great App to create your own personal workout and get instructed by your phone.",
//                                        kNDIntroPageImageName : @"workitout"
//                                        },
//                                      @{kNDIntroPageTitle : @"ColorSkill",
//                                        kNDIntroPageDescription : @"A small game while waiting for the bus. Easy, quick and addictive.",
//                                        kNDIntroPageImageName : @"colorskill"
//                                        },
//                                      @{kNDIntroPageTitle : @"Appreciate",
//                                        kNDIntroPageDescription : @"A little helper to make your life happier. Soon available on the AppStore",
//                                        kNDIntroPageImageName : @"appreciate"
//                                        },
//                                      @{kNDIntroPageTitle : @"Do you like it?",
//                                        kNDIntroPageImageName : @"firstImage",
//                                        kNDIntroPageTitleLabelHeightConstraintValue : @0,
//                                        kNDIntroPageImageHorizontalConstraintValue : @-40
//                                        }
//                                      ];
        
//        self.introView = [[NDIntroView alloc] initWithFrame:self.view.frame parallaxImage:[UIImage imageNamed:@"parallaxBgImage"] andData:pageContentArray];
//        self.introView.delegate = self;
//        [self.view addSubview:self.introView];
        
        self.intro = NDIntroView.init(frame: self.view.frame, parallaxImage: UIImage.init(named: "parallaxBgImage"), andData: pages)
        self.intro.delegate = self
        self.view.addSubview(self.intro)
        
        
    }
}

extension IntroduceViewController: NDIntroViewDelegate{
    func launchAppButtonPressed() {
        print("gwewgwg")
    }
    
    
}
