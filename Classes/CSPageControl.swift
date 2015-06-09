//
//  CSPageControl.swift
//  CSPageControl
//
//  Created by Chris Slowik on 6/8/15.
//  Copyright (c) 2015 Chris Slowik. All rights reserved.
//

import UIKit

enum CSPageControlStyle : Int {
    case Filled     = 0
    case Outline    = 1
    case Image      = 2
}

enum CSPageControlImage : String {
    case StarFilled     = "starFilled"
    case StarOutline    = "starOutline"
}

class CSPageControl: UIControl {
    
    //MARK: Page Control Properties
    var numberOfPages : NSInteger           = 1
    var currentPage : NSInteger             = 0
    var hidesForSinglePage : Bool           = false
    var defersCurrentPageDisplay : Bool     = false
    
    //MARK: CSPageControl Properties
    var dotSpacing : CGFloat                = 14.0
    var dotSize : CGFloat                   = 6.0
    var activeStyle : CSPageControlStyle    = CSPageControlStyle.Filled
    var inactiveStyle : CSPageControlStyle  = CSPageControlStyle.Filled
    var activeColor : UIColor               = UIColor(red:0.290,  green:0.639,  blue:0.875, alpha:1)
    var inactiveColor : UIColor             = UIColor(red:0.796,  green:0.816,  blue:0.827, alpha:1)
    var activeImage : UIImage?
    var inactiveImage : UIImage?
    
    //MARK: Lifecycle
    init(activeStyle: CSPageControlStyle, inactiveStyle: CSPageControlStyle) {
        self.activeStyle = activeStyle
        self.inactiveStyle = inactiveStyle
        
        super.init(frame: CGRect.zeroRect)
    }
    
    init(activeStyle: CSPageControlStyle, inactiveStyle: CSPageControlStyle, dotSize: CGFloat, dotSpacing: CGFloat) {
        self.activeStyle = activeStyle
        self.inactiveStyle = inactiveStyle
        self.dotSize = dotSize
        self.dotSpacing = dotSpacing
        
        super.init(frame: CGRect.zeroRect)
    }
    
    init(activeImage: UIImage, inactiveImage: UIImage) {
        self.activeImage = activeImage
        self.inactiveImage = inactiveImage
        
        super.init(frame: CGRect.zeroRect)
    }
    
    init(activeImage: UIImage, inactiveImage: UIImage, dotSpacing: CGFloat) {
        self.activeImage = activeImage
        self.inactiveImage = inactiveImage
        self.dotSpacing = dotSpacing
        
        super.init(frame: CGRect.zeroRect)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Utilities
    func updateCurrentPageDisplay() {
        // if defersCurrentPageDisplay is set to true, need to redraw
        if (defersCurrentPageDisplay) {
            self.setNeedsDisplay()
        }
    }
    
    func sizeForNumberOfPages() -> CGSize {
        var floatPages :CGFloat = CGFloat(numberOfPages)
        var width : CGFloat = (floatPages * dotSize) + (floatPages - 1) * (dotSpacing + 44)
        var height : CGFloat = max(44, dotSize + 4)
        return CGSize(width: width, height: height)
    }

}
