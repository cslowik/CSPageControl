//
//  CSPageControl.swift
//  CSPageControl
//
//  Created by Chris Slowik on 6/8/15.
//  Copyright (c) 2015 Chris Slowik. All rights reserved.
//

import UIKit

enum CSPageControlStyle: Int {
    case filled     = 0
    case outline    = 1
    case image      = 2
}

enum CSPageControlImage: String {
    case StarFilled     = "starFilled"
    case StarOutline    = "starOutline"
}

enum CSPageControlAnimation: Int {
    case none       = 0
    case slide      = 1
    case drain      = 2
    case fade       = 3
}

class CSPageControl: UIControl {
    
    //MARK: Page Control Properties
    var numberOfPages                       = 1 {
        didSet {
            let newSize = self.sizeForNumberOfPages()
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
    var activeStyle: CSPageControlStyle     = CSPageControlStyle.filled
    var inactiveStyle: CSPageControlStyle   = CSPageControlStyle.outline
    var activeColor: UIColor                = UIColor(red:0.290,  green:0.639,  blue:0.875, alpha:1)
    var inactiveColor: UIColor              = UIColor(red:0.796,  green:0.816,  blue:0.827, alpha:1)
    var activeImage: UIImage?
    var inactiveImage: UIImage?
    var animationStyle: CSPageControlAnimation = CSPageControlAnimation.none
    
    //MARK: Lifecycle
    convenience init(activeStyle: CSPageControlStyle, inactiveStyle: CSPageControlStyle) {
        self.init(frame: CGRect.zero)
        self.activeStyle = activeStyle
        self.inactiveStyle = inactiveStyle
    }
    
    convenience init(activeStyle: CSPageControlStyle, inactiveStyle: CSPageControlStyle, dotSize: CGFloat, dotSpacing: CGFloat) {
        self.init(frame: CGRect.zero)
        self.activeStyle = activeStyle
        self.inactiveStyle = inactiveStyle
        self.dotSize = dotSize
        self.dotSpacing = dotSpacing
    }
    
    convenience init(activeImage: UIImage, inactiveImage: UIImage) {
        self.init(frame: CGRect.zero)
        self.activeImage = activeImage
        self.inactiveImage = inactiveImage
        
        self.activeStyle = CSPageControlStyle.image
        self.inactiveStyle = CSPageControlStyle.image
        
        let activeSize : CGFloat = max(activeImage.size.width, activeImage.size.height)
        let inactiveSize : CGFloat = max(inactiveImage.size.width, inactiveImage.size.height)
        self.dotSize = max(activeSize, inactiveSize)
    }
    
    convenience init(activeImage: UIImage, inactiveImage: UIImage, dotSpacing: CGFloat) {
        self.init(frame: CGRect.zero)
        self.activeImage = activeImage
        self.inactiveImage = inactiveImage
        self.activeStyle = CSPageControlStyle.image
        self.inactiveStyle = CSPageControlStyle.image
        
        let activeSize = max(activeImage.size.width, activeImage.size.height)
        let inactiveSize = max(inactiveImage.size.width, inactiveImage.size.height)
        
        self.dotSpacing = dotSpacing
        self.dotSize = max(activeSize, inactiveSize)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    //MARK: Drawing
    override func draw(_ rect: CGRect) {
        let currentBounds = self.bounds
        let totalWidth = CGFloat(numberOfPages) * dotSize + CGFloat(max(0, numberOfPages - 1)) * dotSpacing
        var x = currentBounds.midX - (totalWidth / 2)
        let y = currentBounds.midY - (dotSize / 2)

        
        for page in 0 ..< numberOfPages {
            let dotFrame = CGRect(x: x, y: y, width: dotSize, height: dotSize)
            if (page == currentPage) {
                switch activeStyle {
                case .filled:
                    // Draw filled circle
                    let circlePath = UIBezierPath(ovalIn: dotFrame.insetBy(dx: -0.5, dy: -0.5))
                    activeColor.setFill()
                    circlePath.fill()
                    break
                    
                case .outline:
                    // Draw stroked circle
                    let circlePath = UIBezierPath(ovalIn: dotFrame.insetBy(dx: (lineWidth / 2), dy: (lineWidth / 2)))
                    activeColor.setStroke()
                    circlePath.lineWidth = lineWidth
                    circlePath.stroke()
                    break
                    
                case .image:
                    activeImage!.draw(in: dotFrame)
                }
            } else {
                switch inactiveStyle {
                case .filled:
                    // Draw filled circle
                    let circlePath = UIBezierPath(ovalIn: dotFrame.insetBy(dx: -0.5, dy: -0.5))
                    inactiveColor.setFill()
                    circlePath.fill()
                    break
                    
                case .outline:
                    // Draw stroked circle
                    let circlePath = UIBezierPath(ovalIn: dotFrame.insetBy(dx: (lineWidth / 2), dy: (lineWidth / 2)))
                    inactiveColor.setStroke()
                    circlePath.lineWidth = lineWidth
                    circlePath.stroke()
                    break
                    
                case .image:
                    inactiveImage!.draw(in: dotFrame)
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
    
    func updateCurrentPageDisplay(_ previousPage: NSInteger, nextPage: NSInteger) {
        if (!defersCurrentPageDisplay) {
            self.setNeedsDisplay()
        }
    }
    
    func sizeForNumberOfPages() -> CGSize {
        let floatPages = CGFloat(numberOfPages)
        let width = (floatPages * dotSize) + (floatPages - 1) * (dotSpacing + 44)
        let height = max(44, dotSize + 4)
        return CGSize(width: width, height: height)
    }
    
    //MARK: Page Changers
    func incrementPage() {
        let previousPage = currentPage
        currentPage = (currentPage < (numberOfPages - 1)) ? (currentPage + 1) : (numberOfPages - 1)
        updateCurrentPageDisplay(previousPage, nextPage: currentPage)
    }
    
    func decrementPage() {
        let previousPage = currentPage
        currentPage = (currentPage > 0) ? (currentPage - 1) : 0
        updateCurrentPageDisplay(previousPage, nextPage: currentPage)
    }

    //MARK: Touch Handling
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let theTouch = touch else {
            return
        }
        
        // find touch location
        let touchLocation = theTouch.location(in: self)
        
        // check whether the touch is on the right or left
        if (touchLocation.x < (self.bounds.size.width / 2)) {
            decrementPage()
        }
        else {
            incrementPage()
        }
        self.sendActions(for: UIControlEvents.valueChanged)
    }
    
    //MARK: Animation
    
}
