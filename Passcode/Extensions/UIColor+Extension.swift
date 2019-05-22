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
}
