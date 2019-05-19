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
    
    let answer_of_level1 = ["1", "2", "3", "4"]
    
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
            input.text = nil
            input.addBottomBorder()
            input.layer.removeAllAnimations()
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
            if input1.text != nil || input2.text != nil || input3.text != nil || input4.text != nil {
                setupInputs()
            } else {
                debugPrint("Nothing to reset")
            }
        case 11:
            //RightCheck
            let completed = checkAnswerIfCorrect()
            //harus diatur supaya jadi if true or false di method check answer if correct
            if input1.text != nil && input2.text != nil && input3.text != nil && input4.text != nil {
                if completed {
                    //animate
                    let presentedLoadingScreen = LoadingViewController()
                    self.present(presentedLoadingScreen,animated: false, completion: nil)
                    print(completed)
                } else {
                    setupInputs()
                    view.shakeAnimate(howMuchX: 10, howManyRepeats: 1)
                    print(completed)
                }
            } else {
                //animate
                submitButton.shakeAnimate(howMuchX: 5, howManyRepeats: 2)
            }
            
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
        submitButton.backgroundColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0)
    }
    
    func checkAnswerIfCorrect() -> Bool {
        if let input_1 = input1.text {
            if input_1 == answer_of_level1[0] {
                if let input_2 = input2.text {
                    if input_2 == answer_of_level1[1] {
                        if let input_3 = input3.text {
                            if input_3 == answer_of_level1[2] {
                                if let input_4 = input4.text {
                                    if input_4 == answer_of_level1[3] {
                                        print("Benar")
                                        return true
                                    } else {
                                        print("Check nomor 4 udah salah")
                                        return false
                                    }
                                }
                            } else {
                                print("Check nomor 3 udah salah")
                                return false
                            }
                        }
                    } else {
                        print("Check nomor 2 udah salah")
                        return false
                    }
                }
            } else {
                print("Check nomor 1 udah salah")
                return false
            }
        }
        return false
    }
    
}

