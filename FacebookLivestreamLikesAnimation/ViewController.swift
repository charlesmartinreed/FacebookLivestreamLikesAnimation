//
//  ViewController.swift
//  FacebookLivestreamLikesAnimation
//
//  Created by Charles Martin Reed on 12/3/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

//MARK:- screen dimensions
var screenWidth: CGFloat!
var screenHeight: CGFloat!

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = view.frame.width
        screenHeight = view.frame.height
        
//        let curvedView = CurvedView(frame: view.frame)
//        curvedView.backgroundColor = .gray
//
//        view.addSubview(curvedView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
    }

@objc func handleTap() {
    (0...10).forEach { (_) in
        generateAnimatedViews()
    }
}

fileprivate func generateAnimatedViews() {
    //generate the drawing of the images
    //create an animation using some images
    let imageView = UIImageView()
    let dimension = 20 + drand48() * 10 //random number between 0-1, * 10 to get height between 20 and 30
    
    imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: 30)
    
    //randomizing the image using drand48()
    let image = drand48() > 0.5 ? "like" : "love"
    imageView.image = UIImage(named: image)
    
    let animation = CAKeyframeAnimation(keyPath: "position")
    animation.path = customPath().cgPath
    animation.duration = 2 + drand48() * 3 //animation time will vary from 2 seconds +
    
    //animation control
    animation.fillMode = CAMediaTimingFillMode.forwards
    animation.isRemovedOnCompletion = false
    animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
    
    imageView.layer.add(animation, forKey: nil)
    
    view.addSubview(imageView)
}

func customPath() -> UIBezierPath {
    //curvature drawing
    
    //1: Create bezier path
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 200))
    
    //these points are higher and lower on the Y axis, so they'll create the curve visual
    let randomYShift = 200 + drand48() * 300
    
    let controlPoint1 = CGPoint(x: 100, y: 300 - randomYShift)
    let controlPoint2 = CGPoint(x: 200, y: 500 + randomYShift)
    let endPoint = CGPoint(x: screenWidth + 30, y: 200)
    
    path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
    return path
}

//MARK:- Curve drawing class
//class CurvedView: UIView {
//    override func draw(_ rect: CGRect) {
//       let path = customPath()
//        path.lineWidth = 3
//        path.stroke()
//    }
//}

}
