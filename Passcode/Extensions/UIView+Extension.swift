//
//  UIView+Extension.swift
//  Passcode
//
//  Created by Josiah Elisha on 19/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit

extension UIView {
    
    func setCornerRadius(_ amount:CGFloat) {
        self.layer.cornerRadius = amount
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
    
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect.init(x: 0, y: self.frame.size.height - 2, width: self.frame.size.width, height: 2)
        bottomLine.backgroundColor = UIColor.white.cgColor
        self.layer.addSublayer(bottomLine)
    }
    
    func flashAnimate()  {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 1
        flash.fromValue = 1
        flash.toValue = 0.2
        flash.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        flash.autoreverses = false
        flash.repeatCount = Float.infinity
        layer.add(flash, forKey: nil)
    }
    
    func shakeAnimate(howMuchX xValue: CGFloat,howMuchY yValue:CGFloat, howManyRepeats repeatCount: Float) {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.09
        shake.repeatCount = repeatCount
        let fromPoint = CGPoint(x: center.x + xValue, y: center.y + yValue)
        let toPoint = CGPoint(x: center.x - xValue, y: center.y - yValue)
        
        let fromValue = NSValue(cgPoint: fromPoint)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        shake.autoreverses = true
        layer.add(shake, forKey: nil)
    }
}

