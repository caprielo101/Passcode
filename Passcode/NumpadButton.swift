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

        backgroundColor = UIColor.init(r: 115, g: 115, b: 115)
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UIView.animate(withDuration: 0.2,delay: 0, options: .curveEaseInOut, animations: {
            self.backgroundColor = UIColor.init(r: 61, g: 57, b: 63)
        }, completion: nil)
        
        super.touchesEnded(touches, with: event)
    }
    
    func setupButton() {
        layer.cornerRadius = self.frame.width / 2
        layer.borderColor = nil
        backgroundColor = UIColor.init(red: 61/255, green: 57/255, blue: 63/255, alpha: 1.0)
        setTitleColor(UIColor.init(r: 251, g: 249, b: 253), for: .normal)
    }

}
