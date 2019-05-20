//
//  RandomGameViewController.swift
//  Passcode
//
//  Created by Josiah Elisha on 19/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit

class RandomGameViewController: UIViewController {
    
    @IBOutlet weak var inputStackView: UIStackView!
    @IBOutlet weak var input1: UILabel!
    @IBOutlet weak var input2: UILabel!
    @IBOutlet weak var input3: UILabel!
    @IBOutlet weak var input4: UILabel!
    
    @IBOutlet var inputs: [UILabel]!
    @IBOutlet weak var randomizeButton: UIButton!
    @IBOutlet weak var randomizeButton2: UIButton!
    @IBOutlet weak var randomizeButton3: UIButton!
    @IBOutlet weak var randomizeButton4: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    let answers = [1, 2, 3, 4]
    var temp1 = 0
    var temp2 = 0
    var temp3 = 0
    var temp4 = 0
    var timer = Timer()
    
    fileprivate func setupInputs() {
        for input in inputs {
            input.text = "0"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInputs()
        setupButtons()
        //setup when opening the app
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        animationCheck()
        //setup when opening this vc
    }
    
    func animationCheck() {
        timer = Timer.scheduledTimer(timeInterval: 0.09, target: self, selector: #selector(handleAnimation), userInfo: nil, repeats: true)
    }
    
    @objc func handleAnimation() {
        var rng = 0
        if temp1 != answers[0] {
            rng = Int.random(in: 0...9)
            input1.text = "\(rng)"
        } else if temp2 != answers[1] {
            rng = Int.random(in: 0...9)
            input2.text = "\(rng)"
        } else if temp3 != answers[2] {
            rng = Int.random(in: 0...9)
            input3.text = "\(rng)"
        } else if temp4 != answers[3] {
            rng = Int.random(in: 0...9)
            input4.text = "\(rng)"
        }
    }
    
    @IBAction func randomize(_ sender: UIButton) {
        let rng = Int.random(in: 0...9)
        switch sender.tag {
        case 1:
            temp1 = rng
            input1.text = "\(temp1)"
            checkInput()
        case 2:
            temp2 = rng
            input2.text = "\(temp2)"
            checkInput()
        case 3:
            temp3 = rng
            input3.text = "\(temp3)"
            checkInput()
        case 4:
            temp4 = rng
            input4.text = "\(temp4)"
            checkInput()
        default:
            break
        }
        //done
        debugPrint("clicking button number \(sender.tag)")
    }
    
    func checkInput() {
        if temp1 == answers[0] {
            randomizeButton.isEnabled = false
        } else if temp2 == answers[1] {
            randomizeButton2.isEnabled = false
        } else if temp3 == answers[2] {
            randomizeButton3.isEnabled = false
        } else if temp4 == answers[3] {
            randomizeButton4.isEnabled = false
        }
    }
    
    func setupButtons() {
        randomizeButton.isEnabled = true
        randomizeButton2.isEnabled = true
        randomizeButton3.isEnabled = true
        randomizeButton4.isEnabled = true
    }
    
    @IBAction func reset(_ sender: UIButton) {
        //animate
        debugPrint("animating")
        setupButtons()
        setupInputs()
        timer.invalidate()
    }
}
