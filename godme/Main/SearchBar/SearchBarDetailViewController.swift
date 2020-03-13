//
//  SearchBarDetailViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/12/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit

class SearchBarDetailViewController: BaseViewController {
    
    var tabs = [
           ViewPagerTab(title: "Mối quan hệ", image: nil),
           ViewPagerTab(title: "Thông tin cơ bản", image: nil),
           ViewPagerTab(title: "Dịch vụ", image: nil),
       ]
           
       var viewPager: ViewPagerController!
       var options: ViewPagerOptions!

    @IBOutlet weak var vTop: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var imgMore: UIImageView!
    @IBOutlet weak var lbFullName: UILabel!
    @IBOutlet weak var lbSchool: UILabel!
    @IBOutlet weak var lbJob: UILabel!
    @IBOutlet weak var lbDegree: UILabel!
    @IBOutlet weak var lbCity: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.configButtonBack()
        self.configPageView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        options.viewPagerFrame = CGRect.init(x: self.view.bounds.origin.x, y: self.vTop.bounds.height, width: self.view.bounds.width, height: self.view.bounds.height)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        options.viewPagerFrame = CGRect.init(x: self.view.bounds.origin.x, y: self.vTop.bounds.height, width: self.view.bounds.width, height: self.view.bounds.height)//self.view.bounds
    }
    
    func configPageView() {
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        
        options = ViewPagerOptions(viewPagerWithFrame: CGRect.init(x: self.view.bounds.origin.x, y: self.vTop.bounds.height, width: self.view.bounds.width, height: self.view.bounds.height))
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
        options.tabImageName1 = "ic_page_post"
        options.tabImageName2 = "ic_manage_post"
        options.tabImageName3 = "ic_candidate"
        options.tabImageName1Active = "ic_page_post_active"
        options.tabImageName2Active = "ic_manage_post_active"
        options.tabImageName3Active = "ic_candidate_active"
        options.isTabHighlightAvailable = true
        viewPager = ViewPagerController()
        viewPager.options = options
        viewPager.dataSource = self
        
        
        self.addChild(viewPager)
        self.view.addSubview(viewPager.view)
        viewPager.didMove(toParent: self)
    }

}

extension SearchBarDetailViewController: ViewPagerControllerDataSource {
    
    func numberOfPages() -> Int {
        return tabs.count
    }
    
    func viewControllerAtPosition(position:Int) -> UIViewController {
        if position == 0 {
            return SearchBarRelationShipViewController()
        } else if position == 1 {
            return SearchBarInfoBaseViewController()
        }else {
            return SearchBarServiceViewController()
        }
    }
    
    func tabsForPages() -> [ViewPagerTab] {
        return tabs
    }
    
    func startViewPagerAtIndex() -> Int {
        return 0
    }
}
