//
//  ViewController.swift
//  CSPageControl
//
//  Created by Chris Slowik on 6/8/15.
//  Copyright (c) 2015 Chris Slowik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var activeStylePicker: UISegmentedControl!
    @IBOutlet weak var inactiveStylePicker: UISegmentedControl!
    @IBOutlet weak var strokeWidthSlider: UISlider!
    @IBOutlet weak var dotSizeSlider: UISlider!
    @IBOutlet weak var dotSpacingSlider: UISlider!
    @IBOutlet weak var touchToggle: UISwitch!
    @IBOutlet weak var gestureReceiver: UIView!
    
    var pageControl : CSPageControl = CSPageControl(activeImage: UIImage(named: "starFilled")!, inactiveImage: UIImage(named: "starOutline")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = 5
        pageControl.dotSize = 12
        pageControl.activeStyle = CSPageControlStyle.Filled
        pageControl.inactiveStyle = CSPageControlStyle.Outline
        self.view.addSubview(pageControl)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "didSwipe:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "didSwipe:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.gestureReceiver.addGestureRecognizer(swipeLeft)
        self.gestureReceiver.addGestureRecognizer(swipeRight)
    }

    override func viewDidLayoutSubviews() {
        pageControl.center = CGPoint(x: self.view.center.x, y: 100)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Gesture Recognition
    func didSwipe(sender: UIGestureRecognizer) {
        if (sender.isMemberOfClass(UISwipeGestureRecognizer)) {
            switch ((sender as! UISwipeGestureRecognizer).direction) {
            case (UISwipeGestureRecognizerDirection.Left):
                pageControl.incrementPage()
                break
            case (UISwipeGestureRecognizerDirection.Right):
                pageControl.decrementPage()
                break
            default:
                break
            }
            pageControl.updateCurrentPageDisplay()
        }
    }
    
    //MARK: IBActions

    @IBAction func didTapActiveStyle(sender: AnyObject) {
        switch activeStylePicker.selectedSegmentIndex {
        case 0:
            pageControl.activeStyle = CSPageControlStyle.Filled
            break
        case 1:
            pageControl.activeStyle = CSPageControlStyle.Outline
            break
        case 2:
            pageControl.activeStyle = CSPageControlStyle.Image
            break
        default:
            break
        }
        pageControl.setNeedsDisplay()
    }
    
    @IBAction func didTapInactiveStyle(sender: AnyObject) {
        switch inactiveStylePicker.selectedSegmentIndex {
        case 0:
            pageControl.inactiveStyle = CSPageControlStyle.Filled
            break
        case 1:
            pageControl.inactiveStyle = CSPageControlStyle.Outline
            break
        case 2:
            pageControl.inactiveStyle = CSPageControlStyle.Image
            break
        default:
            break
        }
        pageControl.setNeedsDisplay()
    }
    
    @IBAction func strokeWIdthChanged(sender: AnyObject) {
        pageControl.lineWidth = CGFloat(strokeWidthSlider.value)
        pageControl.setNeedsDisplay()
    }
    
    @IBAction func dotSizeChanged(sender: AnyObject) {
        pageControl.dotSize = CGFloat(dotSizeSlider.value)
        pageControl.setNeedsDisplay()
    }
    
    @IBAction func dotSpacingChanged(sender: AnyObject) {
        pageControl.dotSpacing = CGFloat(dotSpacingSlider.value)
        pageControl.setNeedsDisplay()
    }
    @IBAction func touchToggleChanged(sender: AnyObject) {
        pageControl.userInteractionEnabled = touchToggle.on
    }
}

