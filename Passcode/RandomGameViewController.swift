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
    @IBOutlet weak var submitButton: UIButton!
    
    let answers = [1, 2, 3, 4]
    var temp1 = 0
    var temp2 = 0
    var temp3 = 0
    var temp4 = 0
    var timer = Timer()
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupInputs()
        setupButtons()
        //setup when opening the app
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        animationCheck()
        //setup when opening this vc
    }
    
    fileprivate func setupInputs() {
        for input in inputs {
            input.text = "0"
            input.addBottomBorder()
            input.textColor = .white
        }
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
        case 2:
            temp2 = rng
            input2.text = "\(temp2)"
        case 3:
            temp3 = rng
            input3.text = "\(temp3)"
        case 4:
            temp4 = rng
            input4.text = "\(temp4)"
        default:
            break
        }
        checkInput()
        checkIfCorrect()
        //done
    }
    
    func checkInput() {
        if temp1 == answers[0] {
//            randomizeButton.isEnabled = false
            randomizeButton.backgroundColor = .white
        }
        if temp2 == answers[1] {
//            randomizeButton2.isEnabled = false
            randomizeButton2.backgroundColor = .white
        }
        if temp3 == answers[2] {
//            randomizeButton3.isEnabled = false
            randomizeButton3.backgroundColor = .white
        }
        if temp4 == answers[3] {
//            randomizeButton4.isEnabled = false
            randomizeButton4.backgroundColor = .white
        }
        setupResetAndSubmit()
    }
    
    fileprivate func setupResetAndSubmit() {
        resetButton.setTitle("", for: .normal)
        resetButton.contentMode = .center
        resetButton.setImage(UIImage(named: "refresh.png"), for: .normal)
        resetButton.backgroundColor = .init(r: 164, g: 164, b: 164)
        resetButton.tintColor = .init(r: 18, g: 18, b: 18)
        
        submitButton.setTitle("", for: .normal)
        submitButton.contentMode = .center
        submitButton.setImage(UIImage(named: "chevron.png"), for: .normal)
        submitButton.tintColor = .white
        submitButton.backgroundColor = .init(r: 61, g: 57, b: 63)
    }
    
    func setupButtons() {
        randomizeButton.isEnabled = true
        randomizeButton2.isEnabled = true
        randomizeButton3.isEnabled = true
        randomizeButton4.isEnabled = true
        
        randomizeButton.setTitle("", for: .normal)
        randomizeButton2.setTitle("", for: .normal)
        randomizeButton3.setTitle("", for: .normal)
        randomizeButton4.setTitle("", for: .normal)
        
        randomizeButton.backgroundColor = UIColor.init(r: 61, g: 57, b: 63)
        randomizeButton2.backgroundColor = UIColor.init(r: 61, g: 57, b: 63)
        randomizeButton3.backgroundColor = UIColor.init(r: 61, g: 57, b: 63)
        randomizeButton4.backgroundColor = UIColor.init(r: 61, g: 57, b: 63)
        
        temp1 = 0
        temp2 = 0
        temp3 = 0
        temp4 = 0
        
        setupResetAndSubmit()
        
    }
    
    func checkIfCorrect() {
        if temp1 == answers[0] && temp2 == answers[1] && temp3 == answers[2] && temp4 == answers[3] {
            readyToSubmit()
        }
    }
    
    func readyToSubmit() {
        submitButton.backgroundColor = .init(r: 76, g: 217, b: 100)
        submitButton.tintColor = .black
    }
    
    @IBAction func submit(_ sender: UIButton) {
        if let input_1 = input1.text {
            if input_1 == "\(answers[0])" {
                if let input_2 = input2.text {
                    if input_2 == "\(answers[1])" {
                        if let input_3 = input3.text {
                            if input_3 == "\(answers[2])" {
                                if let input_4 = input4.text {
                                    if input_4 == "\(answers[3])" {
                                        print("Won the random game")
                                        //animate to next VC
                                        let nextVC = CompareViewController()
                                        nextVC.modalTransitionStyle = .crossDissolve
                                        present(nextVC, animated: true, completion: nil)
                                    } else {
                                        wrongInputShake(whichLabel: input4)
                                    }
                                }
                            } else {
                                wrongInputShake(whichLabel: input3)
                            }
                        }
                    } else {
                        wrongInputShake(whichLabel: input2)
                    }
                }
            } else {
                wrongInputShake(whichLabel: input1)
            }
        }
        
    }
    
    func wrongInputShake(whichLabel label: UILabel){
        let randX = CGFloat.random(in: 2...10)
        let randY = CGFloat.random(in: 2...5)
        label.shakeAnimate(howMuchX: randX, howMuchY: randY, howManyRepeats: 1)
    }
    @IBAction func reset(_ sender: UIButton) {
        setupButtons()
        setupInputs()
    }
}
