//
//  ViewPagerTabView.swift
//  ViewPager-Swift
//  hune
//
//  Created by Apple on 9/10/19.
//  Copyright © 2019 Tien. All rights reserved.
//

import UIKit

public final class ViewPagerTabView: UIView {
    
    internal enum SetupCondition {
        case fitAllTabs
        case distributeNormally
    }
    
    internal var titleLabel:UILabel?
    internal var imageView:UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    internal func setup(tab:ViewPagerTab, options:ViewPagerOptions , condition:SetupCondition) {
        
        switch options.tabType {
            
        case ViewPagerTabType.basic:
            setupBasicTab(condition: condition, options: options, tab: tab)
            
        case ViewPagerTabType.image:
            setupImageTab(condition: condition, withText: false,options: options, tab:tab)
            
        case ViewPagerTabType.imageWithText:
            setupImageTab(condition: condition, withText: true, options: options, tab:tab)
        }
    }
    
    
    fileprivate func setupBasicTab(condition:SetupCondition, options:ViewPagerOptions, tab:ViewPagerTab) {
        
        switch condition {
            
        case .fitAllTabs:
            
            buildTitleLabel(withOptions: options, text: tab.title)
            titleLabel?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            
        case .distributeNormally:
            
            buildTitleLabel(withOptions: options, text: tab.title)
            
            // Resetting TabView frame again with the new width
            let currentFrame = self.frame
            let labelWidth = titleLabel!.intrinsicContentSize.width + options.tabViewPaddingLeft + options.tabViewPaddingRight
            let newFrame = CGRect(x: currentFrame.origin.x, y: currentFrame.origin.y, width: labelWidth, height: currentFrame.height)
            self.frame = newFrame
            
            // Setting TitleLabel frame
            titleLabel?.frame = CGRect(x: 0, y: 0, width: labelWidth, height: currentFrame.height)
        }
        
        self.addSubview(titleLabel!)
    }
    

    fileprivate func setupImageTab(condition:SetupCondition, withText:Bool, options:ViewPagerOptions, tab:ViewPagerTab) {
        
        let imageSize = options.tabViewImageSize
        
        switch condition {
            
        case .fitAllTabs:
            
            let tabHeight = options.tabViewHeight
            let tabWidth = self.frame.size.width
            
            if withText {
                
                // Calculate image position
                let xImagePosition:CGFloat = (tabWidth - imageSize.width) / 2
                let yImagePosition:CGFloat = options.tabViewImageMarginTop
                
                // calculating text position
                let xTextPosition:CGFloat = 0
                let yTextPosition:CGFloat = yImagePosition + options.tabViewImageMarginBottom + imageSize.height
                let textHeight:CGFloat = options.tabViewHeight - yTextPosition - options.tabIndicatorViewHeight
                
                // Creating image view
                buildImageView(withOptions: options, image: tab.image)
                imageView?.frame = CGRect(x: xImagePosition, y: yImagePosition, width: imageSize.width, height: imageSize.height)
                
                // Creating text label
                buildTitleLabel(withOptions: options, text: tab.title)
                titleLabel?.frame = CGRect(x: xTextPosition, y: yTextPosition, width: frame.size.width, height: textHeight)
                
                self.addSubview(imageView!)
                self.addSubview(titleLabel!)
                
            } else {
                
                // Calculate image position
                let xPosition = ( tabWidth - imageSize.width ) / 2
                let yPosition = ( tabHeight - imageSize.height ) / 2
                
                // Creating imageview
                buildImageView(withOptions: options, image: tab.image)
                imageView?.frame = CGRect(x: xPosition, y: yPosition, width: imageSize.width, height: imageSize.height)
                
                self.addSubview(imageView!)
            }
            
            
        case .distributeNormally:
            
            if withText {
                
                // Creating image view
                buildImageView(withOptions: options, image: tab.image)
                
                // Creating text label
                buildTitleLabel(withOptions: options, text: tab.title)
                
                // Resetting tabview frame again with the new width
                let widthFromImage = imageSize.width + options.tabViewPaddingRight + options.tabViewPaddingLeft
                let widthFromText = titleLabel!.intrinsicContentSize.width + options.tabViewPaddingLeft + options.tabViewPaddingRight
                let tabWidth = (widthFromImage > widthFromText ) ? widthFromImage : widthFromText
                let currentFrame = self.frame
                let newFrame = CGRect(x: currentFrame.origin.x, y: currentFrame.origin.y, width: tabWidth, height: currentFrame.height)
                self.frame = newFrame

                // Setting imageview frame
                let xImagePosition:CGFloat  = 0
                let yImagePosition:CGFloat = options.tabViewHeight/2 - imageSize.height/2
                imageView?.frame = CGRect(x: xImagePosition + 20, y: yImagePosition , width: imageSize.width, height: imageSize.height)

                // Setting titleLabel frame
                let xTextPosition:CGFloat = imageSize.width + 5.0
                let yTextPosition = options.tabViewHeight/2 - imageSize.height/2
                let textHeight:CGFloat = imageSize.height
                titleLabel?.frame = CGRect(x: xTextPosition + 20, y: yTextPosition, width: widthFromText, height: textHeight)
            
                self.addSubview(imageView!)
                self.addSubview(titleLabel!)
                
            } else {
                
                // Creating imageview
                buildImageView(withOptions: options, image: tab.image)
                
                // Resetting TabView frame again with the new width
                let currentFrame = self.frame
                let tabWidth = imageSize.width + options.tabViewPaddingRight + options.tabViewPaddingLeft
                let newFrame = CGRect(x: currentFrame.origin.x, y: currentFrame.origin.y, width: tabWidth, height: currentFrame.height)
                self.frame = newFrame
                
                // Setting ImageView Frame
                let xPosition = ( tabWidth - imageSize.width ) / 2
                let yPosition = (options.tabViewHeight - imageSize.height ) / 2
                imageView?.frame = CGRect(x: xPosition, y: yPosition, width: imageSize.width, height: imageSize.height)
                
                self.addSubview(imageView!)
            }
        }        
    }
    
    fileprivate func buildTitleLabel(withOptions options:ViewPagerOptions, text:String) {
        
        titleLabel = UILabel()
        titleLabel?.textAlignment = .left
        titleLabel?.textColor = options.tabViewTextDefaultColor
        titleLabel?.numberOfLines = 0
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.font = options.tabViewTextFont
        titleLabel?.text = text
    }
    
    fileprivate func buildImageView(withOptions options:ViewPagerOptions, image:UIImage?) {
        
        imageView = UIImageView()
        imageView?.contentMode = .scaleAspectFit
        imageView?.image = image
    }
    

    internal func updateFrame(atIndex index:Int, withWidth width:CGFloat, options:ViewPagerOptions) {
        
        // Updating frame of the TabView
        let tabViewCurrentFrame = self.frame
        let tabViewXPosition = CGFloat(index) * width
        let tabViewNewFrame = CGRect(x: tabViewXPosition, y: tabViewCurrentFrame.origin.y, width: width, height: tabViewCurrentFrame.height)
        self.frame = tabViewNewFrame
        
        switch options.tabType {
            
        case .basic:
            
            // Updating frame for titleLabel
            titleLabel?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            
            self.setNeedsUpdateConstraints()
            
        case .image:
            
            // Updating frame for ImageView
            let xPosition = ( width - options.tabViewImageSize.width ) / 2
            let yPosition = (options.tabViewHeight - options.tabViewImageSize.height ) / 2
            imageView?.frame = CGRect(x: xPosition, y: yPosition, width: options.tabViewImageSize.width, height: options.tabViewImageSize.height)
            
            self.setNeedsUpdateConstraints()
            
        case .imageWithText:
            
            // Setting imageview frame
            let xImagePosition:CGFloat  = (width - options.tabViewImageSize.width) / 2
            let yImagePosition:CGFloat = options.tabViewImageMarginTop
            imageView?.frame = CGRect(x: xImagePosition, y: yImagePosition , width: options.tabViewImageSize.width, height: options.tabViewImageSize.height)
            
            // Setting titleLabel frame
            let xTextPosition:CGFloat = 0
            let yTextPosition = yImagePosition + options.tabViewImageMarginBottom + options.tabViewImageSize.height
            let textHeight:CGFloat = options.tabViewHeight - yTextPosition - options.tabIndicatorViewHeight
            titleLabel?.frame = CGRect(x: xTextPosition, y: yTextPosition, width: width, height: textHeight)
            
            self.setNeedsUpdateConstraints()
        }
    }
    
    internal func addHighlight(options:ViewPagerOptions, index: Int) {
        
        self.backgroundColor = options.tabViewBackgroundHighlightColor
        self.titleLabel?.textColor = options.tabViewTextHighlightColor
        switch index {
        case 0:
            self.imageView?.image = UIImage.init(named: options.tabImageName1Active)
            break
        case 1:
            self.imageView?.image = UIImage.init(named: options.tabImageName2Active)
            break
        case 2:
            self.imageView?.image = UIImage.init(named: options.tabImageName3Active)
            break
        default:
            break
        }
    }
    
    internal func removeHighlight(options:ViewPagerOptions, index: Int) {
        
        self.backgroundColor = options.tabViewBackgroundDefaultColor
        self.titleLabel?.textColor = options.tabViewTextDefaultColor
        switch index {
        case 0:
            self.imageView?.image = UIImage.init(named: options.tabImageName1)
            break
        case 1:
            self.imageView?.image = UIImage.init(named: options.tabImageName2)
            break
        case 2:
            self.imageView?.image = UIImage.init(named: options.tabImageName3)
            break
        default:
            break
        }
        
    }
}
