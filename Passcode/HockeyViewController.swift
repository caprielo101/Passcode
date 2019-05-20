//
//  HockeyViewController.swift
//  Passcode
//
//  Created by Josiah Elisha on 18/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit

class HockeyViewController: UIViewController {

    var circle: UIView!
    var animator: UIDynamicAnimator!
    var collision: UICollisionBehavior!
    var gravity: UIGravityBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        
        circle = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        circle.center = view.center
        
        circle.layer.cornerRadius = circle.frame.height / 2
        circle.backgroundColor = .white
        circle.addGestureRecognizer(pan)
        animator = UIDynamicAnimator(referenceView: view)

        view.addSubview(circle)
//
//        gravity = UIGravityBehavior(items: [circle])
//        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [circle, view])
        collision.translatesReferenceBoundsIntoBoundary = true

        collision.addBoundary(withIdentifier: "frame" as NSCopying, for: UIBezierPath(rect: view.frame))
        collision.addBoundary(withIdentifier: "topBounds" as NSCopying, from: CGPoint(x: 0, y: 0), to: CGPoint(x: view.bounds.size.width, y: 0))
        collision.addBoundary(withIdentifier: "leftBounds" as NSCopying, from: CGPoint(x: 0, y: 0), to: CGPoint(x: 0, y: view.bounds.size.height))
        collision.addBoundary(withIdentifier: "rightBounds" as NSCopying, from: CGPoint(x: view.bounds.size.width, y: 0), to: CGPoint(x: view.bounds.size.width, y: view.bounds.size.height))
        collision.addBoundary(withIdentifier: "bottomBounds" as NSCopying, from: CGPoint(x: 0, y: view.bounds.size.height), to: CGPoint(x: view.bounds.size.width, y: view.bounds.size.height))
        collision.collisionMode = .boundaries
        animator.addBehavior(collision)
    }
    
    func checkBounds(_ myView: UIView) {
        if myView.center.x > view.frame.width {
            debugPrint("You gay")
        } else if myView.center.x < 0 {
            debugPrint("You left")
        } else if myView.center.y > view.frame.height {
            debugPrint("You down")
        } else if myView.center.y < 0 {
            debugPrint("You up")
        }
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let theView = sender.view!

        switch sender.state {
            
        case .began:
            animator.removeAllBehaviors()
            
        case .changed:
            let translation = sender.translation(in: theView)
            theView.center.x += translation.x
            theView.center.y += translation.y
            sender.setTranslation(.zero, in: theView)
            
        case .ended:
            let velocity = sender.velocity(in: theView)
            let behavior = UIDynamicItemBehavior(items: [theView])
            behavior.addLinearVelocity(velocity, for: theView)
            behavior.resistance = 10.0
            animator.addBehavior(behavior)
            
            checkBounds(theView)
        default:
            checkBounds(theView)
        }
 
    }
}

extension HockeyViewController: UICollisionBehaviorDelegate {
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        print(identifier!)
    }
}
