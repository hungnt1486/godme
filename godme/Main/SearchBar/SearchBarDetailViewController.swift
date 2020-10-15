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
           ViewPagerTab(title: Settings.ShareInstance.translate(key: "label_relationship"), image: nil),
           ViewPagerTab(title: Settings.ShareInstance.translate(key: "label_basic_info"), image: nil),
           ViewPagerTab(title: Settings.ShareInstance.translate(key: "label_services"), image: nil),
           ViewPagerTab(title: Settings.ShareInstance.translate(key: "label_rate_title"), image: nil),
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
    @IBOutlet weak var lbVote: UILabel!
    @IBOutlet weak var constraintHeightLabelSlogan: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightButtonConnect: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightViewTop: NSLayoutConstraint!
    var modelDetail: UserRegisterReturnModel?
    var userId: Int = 0
    var searchBarInfo = SearchBarInfoBaseViewController()
    var searchBarMyRelationShip = SearchBarRelationShipViewController()
    var searchBarService = SearchBarServiceViewController()
    var searchBarVote = SearchBarVoteViewController()
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var constraintHeightLabelEmail: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightIconEmail: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightLabelPhone: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightIconPhone: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightPhoneToEmail: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightEmailToEducation: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showProgressHub()
        self.getSearchDetailById()
//        DispatchQueue.main.async {
//            self.setupUI()
//        }
        
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
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(showMore))
        tapGesture.numberOfTouchesRequired = 1
        self.imgMore.isUserInteractionEnabled = true
        self.imgMore.addGestureRecognizer(tapGesture)
        
        let tapEmail = UITapGestureRecognizer.init(target: self, action: #selector(touchEmail))
        self.lbCity.isUserInteractionEnabled = true
        self.lbCity.addGestureRecognizer(tapEmail)
        
        let tapPhone = UITapGestureRecognizer.init(target: self, action: #selector(touchPhone))
        self.lbPhone.isUserInteractionEnabled = true
        self.lbPhone.addGestureRecognizer(tapPhone)
        
        self.lbVote.text = Settings.ShareInstance.translate(key: "label_rate")
        self.btConnect.setTitle(Settings.ShareInstance.translate(key: "label_connect"), for: .normal)
        self.lbSlogan.text = Settings.ShareInstance.translate(key: "label_per_network_for_grow_up")
        
        
        self.btConnect = Settings.ShareInstance.setupButton(button: self.btConnect)
        self.btConnect.setBorder()
        
        if self.modelDetail?.isConnected == 1 {
            self.btConnect.isHidden = true
            self.constraintHeightLabelSlogan.constant = 0
            self.constraintHeightButtonConnect.constant = 0
        }else{
            self.constraintHeightLabelEmail.constant = 0
            self.constraintHeightIconEmail.constant = 0
            self.constraintHeightIconPhone.constant = 0
            self.constraintHeightLabelPhone.constant = 0
            self.constraintHeightPhoneToEmail.constant = 0
            self.constraintHeightEmailToEducation.constant = 0
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.modelDetail?.isConnected == 1 {
            self.constraintHeightViewTop.constant = 210
        }else{
            self.constraintHeightViewTop.constant = 230
        }
        options.viewPagerFrame = CGRect.init(x: self.view.bounds.origin.x, y: self.constraintHeightViewTop.constant, width: self.view.bounds.width, height: self.view.bounds.height + (self.tabBarController?.tabBar.frame.height)!)
    }
    
    @objc func touchEmail(){
        Settings.ShareInstance.openEmail(email: self.modelDetail?.email ?? "")
    }
    
    @objc func touchPhone(){
        Settings.ShareInstance.callPhoneNumber(phoneNumber: self.modelDetail?.phoneNumber ?? "")
    }
    
    @objc func showMore(){
        let alertControl = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_copy_link_profile"), style: .default) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
            UIPasteboard.general.string = "\(URLs.linkUserInfo)\(self.modelDetail?.id ?? 0)"
            self.showToast()
        }
        
        let action = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_report"), style: .default) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
            let help = HelpViewController()
            self.navigationController?.pushViewController(help, animated: true)
        }
        let actionCancel = UIAlertAction.init(title: Settings.ShareInstance.translate(key: "label_cancel"), style: .cancel) { (action) in
            alertControl.dismiss(animated: true, completion: nil)
        }
        alertControl.addAction(action1)
        alertControl.addAction(action)
        alertControl.addAction(actionCancel)
        self.navigationController?.present(alertControl, animated: true, completion: nil)
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
                Settings.ShareInstance.showAlertView(message: Settings.ShareInstance.translate(key: "label_request_connect_success"), vc: self)
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
    
    func getSearchDetailById(){
        UserManager.shareUserManager().getSearchDetailById(id: userId) { [unowned self](response) in
            switch response {
                
            case .success(let data):
                self.hideProgressHub()
                DispatchQueue.main.async {
                    self.modelDetail = data[0]
                    self.setupUI()
                    self.configPageView()
                    self.viewDidLayoutSubviews()
                    self.imgAvatar.sd_setImage(with: URL.init(string: self.modelDetail?.avatar ?? ""), placeholderImage: UIImage.init(named: "ic_logo"), options: .lowPriority) { (image, error, nil, link) in
                        if error == nil {
                            self.imgAvatar.image = image
                        }
                    }
                    
                    self.vImgStars = VImageStarsOranges.instanceFromNib()
                    
                    self.vImgStar.addSubview(self.vImgStars)
                    UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveEaseOut, animations: {
                        self.vImgStars.configVImageStarsOranges(frameView: self.vImgStar.frame, index: self.modelDetail?.totalStar ?? 0.0)
                    }, completion: nil)
                    
                    self.lbFullName.text = self.modelDetail?.fullName ?? ""
                    self.lbSchool.text = Settings.ShareInstance.convertDOB(str: self.modelDetail?.dob ?? "")
                    self.lbJob.text = self.modelDetail?.address ?? ""
                    let career = self.modelDetail?.career
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
                                break
                            }
                        }
                    }
                    self.lbDegree.text = strCareer
                    self.lbCity.text = self.modelDetail?.email ?? ""
                    self.lbPhone.text = self.modelDetail?.phoneNumber ?? ""
                }
                break
            case .failure(let message):
                self.hideProgressHub()
                Settings.ShareInstance.showAlertView(message: message, vc: self)
                break
            }
        }
    }
    
}

extension SearchBarDetailViewController: ViewPagerControllerDataSource {
    
    func numberOfPages() -> Int {
        return tabs.count
    }
    
    func viewControllerAtPosition(position:Int) -> UIViewController {
        if position == 0 {
            searchBarMyRelationShip.userId = self.userId
            return searchBarMyRelationShip
        } else if position == 1 {
            searchBarInfo.modelDetail = self.modelDetail
            return searchBarInfo
        }else if position == 2 {
            searchBarService.modelDetail = self.modelDetail
            return searchBarService
        }else{
            searchBarVote.modelDetail = self.modelDetail
            return searchBarVote
        }
    }
    
    func tabsForPages() -> [ViewPagerTab] {
        return tabs
    }
    
    func startViewPagerAtIndex() -> Int {
        return 0
    }
}
