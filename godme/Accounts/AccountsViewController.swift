//
//  AccountsViewController.swift
//  godme
//
//  Created by Lê Hùng on 3/5/20.
//  Copyright © 2020 godme. All rights reserved.
//

import UIKit


class AccountsViewController: BaseViewController {

    @IBOutlet weak var collectionAccount: UICollectionView!
    
    let itemsPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 20.0,
                                             left: 10.0,
                                             bottom: 0.0,
                                             right: 10.0)
    var flowLayout = UICollectionViewFlowLayout()
    var arr : [[String:String]] = [["title":"wallet_finance", "icon" : "ic_wallet"],
                                ["title":"create_services", "icon" : "ic_service"],
                                ["title":"create_auction", "icon" : "ic_auction"],
                                ["title":"create_event", "icon" : "ic_event"],
                                ["title":"collaboration", "icon" : "ic_colloborate"],
                                ["title":"support_report", "icon" : "ic_help"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupCollectionView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.title = Settings.ShareInstance.translate(key: "account")
        self.collectionAccount.reloadData()
    }
    
    func setupUI(){
        self.tabBarController?.tabBar.isHidden = false
        let left = UIBarButtonItem.init(image: UIImage.init(named: "ic_people_white")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(touchLeft))
        self.navigationItem.leftBarButtonItem = left
        
        let right = UIBarButtonItem.init(image: UIImage.init(named: "ic_logout")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(touchRight))
        self.navigationItem.rightBarButtonItem = right
    }
    
    func setupCollectionView(){
        collectionAccount.delegate = self
        
        collectionAccount.dataSource = self
        self.collectionAccount.register(UINib.init(nibName: "AccountCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AccountCollectionViewCell")
        flowLayout.scrollDirection = .vertical
        self.collectionAccount.collectionViewLayout = flowLayout
//        self.collectionAccount.isScrollEnabled = false
    }
    
    @objc func touchLeft(){
        print("left")
        self.editProfile()
    }
    
    @objc func touchRight(){
        Settings.ShareInstance.showAlertViewWithOkCancel(message: "Bạn có muốn thoát ứng dụng?", vc: self) { [unowned self] (str) in
            self.showProgressHub()
            UserManager.shareUserManager().logout {[unowned self] (response) in
                switch response {
                    
                case .success(_):
                    self.hideProgressHub()
                    self.logoutSuccess()
                    
                    break
                case .failure(let message):
                    self.hideProgressHub()
                    Settings.ShareInstance.showAlertView(message: message, vc: self)
                    break
                }
            }
        }
    }
}

extension AccountsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCollectionViewCell",
                                                      for: indexPath) as! AccountCollectionViewCell
        let dict = arr[indexPath.row]
        cell.icon.image = UIImage.init(named: dict["icon"] ?? "")//UIImage.init(named: dict.object(forKey: "icon") as! String)
        cell.lbTitle.text = Settings.ShareInstance.translate(key: dict["title"] ?? "")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.tabBarController?.tabBar.isHidden = true
            switch indexPath.row {
            case 0:
                let finance = FinanceViewController()
                self.navigationController?.pushViewController(finance, animated: true)
                break
            case 1:
                let service = CreateServiceViewController()
                self.navigationController?.pushViewController(service, animated: true)
                break
            case 2:
                let auction = CreateAuctionViewController()
                self.navigationController?.pushViewController(auction, animated: true)
                break
            case 3:
                let event = CreateEventViewController()
                self.navigationController?.pushViewController(event, animated: true)
                break
            case 4:
//                let collaborate = CreateCollaborateViewController()
//                self.navigationController?.pushViewController(collaborate, animated: true)
                self.tabBarController?.tabBar.isHidden = false
                Settings.ShareInstance.openWebsite(link: "\(URLs.linkHostName)/coop")
                break
            case 5:
                let help = SupportViewController()
                self.navigationController?.pushViewController(help, animated: true)
                break
            case 6:


//                delegate?.eventPush(typeCellHome.Promotion)
//                let promotion = PromotionViewController.init(nibName: "PromotionViewController", bundle: nil)
//                HomeViewController.ShareInstance.pushTo(VC: promotion)
                break
            case 7:


//                delegate?.eventPush(typeCellHome.Ads)

//                let ads = AdsViewController.init(nibName: "AdsViewController", bundle: nil)
//                HomeViewController.ShareInstance.pushTo(VC: ads)
                break
//            case 8:
//               // delegate?.eventPush(typeCellHome.AirPlane)
//                break
                
            default:
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = self.view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}
