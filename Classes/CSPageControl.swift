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
    var numberOfPages : NSInteger           = 1 {
        didSet {
            var newSize : CGSize = self.sizeForNumberOfPages()
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: newSize.width, height: newSize.height)
            self.updateCurrentPageDisplay()
        }
    }
    var currentPage : NSInteger             = 0
    var hidesForSinglePage : Bool           = false
    var defersCurrentPageDisplay : Bool     = false
    
    //MARK: CSPageControl Properties
    var dotSpacing : CGFloat                = 14.0
    var dotSize : CGFloat                   = 6.0
    var lineWidth : CGFloat                 = 1.0
    var activeStyle : CSPageControlStyle    = CSPageControlStyle.Filled
    var inactiveStyle : CSPageControlStyle  = CSPageControlStyle.Outline
    var activeColor : UIColor               = UIColor(red:0.290,  green:0.639,  blue:0.875, alpha:1)
    var inactiveColor : UIColor             = UIColor(red:0.796,  green:0.816,  blue:0.827, alpha:1)
    var activeImage : UIImage?
    var inactiveImage : UIImage?
    
    //MARK: Lifecycle
    convenience init(activeStyle: CSPageControlStyle, inactiveStyle: CSPageControlStyle) {
        self.init(frame: CGRect.zeroRect)
        self.activeStyle = activeStyle
        self.inactiveStyle = inactiveStyle
    }
    
    convenience init(activeStyle: CSPageControlStyle, inactiveStyle: CSPageControlStyle, dotSize: CGFloat, dotSpacing: CGFloat) {
        self.init(frame: CGRect.zeroRect)
        self.activeStyle = activeStyle
        self.inactiveStyle = inactiveStyle
        self.dotSize = dotSize
        self.dotSpacing = dotSpacing
    }
    
    convenience init(activeImage: UIImage, inactiveImage: UIImage) {
        self.init(frame: CGRect.zeroRect)
        self.activeImage = activeImage
        self.inactiveImage = inactiveImage
        
        self.activeStyle = CSPageControlStyle.Image
        self.inactiveStyle = CSPageControlStyle.Image
        
        var activeSize : CGFloat = max(activeImage.size.width, activeImage.size.height)
        var inactiveSize : CGFloat = max(inactiveImage.size.width, inactiveImage.size.height)
        self.dotSize = max(activeSize, inactiveSize)
    }
    
    convenience init(activeImage: UIImage, inactiveImage: UIImage, dotSpacing: CGFloat) {
        self.init(frame: CGRect.zeroRect)
        self.activeImage = activeImage
        self.inactiveImage = inactiveImage
        self.activeStyle = CSPageControlStyle.Image
        self.inactiveStyle = CSPageControlStyle.Image
        
        var activeSize : CGFloat = max(activeImage.size.width, activeImage.size.height)
        var inactiveSize : CGFloat = max(inactiveImage.size.width, inactiveImage.size.height)
        
        self.dotSpacing = dotSpacing
        self.dotSize = max(activeSize, inactiveSize)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    //MARK: Drawing
    override func drawRect(rect: CGRect) {
        var context : CGContextRef = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        CGContextSetAllowsAntialiasing(context, true)
        
        var currentBounds : CGRect = self.bounds
        var totalWidth : CGFloat = CGFloat(numberOfPages) * dotSize + CGFloat(max(0, numberOfPages - 1)) * dotSpacing
        var x : CGFloat = CGRectGetMidX(currentBounds) - (totalWidth / 2)
        var y : CGFloat = CGRectGetMidY(currentBounds) - (dotSize / 2)
        
        for (var i = 0; i < numberOfPages; i++) {
            var dotFrame : CGRect = CGRectMake(x, y, dotSize, dotSize)
            if (i == currentPage) {
                switch activeStyle {
                case .Filled:
                    CGContextSetFillColorWithColor(context, activeColor.CGColor)
                    CGContextFillEllipseInRect(context, CGRectInset(dotFrame, -0.5, -0.5))
                    break
                    
                case .Outline:
                    CGContextSetLineWidth(context, lineWidth)
                    CGContextSetStrokeColorWithColor(context, activeColor.CGColor)
                    CGContextStrokeEllipseInRect(context, CGRectInset(dotFrame, (lineWidth / 2), (lineWidth / 2)))
                    break
                    
                case .Image:
                    activeImage!.drawInRect(dotFrame)
                }
            } else {
                switch inactiveStyle {
                case .Filled:
                    CGContextSetFillColorWithColor(context, inactiveColor.CGColor)
                    CGContextFillEllipseInRect(context, CGRectInset(dotFrame, -0.5, -0.5))
                    break
                    
                case .Outline:
                    CGContextSetLineWidth(context, lineWidth)
                    CGContextSetStrokeColorWithColor(context, inactiveColor.CGColor)
                    CGContextStrokeEllipseInRect(context, CGRectInset(dotFrame, (lineWidth / 2), (lineWidth / 2)))
                    break
                    
                case .Image:
                    inactiveImage!.drawInRect(dotFrame)
                    break
                }
            }
            x += dotSize + dotSpacing
        }
        
        
        // restore the context
        CGContextRestoreGState(context)
    }
    
    //MARK: Utilities
    func updateCurrentPageDisplay() {
        if (!defersCurrentPageDisplay) {
            self.setNeedsDisplay()
        }
    }
    
    func sizeForNumberOfPages() -> CGSize {
        var floatPages : CGFloat = CGFloat(numberOfPages)
        var width : CGFloat = (floatPages * dotSize) + (floatPages - 1) * (dotSpacing + 44)
        var height : CGFloat = max(44, dotSize + 4)
        return CGSize(width: width, height: height)
    }
    
    //MARK: Page Changers
    func incrementPage() {
        currentPage = (currentPage < (numberOfPages - 1)) ? (currentPage + 1) : (numberOfPages - 1)
        updateCurrentPageDisplay()
    }
    
    func decrementPage() {
        currentPage = (currentPage > 0) ? (currentPage - 1) : 0
        updateCurrentPageDisplay()
    }

    //MARK: Touch Handling
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        // find touch location
        var theTouch : UITouch = touches.first as! UITouch
        var touchLocation : CGPoint = theTouch.locationInView(self)
        
        // check whether the touch is on the right or left
        if (touchLocation.x < (self.bounds.size.width / 2)) {
            currentPage = (currentPage > 0) ? currentPage-- : numberOfPages
        }
        else {
            currentPage = (currentPage < (numberOfPages - 1)) ? currentPage++ : 0
        }
        self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
    }
    
}
