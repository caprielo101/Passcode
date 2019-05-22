//
//  PopUpAdsViewController.swift
//  Passcode
//
//  Created by Josiah Elisha on 22/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit

class PopUpAdsViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var timeLeftView: UIView!
    
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    
    var waitingTime: CFTimeInterval = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(r: 250, g: 250, b: 250)
        let center = timeLeftView.center
        let radius = timeLeftView.frame.width/2
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: -0.5*CGFloat.pi, endAngle: 1.5*CGFloat.pi, clockwise: true)
        
        createTrackLayer(circularPath, whichView: view)
        
        createShapeLayer(circularPath, whichView: view)
        
        shapeLayer.position = center
        trackLayer.position = center
                
        animateCircularLoading()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        closeButton.isHidden = true
        
        _ = Timer.scheduledTimer(timeInterval: waitingTime, target: self, selector: #selector(handleWaitForAds), userInfo: nil, repeats: false)
    }
    
    @objc func handleWaitForAds() {
        closeButton.isHidden = false
    }
    
    fileprivate func createTrackLayer(_ circularPath: UIBezierPath, whichView chosenView: UIView) {
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.init(r: 240, g: 240, b: 240).cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        chosenView.layer.addSublayer(trackLayer)
    }
    
    fileprivate func createShapeLayer(_ circularPath: UIBezierPath, whichView chosenView: UIView) {
        shapeLayer.path = circularPath.cgPath
//        shapeLayer.strokeColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0).cgColor
//        shapeLayer.strokeColor = UIColor.init(r: 107, g: 115, b: 120).cgColor
        shapeLayer.strokeColor = UIColor.init(r: 100, g: 107, b: 113).cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .butt
        shapeLayer.strokeEnd = 0
        chosenView.layer.addSublayer(shapeLayer)
    }
    
    private func animateCircularLoading() {
        let loading = CABasicAnimation(keyPath: "strokeEnd")
        loading.toValue = 1
        loading.duration = waitingTime
        loading.fillMode = .forwards
        loading.isRemovedOnCompletion = false
        
        shapeLayer.add(loading, forKey: "circularLoading")
    }
    
    @IBAction func dismissPopUpAds(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
