//
//  LoadingOverlayView.swift
//  Passcode
//
//  Created by Josiah Elisha on 17/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit

class LoadingOverlayView: UIView {

    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    var label = UILabel()
    
    var currentTime: Double = 0
    var timer = Timer()
    var loadingTime:Double = 5.0
    
    static var currentOverlay : UIView?
    static var currentOverlayTarget : UIView?
    
    func show(_ overlayTarget: UIView) {
        LoadingOverlayView.hide()
        let overlay = UIView()
        overlay.alpha = 0
        overlay.backgroundColor = .black
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlayTarget.addSubview(overlay)
        overlayTarget.bringSubviewToFront(overlay)
        
        overlay.widthAnchor.constraint(equalTo: overlayTarget.widthAnchor).isActive = true
        overlay.heightAnchor.constraint(equalTo: overlayTarget.heightAnchor).isActive = true
        
        let circularPath = UIBezierPath(arcCenter: overlayTarget.center, radius: 100, startAngle: -0.5*CGFloat.pi, endAngle: 1.5*CGFloat.pi, clockwise: true)
        
        overlay.layer.addSublayer(createTrackLayer(circularPath))
        overlay.layer.addSublayer(createShapeLayer(circularPath))
        overlay.addSubview(createLabel(atCenter: overlayTarget.center))
        ShowLoadingAnimation(circularPath)
        
        overlay.alpha = overlay.alpha > 0 ? 0 : 0.9
        LoadingOverlayView.currentOverlay = overlay
        LoadingOverlayView.currentOverlayTarget = overlayTarget
        
        //print(LoadingOverlayView.currentOverlay, LoadingOverlayView.currentOverlayTarget)
        overlay.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector((hidden))))
    }
    
    @objc func hidden() {
        print("Removing all animation")
        shapeLayer.removeAllAnimations()
        LoadingOverlayView.hide()
        KillLoadingOverlay()
    }
    
    static func hide() {
        if currentOverlay != nil {
            currentOverlay?.removeFromSuperview()
            currentOverlay =  nil
            currentOverlayTarget = nil
        }
    }
    
    fileprivate func createTrackLayer(_ circularPath: UIBezierPath)  -> CAShapeLayer{
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 20
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        return trackLayer
    }
    
    fileprivate func createShapeLayer(_ circularPath: UIBezierPath)  -> CAShapeLayer{
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0).cgColor
        shapeLayer.lineWidth = 20
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        return shapeLayer
    }
    
    //Creating the label to animate then
    func createLabel(atCenter center:CGPoint) -> UILabel {
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.text = "0%"
        label.font = UIFont.init(name: "SF Pro Display", size: 40)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.center = center
        label.adjustsFontSizeToFitWidth = true
        //        label.minimumScaleFactor = 0.5
        return label
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
    
    func ShowLoadingAnimation(_ circularPath: UIBezierPath) {
        startTimer()
        let loading = CABasicAnimation(keyPath: "strokeEnd")
        loading.toValue = 1
        loading.duration = CFTimeInterval(loadingTime)
        loading.fillMode = .forwards
        loading.isRemovedOnCompletion = false
//        createShapeLayer(circularPath).add(loading, forKey: nil)
        shapeLayer.add(loading, forKey: nil)
    }
    
    func KillLoadingOverlay() {
        //handle tap 3-5 times
        
        //after handling taps
        currentTime = 0
        timer.invalidate()
    }
    
}
