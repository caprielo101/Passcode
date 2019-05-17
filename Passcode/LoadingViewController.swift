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
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let center = view.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -0.5*CGFloat.pi, endAngle: 1.5*CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 20
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0).cgColor
        shapeLayer.lineWidth = 20
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        
        shapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(trackLayer)
        view.layer.addSublayer(shapeLayer)
        createLabel()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLoading)))

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
        timer.fire()
    }
    
    @objc func progressAdding() {
        currentTime += 0.05
        label.text = "\(Int(currentTime/loadingTime*100))%"
        if currentTime >= 4.95 {
            shapeLayer.strokeColor = UIColor.init(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0).cgColor
        }
    }
    
    @objc func handleLoading() {
        debugPrint("Animating")
        //animation
        startTimer()
        let loading = CABasicAnimation(keyPath: "strokeEnd")
        loading.toValue = 1
        loading.duration = CFTimeInterval(loadingTime)
        loading.fillMode = .forwards
        loading.isRemovedOnCompletion = false

        shapeLayer.add(loading, forKey: nil)
    }

}
