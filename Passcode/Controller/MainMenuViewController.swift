//
//  MainMenuViewController.swift
//  Passcode
//
//  Created by Josiah Elisha on 21/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var button: PlayButton!
    
    var tap = UITapGestureRecognizer()
    let pulsingLayer = CAShapeLayer()
    let colors: [UIColor] = [UIColor.init(r: 255, g: 59, b: 28), UIColor.init(r: 255, g: 149, b: 0), UIColor.init(r: 255, g: 204, b: 0), UIColor.init(r: 76, g: 217, b: 100), UIColor.init(r: 90, g: 200, b: 250), UIColor.init(r: 0, g: 122, b: 255), UIColor.init(r: 88, g: 86, b: 214), UIColor.init(r: 255, g: 25, b: 85), UIColor.white]
    
    let segue = "goToNextVC"
    let animTime: CFTimeInterval = 2.4
    
    var timer = Timer()
    
    var index = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotificationObservers()
        
        view.backgroundColor = .black
        view.layer.removeAllAnimations()
        
        createPulseLayer()
        
        view.bringSubviewToFront(button)
        tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        button.addGestureRecognizer(tap)
        
        startRandomColorTimer()
        
        animateBackLayer()
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .began:
            animatePlayButtonBegan()
        case .ended:
            animatePlayButtonEnd()
        default:
            return
        }
    }
    
    fileprivate func startRandomColorTimer() {
        timer = Timer.scheduledTimer(timeInterval: animTime, target: self, selector: #selector(handleColorChange), userInfo: nil, repeats: true)
    }
    
    @objc func handleColorChange() {
        let rng = Int.random(in: 0...colors.count - 1)
        button.tintColor = self.colors[rng]
        self.pulsingLayer.fillColor = self.colors[rng].cgColor
        
        
        //        let rng2 = Int.random(in: 0...colors.count - 1)
        //        self.pulsingLayer.strokeColor = self.colors[rng2].cgColor
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc private func handleForeground() {
        view.layer.removeAllAnimations()
        timer.invalidate()
        animateBackLayer()
        startRandomColorTimer()
    }
    
    fileprivate func createPulseLayer() {
        let radius = button.frame.width / 2
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        pulsingLayer.path = circularPath.cgPath
        //        pulsingLayer.strokeColor = UIColor.white.cgColor
        //        pulsingLayer.lineWidth = 10
        pulsingLayer.fillColor = UIColor.white.cgColor
        pulsingLayer.lineCap = .round
        pulsingLayer.position = view.center
        view.layer.addSublayer(pulsingLayer)
    }
    
    
    func animateBackLayer() {
        let scaling = CABasicAnimation(keyPath: "transform.scale")
        scaling.toValue = 2.4
        scaling.duration = animTime
        scaling.timingFunction = CAMediaTimingFunction(name: .easeOut)
        scaling.repeatCount = Float.infinity
        
        let alpha = CABasicAnimation(keyPath: "opacity")
        alpha.fromValue = 1
        alpha.toValue = 0
        alpha.duration = animTime
        alpha.timingFunction = CAMediaTimingFunction(name: .easeOut)
        alpha.repeatCount = Float.infinity
        
        pulsingLayer.add(alpha, forKey: "opacity")
        pulsingLayer.add(scaling, forKey: "pulse")
    }
    
    func animatePlayButtonEnd() {
        self.button.tintColor = .white
        
        UIView.animate(withDuration: 0.11, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: .curveEaseIn, animations: {
            self.button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (Bool) in
            UIView.animate(withDuration: 0.12, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: .curveLinear, animations: {
                self.button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: { (Bool) in
                UIView.animate(withDuration: 0.12, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 15, options: .curveEaseOut, animations: {
                    self.button.transform = CGAffineTransform(scaleX: 1, y: 1)
                    
                }, completion: { (Bool) in
                    //wait For Seconds / Go to next vc
                    _ = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.waitForSeconds), userInfo: nil, repeats: false)
                })
            })
        }
    }
    
    func animatePlayButtonBegan() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            self.button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: nil)
    }
    
    func goToNext() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ViewController")
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }
    
    @objc func waitForSeconds() {
        goToNext()
        debugPrint("gotonextvc")
        
    }
}
