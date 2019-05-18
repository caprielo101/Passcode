//
//  BlackViewController.swift
//  Passcode
//
//  Created by Josiah Elisha on 18/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit

class BlackViewController: UIViewController {

    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        
//        dismissing contains bug, switch is not user interactable. might need to change it to view will appear function
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss(animated:completion:))))
    }
    
}
