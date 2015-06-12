//
//  CSPageControl.swift
//  CSPageControl
//
//  Created by Chris Slowik on 6/8/15.
//  Copyright (c) 2015 Chris Slowik. All rights reserved.
//

import UIKit

enum CSPageControlStyle: Int {
    case Filled     = 0
    case Outline    = 1
    case Image      = 2
}

enum CSPageControlImage: String {
    case StarFilled     = "starFilled"
    case StarOutline    = "starOutline"
}

enum CSPageControlAnimation: Int {
    case None       = 0
    case Slide      = 1
    case Drain      = 2
    case Fade       = 3
}

class CSPageControl: UIControl {
    
    //MARK: Page Control Properties
    var numberOfPages                       = 1 {
        didSet {
            var newSize = self.sizeForNumberOfPages()
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: newSize.width, height: newSize.height)
            self.updateCurrentPageDisplay()
        }
    }
    var currentPage                         = 0
    var previousPage                        = 0
    var hidesForSinglePage                  = false
    var defersCurrentPageDisplay            = false
    
    //MARK: CSPageControl Properties
    var dotSpacing: CGFloat                 = 14.0
    var dotSize: CGFloat                    = 6.0
    var lineWidth: CGFloat                  = 1.0
    var activeStyle: CSPageControlStyle     = CSPageControlStyle.Filled
    var inactiveStyle: CSPageControlStyle   = CSPageControlStyle.Outline
    var activeColor: UIColor                = UIColor(red:0.290,  green:0.639,  blue:0.875, alpha:1)
    var inactiveColor: UIColor              = UIColor(red:0.796,  green:0.816,  blue:0.827, alpha:1)
    var activeImage: UIImage?
    var inactiveImage: UIImage?
    var animationStyle: CSPageControlAnimation = CSPageControlAnimation.None
    
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
        
        var activeSize = max(activeImage.size.width, activeImage.size.height)
        var inactiveSize = max(inactiveImage.size.width, inactiveImage.size.height)
        
        self.dotSpacing = dotSpacing
        self.dotSize = max(activeSize, inactiveSize)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    //MARK: Drawing
    override func drawRect(rect: CGRect) {
        var currentBounds = self.bounds
        var totalWidth = CGFloat(numberOfPages) * dotSize + CGFloat(max(0, numberOfPages - 1)) * dotSpacing
        var x = CGRectGetMidX(currentBounds) - (totalWidth / 2)
        var y = CGRectGetMidY(currentBounds) - (dotSize / 2)
        
        for (var i = 0; i < numberOfPages; i++) {
            var dotFrame = CGRectMake(x, y, dotSize, dotSize)
            if (i == currentPage) {
                switch activeStyle {
                case .Filled:
                    // Draw filled circle
                    var circlePath = UIBezierPath(ovalInRect: CGRectInset(dotFrame, -0.5, -0.5))
                    activeColor.setFill()
                    circlePath.fill()
                    break
                    
                case .Outline:
                    // Draw stroked circle
                    var circlePath = UIBezierPath(ovalInRect: CGRectInset(dotFrame, (lineWidth / 2), (lineWidth / 2)))
                    activeColor.setStroke()
                    circlePath.lineWidth = lineWidth
                    circlePath.stroke()
                    break
                    
                case .Image:
                    activeImage!.drawInRect(dotFrame)
                }
            } else {
                switch inactiveStyle {
                case .Filled:
                    // Draw filled circle
                    var circlePath = UIBezierPath(ovalInRect: CGRectInset(dotFrame, -0.5, -0.5))
                    inactiveColor.setFill()
                    circlePath.fill()
                    break
                    
                case .Outline:
                    // Draw stroked circle
                    var circlePath = UIBezierPath(ovalInRect: CGRectInset(dotFrame, (lineWidth / 2), (lineWidth / 2)))
                    inactiveColor.setStroke()
                    circlePath.lineWidth = lineWidth
                    circlePath.stroke()
                    break
                    
                case .Image:
                    inactiveImage!.drawInRect(dotFrame)
                    break
                }
            }
            x += dotSize + dotSpacing
        }
    }
    
    //MARK: Utilities
    func updateCurrentPageDisplay() {
        if (!defersCurrentPageDisplay) {
            self.setNeedsDisplay()
        }
    }
    
    func updateCurrentPageDisplay(previousPage: NSInteger, nextPage: NSInteger) {
        if (!defersCurrentPageDisplay) {
            self.setNeedsDisplay()
        }
    }
    
    func sizeForNumberOfPages() -> CGSize {
        var floatPages = CGFloat(numberOfPages)
        var width = (floatPages * dotSize) + (floatPages - 1) * (dotSpacing + 44)
        var height = max(44, dotSize + 4)
        return CGSize(width: width, height: height)
    }
    
    //MARK: Page Changers
    func incrementPage() {
        var previousPage = currentPage
        currentPage = (currentPage < (numberOfPages - 1)) ? (currentPage + 1) : (numberOfPages - 1)
        updateCurrentPageDisplay(previousPage, nextPage: currentPage)
    }
    
    func decrementPage() {
        var previousPage = currentPage
        currentPage = (currentPage > 0) ? (currentPage - 1) : 0
        updateCurrentPageDisplay(previousPage, nextPage: currentPage)
    }

    //MARK: Touch Handling
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        // find touch location
        var theTouch = touches.first as! UITouch
        var touchLocation = theTouch.locationInView(self)
        
        // check whether the touch is on the right or left
        if (touchLocation.x < (self.bounds.size.width / 2)) {
            decrementPage()
        }
        else {
            incrementPage()
        }
        self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
    }
    
    //MARK: Animation
    
}
