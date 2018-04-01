//
//  ViewController.swift
//  RatingBar
//
//  Created by 鄭惟臣 on 2017/10/1.
//  Copyright © 2017年 CowCow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingLabel.text = String(ratingControl.rating)
        ratingControl.didRatingValueChage = { [weak self] (value: Double) in
            self?.ratingLabel.text = String(value)
        }
    }
}

