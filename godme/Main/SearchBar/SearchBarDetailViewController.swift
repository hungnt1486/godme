//
//  SearchBarDetailViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/12/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit
import SDWebImage

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
    var vImgStars: VImageStarsOranges!
    @IBOutlet weak var vImgStar: UIView!
    @IBOutlet weak var btConnect: UIButton!
    @IBOutlet weak var lbSlogan: UILabel!
    @IBOutlet weak var constraintHeightLabelSlogan: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightButtonConnect: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightViewTop: NSLayoutConstraint!
    var modelDetail: UserRegisterReturnModel?
    var searchBarInfo = SearchBarInfoBaseViewController()
    var searchBarMyRelationShip = SearchBarRelationShipViewController()
    var searchBarService = SearchBarServiceViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.setupUI()
        }
        self.configButtonBack()
        self.configPageView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Settings.ShareInstance.translate(key: "info_user")
    }
    
    func setupUI(){
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        if self.modelDetail?.isConnected == 1 {
//            self.constraintHeightViewTop.constant = 250 - 40 - 40
            self.btConnect.isHidden = true
            self.constraintHeightLabelSlogan.constant = 0
            self.constraintHeightButtonConnect.constant = 0
        }
        
        self.btConnect = Settings.ShareInstance.setupButton(button: self.btConnect)
        self.btConnect.setBorder()
        
        self.imgAvatar.sd_setImage(with: URL.init(string: modelDetail?.avatar ?? ""), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
            if error == nil {
                self.imgAvatar.image = image
            }
        }
        
        vImgStars = VImageStarsOranges.instanceFromNib()
        
        self.vImgStar.addSubview(vImgStars)
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseOut, animations: {
            self.vImgStars.configVImageStarsOranges(frameView: self.vImgStar.frame, index: self.modelDetail?.totalStar ?? 0.0)
        }, completion: nil)
        
        self.lbFullName.text = modelDetail?.fullName ?? ""
        self.lbSchool.text = Settings.ShareInstance.convertDOB(str: modelDetail?.dob ?? "")
        self.lbJob.text = modelDetail?.address ?? ""
        let career = modelDetail?.career
        let arrCareer = career?.split(separator: ",")
        var strCareer = ""
        for item in arrCareer! {
            for item1 in BaseViewController.arrayJobs {
                if Int(item) == Int(item1["code"] ?? "0") {
                    if strCareer.count == 0 {
                        strCareer = strCareer + item1["name"]!
                    }else {
                        strCareer = strCareer + ", " + item1["name"]!
                    }
                }
            }
        }
        self.lbDegree.text = strCareer
        self.lbCity.text = modelDetail?.email ?? ""
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if modelDetail?.isConnected == 1 {
            self.constraintHeightViewTop.constant = 180
        }else{
            self.constraintHeightViewTop.constant = 250
        }
        options.viewPagerFrame = CGRect.init(x: self.view.bounds.origin.x, y: self.constraintHeightViewTop.constant, width: self.view.bounds.width, height: self.view.bounds.height + (self.tabBarController?.tabBar.frame.height)!)
    }
    
    func configPageView() {
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        
        options = ViewPagerOptions(viewPagerWithFrame: CGRect.init(x: self.view.bounds.origin.x, y: self.vTop.bounds.height, width: self.view.bounds.width, height: self.view.bounds.height + (self.tabBarController?.tabBar.frame.height)!))
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
    
    func connectToUser(toUserId: Int){
        RelationShipsManager.shareRelationShipsManager().connectToUserRelationShip(toUserId: toUserId) { [unowned self](response) in
            switch response {
                
            case .success(_):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: "Gửi yêu cầu kết nối thành công", vc: self)
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    @IBAction func touchConnect(_ sender: Any) {
        self.showProgressHub()
        self.connectToUser(toUserId: self.modelDetail?.id ?? 0)
    }
    
}

extension SearchBarDetailViewController: ViewPagerControllerDataSource {
    
    func numberOfPages() -> Int {
        return tabs.count
    }
    
    func viewControllerAtPosition(position:Int) -> UIViewController {
        if position == 0 {
            searchBarMyRelationShip.modelDetail = self.modelDetail
            return searchBarMyRelationShip
        } else if position == 1 {
            searchBarInfo.modelDetail = self.modelDetail
            return searchBarInfo
        }else {
            searchBarService.modelDetail = self.modelDetail
            return searchBarService
        }
    }
    
    func tabsForPages() -> [ViewPagerTab] {
        return tabs
    }
    
    func startViewPagerAtIndex() -> Int {
        return 0
    }
}
