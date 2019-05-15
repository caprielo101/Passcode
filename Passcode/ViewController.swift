//
//  ViewController.swift
//  Passcode
//
//  Created by Josiah Elisha on 15/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var input1: UILabel!
    @IBOutlet weak var input2: UILabel!
    @IBOutlet weak var input3: UILabel!
    @IBOutlet weak var input4: UILabel!
    
    @IBOutlet var PasscodeInputs: [UILabel]!
    
    @IBOutlet weak var InputStackView: UIStackView!
    
    @IBOutlet weak var submitButton: NumpadButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupInputs()
        animationChecker()
    }

    func setupInputs() {

        for input in PasscodeInputs {
            input.textColor = .white
//            input.backgroundColor = .lightGray
            input.text = nil
            input.addBottomBorder()
        }
    }
    
    @IBAction func numpad(_ sender: UIButton) {
        let input = sender.tag
        switch input {
        case 1:
            inputChecker(input)
        case 2:
            inputChecker(input)
        case 3:
            inputChecker(input)
        case 4:
            inputChecker(input)
        case 5:
            inputChecker(input)
        case 6:
            inputChecker(input)
        case 7:
            inputChecker(input)
        case 8:
            inputChecker(input)
        case 9:
            inputChecker(input)
        case 0:
            inputChecker(input)
        case 10:
            setupInputs()
        case 11:
            print("Checking Answers")
            //RightCheck
            
            //WrongCheck
        default: break
        }
        animationChecker()
    }
    
    func inputChecker(_ input: Int)  {
        if input1.text == nil {
            input1.text = String(input)
            input1.layer.removeAllAnimations()
        } else if input2.text == nil {
            input2.text = String(input)
            input2.layer.removeAllAnimations()
        } else if input3.text == nil {
            input3.text = String(input)
            input3.layer.removeAllAnimations()
        } else if input4.text == nil {
            input4.text = String(input)
            input4.layer.removeAllAnimations()
            readyToSubmit()
        } else {
            //Animate

        }
    }
    
    func animationChecker() {
        if input1.text == nil {
            input1.flashAnimate()
        } else if input2.text == nil {
            input2.flashAnimate()
        } else if input3.text == nil {
            input3.flashAnimate()
        } else if input4.text == nil {
            input4.flashAnimate()
        } else {
            //Animate
        }
    }
    
    func readyToSubmit() {
        submitButton.backgroundColor = UIColor(red: 76/256, green: 217/256, blue: 100/256, alpha: 1.0)
    }
}

extension UILabel {
    
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect.init(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.white.cgColor
        self.layer.addSublayer(bottomLine)
    }
    
    func flashAnimate()  {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 1
        flash.fromValue = 1
        flash.toValue = 0.2
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = false
        flash.repeatCount = Float.infinity
        layer.add(flash, forKey: nil)
    }
    
}

