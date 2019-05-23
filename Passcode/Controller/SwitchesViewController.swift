//
//  SwitchesViewController.swift
//  Passcode
//
//  Created by Josiah Elisha on 18/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit

class SwitchesViewController: UIViewController {
    
    private var timer = Timer()
    
    let darkModeSwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.tintColor = UIColor.clear
        mySwitch.backgroundColor = .lightGray
        mySwitch.layer.cornerRadius = mySwitch.frame.height / 2
        mySwitch.transform = CGAffineTransform(scaleX: 3, y: 3);
        mySwitch.isOn = false
        mySwitch.isUserInteractionEnabled = true
        mySwitch.onTintColor = .higTeal
        mySwitch.addTarget(self, action: #selector(handleToggle), for: .valueChanged)
        return mySwitch
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(r: 250, g: 250, b: 250)
        darkModeSwitch.center = view.center
        view.addSubview(darkModeSwitch)
    }

    @objc func handleToggle(_ sender: UISwitch) {
        if sender.isOn {
            darkModeSwitch.isUserInteractionEnabled = false
            timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timeForSegue), userInfo: nil, repeats: false)
        } else {
            debugPrint(sender.isOn)
            darkModeSwitch.isUserInteractionEnabled = true
        }
    }
    
    @objc func timeForSegue() {
        let nextVC = BlackViewController()
        present(nextVC, animated: false, completion: nil)
    }

}
