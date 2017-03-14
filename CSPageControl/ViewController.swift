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
        pageControl.activeStyle = CSPageControlStyle.filled
        pageControl.inactiveStyle = CSPageControlStyle.outline
        self.view.addSubview(pageControl)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.didSwipe(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.didSwipe(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
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
    func didSwipe(_ sender: UIGestureRecognizer) {
        guard sender.isMember(of: UISwipeGestureRecognizer.self) else {
            return
        }
        switch ((sender as! UISwipeGestureRecognizer).direction) {
        case (UISwipeGestureRecognizerDirection.left):
            pageControl.incrementPage()
            break
        case (UISwipeGestureRecognizerDirection.right):
            pageControl.decrementPage()
            break
        default:
            break
        }
        pageControl.updateCurrentPageDisplay()
    }
    
    //MARK: IBActions

    @IBAction func didTapActiveStyle(_ sender: AnyObject) {
        switch activeStylePicker.selectedSegmentIndex {
        case 0:
            pageControl.activeStyle = CSPageControlStyle.filled
            break
        case 1:
            pageControl.activeStyle = CSPageControlStyle.outline
            break
        case 2:
            pageControl.activeStyle = CSPageControlStyle.image
            break
        default:
            break
        }
        pageControl.setNeedsDisplay()
    }
    
    @IBAction func didTapInactiveStyle(_ sender: AnyObject) {
        switch inactiveStylePicker.selectedSegmentIndex {
        case 0:
            pageControl.inactiveStyle = CSPageControlStyle.filled
            break
        case 1:
            pageControl.inactiveStyle = CSPageControlStyle.outline
            break
        case 2:
            pageControl.inactiveStyle = CSPageControlStyle.image
            break
        default:
            break
        }
        pageControl.setNeedsDisplay()
    }
    
    @IBAction func strokeWIdthChanged(_ sender: AnyObject) {
        pageControl.lineWidth = CGFloat(strokeWidthSlider.value)
        pageControl.setNeedsDisplay()
    }
    
    @IBAction func dotSizeChanged(_ sender: AnyObject) {
        pageControl.dotSize = CGFloat(dotSizeSlider.value)
        pageControl.setNeedsDisplay()
    }
    
    @IBAction func dotSpacingChanged(_ sender: AnyObject) {
        pageControl.dotSpacing = CGFloat(dotSpacingSlider.value)
        pageControl.setNeedsDisplay()
    }
    @IBAction func touchToggleChanged(_ sender: AnyObject) {
        pageControl.isUserInteractionEnabled = touchToggle.isOn
    }
}

