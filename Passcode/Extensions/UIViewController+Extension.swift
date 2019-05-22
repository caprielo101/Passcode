//
//  UIViewController+Extension.swift
//  Passcode
//
//  Created by Josiah Elisha on 22/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func distanceBetween(p1: CGPoint, p2: CGPoint) -> CGFloat {
        return sqrt(pow(p2.x-p1.x,2)+pow(p2.y-p1.y,2))
        
    }
}
