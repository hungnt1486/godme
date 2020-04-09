//
//  BannerInfluencersTableViewCell.swift
//  ACCLAIM
//
//  Created by IMAC on 8/12/19.
//  Copyright © 2019 IMAC. All rights reserved.
//

import UIKit
import SDWebImage

protocol ImageDetailAuctionTableViewCellProtocol {
    func didShowMoreAuction()
    func didCopy()
}

class ImageDetailAuctionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var viewBanner: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var imgShowMore: UIImageView!
    @IBOutlet weak var lbFullName: UILabel!
    @IBOutlet weak var lbJob: UILabel!
    @IBOutlet weak var lbCoin: UILabel!
    @IBOutlet weak var lbCopy: UILabel!
    @IBOutlet weak var constraintHeightLabelCopy: NSLayoutConstraint!
    
    var delegate: ImageDetailAuctionTableViewCellProtocol?
    
    var arrImageBanner: [String] = [String]()
    weak var bannerTimer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(touchShowMore))
        self.imgShowMore.isUserInteractionEnabled = true
        self.imgShowMore.addGestureRecognizer(tapGesture)
        let tapCopy = UITapGestureRecognizer.init(target: self, action: #selector(touchCopy))
        tapCopy.numberOfTapsRequired = 1
        self.lbCopy.isUserInteractionEnabled = true
        self.lbCopy.addGestureRecognizer(tapCopy)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc func touchCopy(){
        delegate?.didCopy()
    }
    
    @objc func touchShowMore(){
        delegate?.didShowMoreAuction()
    }
    
    func crollViewImage() {
        for imageView in scrollView.subviews {
            imageView.removeFromSuperview()
        }
        
        var listImageView = [UIImageView]()
        var listImageViewName = [String]()
        for index in 0..<self.arrImageBanner.count {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTouchBanner))
            imageView.addGestureRecognizer(tapGesture)
            scrollView.addSubview(imageView)
            listImageView.append(imageView)
            let imageViewName = "view\(index)"
            listImageViewName.append(imageViewName)
            if let url = URL(string: arrImageBanner[index]) {
                imageView.sd_setImage(with: url, placeholderImage: UIImage.init(named: "ic_banner_default"), options: .lowPriority) { (img, error, nil, url) in
                    if error == nil {
                        imageView.image = img
                    }
                }
            }
        }
        
        var viewArr: [String: UIView] = ["view": scrollView]
        var hConstraintFormat = ""
        for (i, name) in listImageViewName.enumerated() {
            viewArr[name] = listImageView[i]
            
            self.viewBanner.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[\(name)(==view)]|", options: [], metrics: nil, views: viewArr))
            
            hConstraintFormat += "[\(name)(==view)]"
        }
        
        self.viewBanner.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|\(hConstraintFormat)|", options: [.alignAllCenterY], metrics: nil, views: viewArr))
        
        self.viewBanner.setNeedsLayout()
        
        bannerTimer?.invalidate()
        bannerTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(showNextPage), userInfo: nil, repeats: true)
    }
    
    @objc func didTouchBanner() {
        
    }
    
    @objc func showNextPage() {
        let pageWidth: CGFloat = scrollView.frame.size.width
        let currentPage = lround(Double(scrollView.contentOffset.x / pageWidth))
        let nextPage: CGFloat = CGFloat((currentPage + 1) % self.arrImageBanner.count)
        if nextPage < CGFloat(self.arrImageBanner.count) {
            scrollView.setContentOffset(CGPoint(x: nextPage * pageWidth, y: 0), animated: true)
        }
    }
    
    func configCrollView() {
        scrollView.isPagingEnabled = true
        pageView.numberOfPages = (self.arrImageBanner.count)
        scrollView.delegate = self
    }
    
}

extension ImageDetailAuctionTableViewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let pageWidth = scrollView.frame.size.width
            let fractionalPage = scrollView.contentOffset.x / pageWidth
            let page = lroundf(Float(fractionalPage))
            if page != pageView.currentPage {
                pageView.currentPage = page
            }
        }
    }
}
