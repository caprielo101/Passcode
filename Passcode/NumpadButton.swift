//
//  NumpadButton.swift
//  Passcode
//
//  Created by Josiah Elisha on 15/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit

class NumpadButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        backgroundColor = UIColor.init(red: 115/256, green: 115/256, blue: 115/256, alpha: 1.0)

        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UIView.animate(withDuration: 0.4,delay: 0, options: .curveEaseInOut, animations: {
            self.backgroundColor = UIColor.init(red: 61/256, green: 57/256, blue: 63/256, alpha: 1.0)
        }, completion: nil)
        
        super.touchesEnded(touches, with: event)
    }
    
    func setupButton() {
        layer.cornerRadius = self.frame.width / 2
        layer.borderColor = nil
        backgroundColor = UIColor.init(red: 61/256, green: 57/256, blue: 63/256, alpha: 1.0)
        setTitleColor(UIColor.init(red: 251/256, green: 249/256, blue: 253/256, alpha: 1.0), for: .normal)
    }

}
