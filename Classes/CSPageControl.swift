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

class CSPageControl: UIControl {
    
    //MARK: Page Control Properties
    var numberOfPages : NSInteger
    var currentPage : NSInteger
    var hidesForSinglePage : Bool
    var defersCurrentPageDisplay : Bool
    
    //MARK: CSPageControl Properties
    var activeStyle : CSPageControlStyle
    var inactiveStyle : CSPageControlStyle
    var activeColor : UIColor
    var inactiveColor : UIColor
    var activeImage : UIImage
    var inactiveImage : UIImage
    var dotSpacing : CGFloat
    var dotSize : CGFloat
    
    //MARK: Lifecycle
    
    
    //MARK: Utilities
    func updateCurrentPageDisplay() {
        // if defersCurrentPageDisplay is set to true, need to redraw
        if (defersCurrentPageDisplay) {
            self.setNeedsDisplay()
        }
    }
    
    func sizeForNumberOfPages(numPages: NSInteger) -> CGSize {
        var floatPages :CGFloat = CGFloat(numPages)
        var width : CGFloat = (floatPages * dotSize) + (floatPages - 1) * (dotSpacing + 44)
        var height : CGFloat = max(44, dotSize + 4)
        return CGSize(width: width, height: height)
    }

}
