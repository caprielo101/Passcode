//
//  PopUpAdsViewController.swift
//  Passcode
//
//  Created by Josiah Elisha on 22/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit
import AVKit
import CoreMedia

class PopUpAdsViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var timeLeftView: UIView!
    
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    
    var waitingTime: CFTimeInterval = 15

    var player: AVPlayer!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playVideo("forest", withExtension: "mov")
        
        setupAVNotificationObservers()
        
        let black = UIView(frame: view.frame)
        black.alpha = 0.4
        black.backgroundColor = .black
        view.addSubview(black)
        
        view.backgroundColor = UIColor.init(r: 250, g: 250, b: 250)
        let center = timeLeftView.center
        let radius = timeLeftView.frame.width/2
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: -0.5*CGFloat.pi, endAngle: 1.5*CGFloat.pi, clockwise: true)
        
        createTrackLayer(circularPath, whichView: view)
        
        createShapeLayer(circularPath, whichView: view)
        
        shapeLayer.position = center
        trackLayer.position = center
        
        animateCircularLoading()
        
        closeButton.tintColor = .white
        view.bringSubviewToFront(closeButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        closeButton.isHidden = true
        
        _ = Timer.scheduledTimer(timeInterval: waitingTime, target: self, selector: #selector(handleWaitForAds), userInfo: nil, repeats: false)
    }
    
    @objc func handleWaitForAds() {
        closeButton.isHidden = false
    }
    
    fileprivate func setupAVNotificationObservers() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player.currentItem, queue: .main) { [weak self] _ in
            self?.player?.seek(to: .zero)
            self?.player?.play()
        }
    }
    
    fileprivate func createTrackLayer(_ circularPath: UIBezierPath, whichView chosenView: UIView) {
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.init(white: 210/255, alpha: 1.0).cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        chosenView.layer.addSublayer(trackLayer)
    }
    
    fileprivate func createShapeLayer(_ circularPath: UIBezierPath, whichView chosenView: UIView) {
        shapeLayer.path = circularPath.cgPath
//        shapeLayer.strokeColor = UIColor.init(r: 100, g: 107, b: 113).cgColor
        shapeLayer.strokeColor = UIColor.init(r: 120, g: 127, b: 133).cgColor
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
    
    func playVideo(_ fileName: String, withExtension: String) {
        if let path = Bundle.main.path(forResource: fileName, ofType: withExtension) {
            let videoURL = URL(fileURLWithPath: path)
            //            let videoURL = URL(string: "https://www.videvo.net/videvo_files/converted/2013_11/videos/WalkingThroughTreesatSunsetVidevo.mov15470.mp4")
            player = AVPlayer(url: videoURL)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.view.bounds
            playerLayer.videoGravity = .resizeAspectFill
            self.view.layer.addSublayer(playerLayer)
            player.play()
        }
        
    }
    
}
