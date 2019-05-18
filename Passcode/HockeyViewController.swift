//
//  HockeyViewController.swift
//  Passcode
//
//  Created by Josiah Elisha on 18/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit

class HockeyViewController: UIViewController {

    let initialVector = CGVector.zero
    var currentVector = CGVector.zero
    var time: Double = 0
    var circle: UIView!
    
    var circleOrigin: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black

        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        
        circle = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        circle.center = view.center
        circleOrigin = circle.frame.origin
        
        circle.layer.cornerRadius = circle.frame.height / 2
        circle.backgroundColor = .white
        view.addGestureRecognizer(pan)
        view.addSubview(circle)
    }
    
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let theView = sender.view!
        let translation = sender.translation(in: theView)
        
        switch sender.state {
        case .began, .changed:
            circle.center = CGPoint(x: circle.center.x + translation.x, y: circle.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: theView)
        case .ended:
            sender.setTranslation(translation, in: theView)
            circle.center = CGPoint(x: circle.center.x + translation.x, y: circle.center.y + translation.y)
        default:
            break
        }
    }
}
