//
//  ViewPagerController.swift
//  hune
//
//  Created by Apple on 9/10/19.
//  Copyright © 2019 Tien. All rights reserved.
//

import UIKit
import Foundation

public class ViewPagerOptions {
    
    public var viewPagerFrame:CGRect = CGRect.zero
    
    // Tabs Customization
    public var tabType:ViewPagerTabType = .basic
    public var isTabHighlightAvailable:Bool = false
    public var isTabIndicatorAvailable:Bool = true
    
    public var tabViewBackgroundDefaultColor:UIColor? = Color.tabViewBackground
    
    public var tabViewBackgroundHighlightColor:UIColor = Color.tabViewHighlight
    public var tabViewTextDefaultColor:UIColor = Color.textDefault
    public var tabViewTextHighlightColor:UIColor = Color.textHighlight
    public var tabImageName1:String = ""
    public var tabImageName1Active: String = ""
    public var tabImageName2:String = ""
    public var tabImageName2Active: String = ""
    public var tabImageName3:String = ""
    public var tabImageName3Active: String = ""
    
    // Booleans
    
    /// Width of each tab is equal to the width of the largest tab. Tabs are laid out from Left - Right and are scrollable
    public var isEachTabEvenlyDistributed:Bool = false
    /// All the tabs are squeezed to fit inside the screen width. Tabs are not scrollable. Also it overrides isEachTabEvenlyDistributed
    public var fitAllTabsInView:Bool = false
    
    // Tab Properties
    public var tabViewHeight:CGFloat = 50.0
    public var tabViewPaddingLeft:CGFloat = 10.0
    public var tabViewPaddingRight:CGFloat = 10.0
    public var tabViewTextFont:UIFont = UIFont.systemFont(ofSize: 16)
    public var tabViewImageSize:CGSize = CGSize(width: 18, height: 18)
    public var tabViewImageMarginTop:CGFloat = 5
    public var tabViewImageMarginBottom:CGFloat = 5
    
    // Tab Indicator
    public var tabIndicatorViewHeight:CGFloat = 3
    public var tabIndicatorViewBackgroundColor:UIColor = Color.tabIndicator
    
    // ViewPager
    public var viewPagerTransitionStyle:UIPageViewController.TransitionStyle = .scroll
    
    
    public init(viewPagerWithFrame frame:CGRect) {
        self.viewPagerFrame = frame
    }
    
    fileprivate struct Color {

        static let tabViewBackground = UIColor.from(r: 246.0, g: 246.0, b: 248.0)
        static let tabViewHighlight = UIColor.from(r: 246.0, g: 246.0, b: 248.0)
        static let textDefault = UIColor.from(r: 119.0, g: 119.0, b: 119.0)
        static let textHighlight = UIColor.from(r: 0, g: 52.0, b: 112.0)
        static let tabIndicator = UIColor.from(r: 0, g: 52.0, b: 112.0)
    }
}

fileprivate extension UIColor {
    
    class func from(r: CGFloat,g:CGFloat,b:CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}
