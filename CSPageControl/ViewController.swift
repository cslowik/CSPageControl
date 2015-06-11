//
//  ViewController.swift
//  CSPageControl
//
//  Created by Chris Slowik on 6/8/15.
//  Copyright (c) 2015 Chris Slowik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pageIndicator : CSPageControl = CSPageControl(activeStyle: CSPageControlStyle.Filled, inactiveStyle: CSPageControlStyle.Outline)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pageIndicator.numberOfPages = 4
        self.view.addSubview(pageIndicator)
    }
    
    override func viewDidLayoutSubviews() {
        pageIndicator.center = self.view.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

