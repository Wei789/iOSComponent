//
//  PageItemViewController.swift
//  TYSliderView
//
//  Created by Weichen Cheng_鄭惟臣 on 2018/7/13.
//  Copyright © 2018年 Weichen Cheng_鄭惟臣. All rights reserved.
//

import UIKit

class PageItemViewController: UIViewController {

    @IBOutlet weak var bannerImageView: UIImageView!
    
    var color: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(backgroundColor: color)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.clickSlideImage))
        bannerImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func clickSlideImage() {
        // TODO: AB
    }
    
    func updateUI(backgroundColor: UIColor) {
        bannerImageView.backgroundColor = backgroundColor
    }
}
