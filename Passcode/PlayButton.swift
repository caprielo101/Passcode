//
//  PlayButton.swift
//  Passcode
//
//  Created by Josiah Elisha on 22/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit

class PlayButton: UIButton {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.09, delay: 0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: nil)
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.09, delay: 0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
        super.touchesEnded(touches, with: event)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setup button
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setup button
        setupButton()
    }

    func setupButton() {
        self.layer.cornerRadius = self.frame.height/2

    }
}
