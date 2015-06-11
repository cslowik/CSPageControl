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
    
    var pageControl : CSPageControl = CSPageControl(activeImage: UIImage(named: "starFilled")!, inactiveImage: UIImage(named: "starOutline")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = 5
        pageControl.dotSize = 12
        pageControl.activeStyle = CSPageControlStyle.Filled
        pageControl.inactiveStyle = CSPageControlStyle.Outline
        self.view.addSubview(pageControl)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "didSwipeLeft")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
    }

    override func viewDidLayoutSubviews() {
        pageControl.center = CGPoint(x: self.view.center.x, y: 100)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Gesture Recognition
    func didSwipeLeft() {
        println("swiped left")
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
}

