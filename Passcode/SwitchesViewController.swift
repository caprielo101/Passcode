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
        mySwitch.onTintColor = UIColor.init(r: 90, g: 200, b: 250)
        mySwitch.addTarget(self, action: #selector(handleToggle), for: .valueChanged)
        return mySwitch
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(r: 245, g: 245, b: 245)
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
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
