//
//  ViewController.swift
//  PolygonalViewDemo
//
//  Created by Alexandre Brispot on 18/12/14.
//  Copyright (c) 2014 KiwiMobile. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var view_image: PolygonalView!
    @IBOutlet weak var slider_cornerRadius: UISlider!
    @IBOutlet weak var slider_sides: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func slideValueChanged(sender: AnyObject) {
        view_image.cornerRadius = CGFloat(slider_cornerRadius.value)
    }
    
    @IBAction func numberOfSidesChanged(sender: AnyObject) {
        view_image.sideNumber = Int(slider_sides.value)
    }
}

