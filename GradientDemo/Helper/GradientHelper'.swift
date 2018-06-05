//
//  GradientHelper'.swift
//  GradientDemo
//
//  Created by Chiao-Te Ni on 2018/5/19.
//  Copyright © 2018年 aaron. All rights reserved.
//

import Foundation
import UIKit

class GredientHelper: NSObject {
    
    static func setMutiColors(to view: UIView?, location: Double, leftColor: UIColor, rightColor: UIColor) {
        guard let view = view else { return }
        let level = NSNumber(value: location)
        
        let gradient = CAGradientLayer()
        gradient.frame        = view.bounds
        gradient.colors       = [leftColor.cgColor, rightColor.cgColor]
        gradient.locations    = [level, level]
        gradient.startPoint   = CGPoint(x: 0, y: 1)
        gradient.endPoint     = CGPoint(x: 1, y: 1)
        
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    static func setGradient(to view: UIView?,
                            locations: [NSNumber], colors: [UIColor],
                            strPt: CGPoint = CGPoint(x: 0, y: 1),
                            endPt: CGPoint = CGPoint(x: 1, y: 1)) {
        guard let view = view else { return }
        
        let gradient = CAGradientLayer()
        gradient.frame      = view.frame
        gradient.colors     = colors
        gradient.locations  = locations
        gradient.startPoint = strPt
        gradient.endPoint   = endPt
        view.layer.insertSublayer(gradient, at: 0)
    }
}
