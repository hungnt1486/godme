//
//  RelationshipsViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/5/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class RelationshipsViewController: BaseViewController {
    
    var tabs = [
        ViewPagerTab(title: "Các mối quan hệ", image: nil),
        ViewPagerTab(title: "MQH mở rộng", image: nil),
        ViewPagerTab(title: "Danh sách ẩn", image: nil),
        ViewPagerTab(title: "Nhóm mối quan hệ", image: nil),
    ]
        
    var viewPager: ViewPagerController!
    var options: ViewPagerOptions!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.configPageView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "relationships")
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupUI(){
        
        let left = UIBarButtonItem.init(image: UIImage.init(named: "ic_people_white")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(touchLeft))
        self.navigationItem.leftBarButtonItem = left
        
        let right = UIBarButtonItem.init(image: UIImage.init(named: "ic_notification_fast")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(touchRight))
        let right1 = UIBarButtonItem.init(image: UIImage.init(named: "ic_more_horizol")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(touchRight1))
        self.navigationItem.rightBarButtonItems = [right1, right]
    }
    
    @objc func touchLeft(){
        print("left")
        self.editProfile()
    }
    
    @objc func touchRight(){
        let pushNotification = PushNotificationViewController()
        self.navigationController?.pushViewController(pushNotification, animated: true)
    }
    
    @objc func touchRight1(){
        let alertControl = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let action2 = UIAlertAction.init(title: "Nhóm mối quan hệ", style: .default) {(action) in
            alertControl.dismiss(animated: true, completion: nil)
            let listGroup = ListGroupRelationShipViewController()
            self.navigationController?.pushViewController(listGroup, animated: true)
        }
        let action1 = UIAlertAction.init(title: "Gia hạn mối quan hệ", style: .default) {(action) in
            alertControl.dismiss(animated: true, completion: nil)
            let continueMyRelationShip = ContinueMyRelationShipViewController()
            self.navigationController?.pushViewController(continueMyRelationShip, animated: true)
        }
        let actionCancel = UIAlertAction.init(title: "Huỷ", style: .cancel) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        alertControl.addAction(action2)
        alertControl.addAction(action1)
        alertControl.addAction(actionCancel)
        self.navigationController?.present(alertControl, animated: true, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        options.viewPagerFrame = self.view.bounds
    }
    
    func configPageView() {
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        
        options = ViewPagerOptions(viewPagerWithFrame: self.view.bounds)
        options.tabViewHeight = 50.0
        options.tabType = ViewPagerTabType.imageWithText
        options.tabViewImageSize = CGSize(width: 20, height: 20)
        options.tabViewTextFont = UIFont(name: "Roboto-Medium", size: 15.0)!
        options.tabViewPaddingLeft = 25
        options.tabViewPaddingRight = 25
//        if #available(iOS 13.0, *) {
//            options.tabViewBackgroundDefaultColor = UIColor.systemBackground
//            options.tabViewBackgroundHighlightColor = UIColor.systemBackground
//            options.tabViewTextDefaultColor = UIColor.label
//
//        } else {
//            options.tabViewBackgroundDefaultColor = UIColor.white
//            options.tabViewBackgroundHighlightColor = UIColor.white
//            options.tabViewTextDefaultColor = "#080000".colorFromHexString()
//
//        }
        
//        options.tabViewTextHighlightColor = Color.appColor.colorFromHexString()
//        options.tabIndicatorViewBackgroundColor = Color.appColor.colorFromHexString()
//        options.tabImageName1 = "ic_page_post"
//        options.tabImageName2 = "ic_manage_post"
//        options.tabImageName3 = "ic_candidate"
//        options.tabImageName1Active = "ic_page_post_active"
//        options.tabImageName2Active = "ic_manage_post_active"
//        options.tabImageName3Active = "ic_candidate_active"
        options.isTabHighlightAvailable = true
        viewPager = ViewPagerController()
        viewPager.options = options
        viewPager.dataSource = self
        
        
        self.addChild(viewPager)
        self.view.addSubview(viewPager.view)
        viewPager.didMove(toParent: self)
    }
}

extension RelationshipsViewController: ViewPagerControllerDataSource {
    
    func numberOfPages() -> Int {
        return tabs.count
    }
    
    func viewControllerAtPosition(position:Int) -> UIViewController {
        if position == 0 {
            return MyRelationShipViewController()
        } else if position == 1 {
            return MyRelationShipExpandViewController()
        }else if position == 2{
            return ListHiddenViewController()
        }else{
            return MyGroupRelationShipExpandViewController()
        }
    }
    
    func tabsForPages() -> [ViewPagerTab] {
        return tabs
    }
    
    func startViewPagerAtIndex() -> Int {
        return 0
    }
}
