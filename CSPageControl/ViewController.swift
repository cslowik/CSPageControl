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
    }

    override func viewDidLayoutSubviews() {
        pageControl.center = CGPoint(x: self.view.center.x, y: 100)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

