//
//  BlackViewController.swift
//  Passcode
//
//  Created by Josiah Elisha on 18/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit

class BlackViewController: UIViewController {

    var timer = Timer()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return .bottom
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        
//        dismissing contains bug, switch is not user interactable. might need to change it to view will appear function
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss(animated:completion:))))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        timer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(handleNextVC), userInfo: nil, repeats: false)
    }
    
    @objc func handleNextVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "RandomGameViewController")
        present(nextVC, animated: false, completion: nil)
    }
}
