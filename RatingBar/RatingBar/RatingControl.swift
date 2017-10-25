//
//  RatingControl.swift
//  RatingBar
//
//  Created by 鄭惟臣 on 2017/10/1.
//  Copyright © 2017年 CowCow. All rights reserved.
//

import UIKit

@IBDesignable  class RatingControl: UIStackView {
    //Mark: Properties
    
    private var ratingButtons = [UIButton]()
    
    @IBInspectable var rating: Double = 0.0 {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var fillImage: UIImage?
        {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var halfImage: UIImage?
        {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var emptyImage: UIImage? {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    //Mark: Initalization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let touch = touches.first {
            updateButtonSelectionStates(point: touch.location(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let touch = touches.first {
            updateButtonSelectionStates(point: touch.location(in: self))
        }
    }
    
    public func getRating() -> Double{
        return rating
    }
    
    //Mark: Private Methods
    private func setupButtons() {
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        for i in 0..<starCount {
            let button = UIButton()
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            let ratingStar = Double(i + 1)
            if rating == ratingStar || rating > ratingStar {
                button.setBackgroundImage(fillImage, for: .normal)
            } else if rating >= ratingStar - 0.5  && rating < ratingStar  {
                button.setBackgroundImage(halfImage, for: .normal)
            } else {
                button.setBackgroundImage(emptyImage, for: .normal)
            }
            
            button.adjustsImageWhenHighlighted = false
            // important, no this line can't detect touchmove event on button
            button.isUserInteractionEnabled = false
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
    }
    
    private func updateButtonSelectionStates(point: CGPoint) {
        let halfSize = starSize.width / 2
        var ratingTemp = 0.0
        for (index, button) in ratingButtons.enumerated() {
            if button.frame.minX <= point.x && point.x <= (button.frame.maxX - halfSize) {
                ratingTemp = Double(index + 1) - 0.5
            }else if point.x >= (button.frame.maxX - halfSize) {
                ratingTemp = Double(index + 1)
            }
        }
        
        rating = ratingTemp
    }
}
