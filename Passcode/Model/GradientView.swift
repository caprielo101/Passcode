//
//  GradientView.swift
//  Passcode
//
//  Created by Josiah Elisha on 23/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit

class GradientView: UIView {

    var gradient = CAGradientLayer()
    
    var label = UILabel()
    
    var colors: [CGColor] = [UIColor.higRed.cgColor, UIColor.higOrange.cgColor, UIColor.higYellow.cgColor, UIColor.higGreen.cgColor, UIColor.higTeal.cgColor, UIColor.higBlue.cgColor, UIColor.higPurple.cgColor, UIColor.higPink.cgColor]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setup view
        setupGradient()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setup view
        setupGradient()
    }
    
    func setupGradient() {
        //creating the colors
        randomizeColor()
//        gradient.colors = colors

        // Gradient from left to right
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        // set the gradient layer to the same size as the view
        gradient.frame = self.bounds
        // add the gradient layer to the views layer for rendering
        self.layer.addSublayer(gradient)
        
        createTextLabel()
    }
    
    func randomizeColor() {
        let random1 = colors.randomElement()!
        let random2 = colors.randomElement()!
        if random1 != random2 {
            gradient.colors = [random1, random2]
        } else {
            randomizeColor()
        }
    }
    func createTextLabel() {
        // Create a label and add it as a subview
        label = UILabel(frame: self.bounds)
        label.text = "1234"
        label.font = UIFont(name: "SF Pro Display", size: 100)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        self.addSubview(label)
        
        // Tha magic! Set the label as the views mask
        self.mask = label
    }
}
