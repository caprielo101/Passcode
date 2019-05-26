//
//  NumpadViewController.swift
//  Passcode
//
//  Created by Josiah Elisha on 25/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//


import UIKit
import AudioToolbox

class NumpadViewController: UIViewController {
    
    @IBOutlet weak var input1: UILabel!
    @IBOutlet weak var input2: UILabel!
    @IBOutlet weak var input3: UILabel!
    @IBOutlet weak var input4: UILabel!
    
    @IBOutlet var PasscodeInputs: [UILabel]!
    
    @IBOutlet weak var InputStackView: UIStackView!
    
    @IBOutlet weak var submitButton: NumpadButton!
    @IBOutlet weak var clearButton: NumpadButton!
    @IBOutlet var numpadButtons: [NumpadButton]!
    let answer_of_level1 = ["1", "2", "3", "4"]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotificationObserver()
        
        view.backgroundColor = .black
        
        if let buttons = numpadButtons {
            for button in buttons {
                button.setTitle("", for: .normal)
            }
        }
        
        setupInputs()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        animationChecker()
    }
    
    func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    fileprivate func setupClearAndSubmit() {
        if let clear = clearButton {
            clear.setTitle("", for: .normal)
            clear.transform = CGAffineTransform(rotationAngle: 0)
            clear.contentMode = .center
            clear.setImage(UIImage(named: "refresh.png"), for: .normal)
            clear.backgroundColor = .init(r: 164, g: 164, b: 164)
            clear.tintColor = .init(r: 18, g: 18, b: 18)
        }
        
        if let submit = submitButton {
            submit.setTitle("", for: .normal)
            submit.contentMode = .center
            submit.setImage(UIImage(named: "chevron.png"), for: .normal)
            submit.tintColor = .white
            submit.backgroundColor = .init(r: 61, g: 57, b: 63)
        }

    }
    
    func setupInputs() {
        if let inputs = PasscodeInputs {
            for input in inputs {
                input.textColor = .white
                input.text = nil
                input.addBottomBorder()
                input.layer.removeAllAnimations()
            }
        }
        setupClearAndSubmit()
    }
    
    @IBAction func numpad(_ sender: UIButton) {
        let input = sender.tag
        switch input {
        case 1, 2, 3, 4, 5, 6, 7, 8, 9, 0:
            inputChecker(input)
            //Play click sound from sound library
            AudioServicesPlaySystemSound(1104)
        case 10:
            if input1.text != nil || input2.text != nil || input3.text != nil || input4.text != nil {
                setupInputs()
            } else {
                debugPrint("Nothing to reset")
            }
            //Play click sound from sound library
            AudioServicesPlaySystemSound(1104)
            setupClearAndSubmit()
        case 11:
            //RightCheck
            let completed = checkAnswerIfCorrect()
            //harus diatur supaya jadi if true or false di method check answer if correct
            if input1.text != nil && input2.text != nil && input3.text != nil && input4.text != nil {
                if completed {
                    //animate
                    let presentedLoadingScreen = LoadingViewController()
                    presentedLoadingScreen.modalPresentationStyle = .overFullScreen
                    self.present(presentedLoadingScreen,animated: false, completion: nil)
                    //Play click sound from sound library
                    AudioServicesPlaySystemSound(1104)
                    print(completed)
                } else {
                    setupInputs()
                    view.shakeAnimate(howMuchX: 10,howMuchY: 0, howManyRepeats: 1)
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
                    print(completed)
                }
            } else {
                //animate
                submitButton.shakeAnimate(howMuchX: 5,howMuchY: 0, howManyRepeats: 2)
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
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
        if let input_1 = input1 {
            if input_1.text == nil {
                input_1.flashAnimate()
            } else if let input_2 = input2 {
                if input_2.text == nil {
                    input_2.flashAnimate()
                } else if let input_3 = input3 {
                    if input_3.text == nil {
                        input_3.flashAnimate()
                    } else if let input_4 = input4 {
                        if input_4.text == nil {
                            input_4.flashAnimate()
                        }
                    }
                }
            }
        }
//
//        if input1.text == nil {
//            input1.flashAnimate()
//        } else if input2.text == nil {
//            input2.flashAnimate()
//        } else if input3.text == nil {
//            input3.flashAnimate()
//        } else if input4.text == nil {
//            input4.flashAnimate()
//        } else {
//            //Animate
//        }
    }
    
    func readyToSubmit() {
        submitButton.backgroundColor = .higGreen
        submitButton.tintColor = .black
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
                                    }
                                }
                            } else {
                                print("Check nomor 3 udah salah")
                            }
                        }
                    } else {
                        print("Check nomor 2 udah salah")
                    }
                }
            } else {
                print("Check nomor 1 udah salah")
            }
        }
        return false
    }
    
    @objc func handleForeground() {
        animationChecker()
    }
}
