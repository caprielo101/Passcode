//
//  LoadingViewController.swift
//  Passcode
//
//  Created by Josiah Elisha on 17/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    var label = UILabel()
    
    var currentTime: Double = 0
    var timer = Timer()
    var loadingTime:Double = 5.0
    
    var numberOfTap = 0
    var tap: UITapGestureRecognizer!
    
    lazy var overlayView: UIView = {
        let overlay = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        overlay.alpha = 0.9
        overlay.backgroundColor = .black
        overlay.isHidden = false
        return overlay
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.shakeAnimate(howMuchX: 5, howManyRepeats: 1)

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = .black
        
        view.addSubview(overlayView)
        view.sendSubviewToBack(overlayView)
        
        let center = view.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -0.5*CGFloat.pi, endAngle: 1.5*CGFloat.pi, clockwise: true)
        
        createTrackLayer(circularPath)
        
        createShapeLayer(circularPath)
        
        createLabel()
        
        ShowLoadingOverlay()
        
        tap = UITapGestureRecognizer(target: self, action: #selector(handleLoading(_:)))
        tap.numberOfTapsRequired = 3
        view.addGestureRecognizer(tap)
    }
    
    fileprivate func createTrackLayer(_ circularPath: UIBezierPath) {
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 20
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        view.layer.addSublayer(trackLayer)
    }
    
    fileprivate func createShapeLayer(_ circularPath: UIBezierPath) {
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0).cgColor
        shapeLayer.lineWidth = 20
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
    }
    
    //Creating the label to animate then
    func createLabel() {
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.text = "0%"
        label.font = UIFont.init(name: "SF Pro Display", size: 40)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.center = view.center
        label.adjustsFontSizeToFitWidth = true
//        label.minimumScaleFactor = 0.5
        view.addSubview(label)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(progressAdding), userInfo: nil, repeats: true)
    }
    
    @objc func progressAdding() {
        currentTime += 0.05
        label.text = "\(Int(currentTime/loadingTime*100))%"
        if currentTime >= 4.95 {
            shapeLayer.strokeColor = UIColor.init(r: 76, g: 217, b: 100).cgColor
            view.isUserInteractionEnabled = true
        } else {
            view.isUserInteractionEnabled = false
        }
    }
    
    @objc func handleLoading(_ sender: UITapGestureRecognizer) {
        debugPrint("Stopping")
        //animation
        shapeLayer.removeAnimation(forKey: "loading")
        KillLoadingOverlay()
        self.dismiss(animated: false, completion: nil)
    }
    
    func ShowLoadingOverlay() {
        startTimer()
        let loading = CABasicAnimation(keyPath: "strokeEnd")
        loading.toValue = 1
        loading.duration = CFTimeInterval(loadingTime)
        loading.fillMode = .forwards
        loading.isRemovedOnCompletion = false
        
        shapeLayer.add(loading, forKey: "loading")
    }
    
    func KillLoadingOverlay() {
        //handle tap 3-5 times
        timer.invalidate()
    }

}
