//
//  LoadingWeirdViewController.swift
//  Passcode
//
//  Created by Josiah Elisha on 22/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit

class LoadingWeirdViewController: UIViewController {

    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    var label = UILabel()
    
    var currentTime: CFTimeInterval = 0
    var timer = Timer()
    var loadingTime:CFTimeInterval = 5.0
    
    var tap: UITapGestureRecognizer!
    
    let checkmark = Checkmark(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    lazy var overlayView: UIView = {
        let overlay = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        overlay.alpha = 0.85
        overlay.backgroundColor = .black
        overlay.isHidden = false
        return overlay
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        checkmark.animated = true
        checkmark.animate()
        super.touchesBegan(touches, with: event)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = .black
        view.addSubview(overlayView)
        view.sendSubviewToBack(overlayView)
        
        checkmark.alpha = 0
        label.alpha = 0
        label.transform = CGAffineTransform(scaleX: 1, y: 1)
        let center = view.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -0.5*CGFloat.pi, endAngle: 1.5*CGFloat.pi, clockwise: true)
        
        createTrackLayer(circularPath)

        createShapeLayer(circularPath)

        createLabel()

        ShowLoadingOverlay()
        
        view.isUserInteractionEnabled = false
        tap = UITapGestureRecognizer(target: self, action: #selector(handleLoadingStop(_:)))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkmark.center  = view.center
        view.addSubview(checkmark)
    }
    
    fileprivate func createTrackLayer(_ circularPath: UIBezierPath) {
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.init(white: 4/5, alpha: 1).cgColor
        trackLayer.lineWidth = 20
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        view.layer.addSublayer(trackLayer)
    }
    
    fileprivate func createShapeLayer(_ circularPath: UIBezierPath) {
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.higRed.cgColor
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
        timer = Timer.scheduledTimer(timeInterval: loadingTime/100, target: self, selector: #selector(progressAdding), userInfo: nil, repeats: true)
    }
    
    @objc func progressAdding() {
        if currentTime < loadingTime {
            currentTime += loadingTime/100
            label.text = "\(Int(currentTime/loadingTime*100))%"
        } else {
            currentTime = loadingTime
            label.text = "\(Int(currentTime/loadingTime*100))%"
            shapeLayer.strokeColor = UIColor.higGreen.cgColor
            timer.invalidate()
            _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(handleComplete), userInfo: nil, repeats: false)
        }
    }
    
    func showCheckmark() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.label.alpha = 0
            self.label.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.checkmark.alpha = 1
        }) { (Bool) in
            self.checkmark.animated = true
            self.checkmark.animate()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    @objc func handleComplete() {
        showCheckmark()
    }
    
    @objc func handleLoadingStop(_ sender: UITapGestureRecognizer) {
        debugPrint("Stopping")
        //animation
        shapeLayer.removeAnimation(forKey: "loading")
        //present the next vc
        let nextVC = SwitchesViewController()
        nextVC.modalTransitionStyle = .crossDissolve
        present(nextVC, animated: true, completion: nil)
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
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

}
