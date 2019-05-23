//
//  UIColor+Extension.swift
//  Passcode
//
//  Created by Josiah Elisha on 17/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    static let higRed = UIColor.init(r: 255, g: 59, b: 48)
    static let higOrange = UIColor.init(r: 255, g: 149, b: 0)
    static let higYellow = UIColor.init(r: 255, g: 204, b: 0)
    static let higGreen = UIColor.init(r: 76, g: 217, b: 100)
    static let higTeal = UIColor.init(r: 90, g: 200, b: 250)
    static let higBlue = UIColor.init(r: 0, g: 122, b: 255)
    static let higPurple = UIColor.init(r: 88, g: 86, b: 214)
    static let higPink = UIColor.init(r: 255, g: 45, b: 85)
}
