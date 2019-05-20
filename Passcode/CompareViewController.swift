//
//  CompareViewController.swift
//  Passcode
//
//  Created by Josiah Elisha on 18/05/19.
//  Copyright © 2019 Josiah Elisha. All rights reserved.
//

import UIKit

class CompareViewController: UIViewController {
    
    private var circle: UIView!
    
    private var label: UILabel!
    
    private let requiredDistance:Int = 1234
    
    var pan = UIPanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .white
        label.sizeToFit()
        label.font = UIFont.init(name: "SF Pro Display", size: 40)
        label.textAlignment = .center
        view.addSubview(label)
        
        circle = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        circle.center = view.center
        circle.backgroundColor = .white
        circle.layer.cornerRadius = circle.frame.height / 2
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.clipsToBounds = true
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        view.addSubview(circle)
        view.addGestureRecognizer(pan)
        
        if let myLabel = label {
            myLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
            myLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            myLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            myLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        circle.center = view.center
        circle.transform = CGAffineTransform(scaleX: 1, y: 1)
        view.addGestureRecognizer(pan)
    }
    
    @objc func animate() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.circle.center = self.circle.center
        }, completion: { (Bool) in
            UIView.animate(withDuration: 1.5, delay: 2, options: .curveEaseInOut, animations: {
                self.circle.transform = CGAffineTransform(scaleX: 25, y: 25)

            }, completion: { (Bool) in
                debugPrint("animating the completion screen")
                self.view.removeGestureRecognizer(self.pan)

            })
//            let vc = LoadingViewController()
//            self.present(vc, animated: true, completion: nil)
        })

    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let theView = sender.view!
        let translation = sender.translation(in: theView)
        let distance = Int(ceil(distanceBetween(p1: circle.center, p2: view.center) * 10))
        
        switch sender.state {
        case .began, .changed:
            circle.center = CGPoint(x: circle.center.x + translation.x, y: circle.center.y + translation.y)
            print(distance)
            label.text = "\(distance)"
            sender.setTranslation(CGPoint.zero, in: theView)
            if distance == requiredDistance {
                debugPrint("You won")
                animate()
                label.text = "\(requiredDistance)"
            }
        case .ended, .cancelled, .failed:
            break
        default:
            break
        }
    }

}

extension UIViewController {

    func distanceBetween(p1: CGPoint, p2: CGPoint) -> CGFloat {
        return sqrt(pow(p2.x-p1.x,2)+pow(p2.y-p1.y,2))

    }
}
