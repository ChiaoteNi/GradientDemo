//
//  BlurEffectHelper.swift
//  GradientDemo
//
//  Created by Chiao-Te Ni on 2018/5/19.
//  Copyright © 2018年 aaron. All rights reserved.
//

import Foundation
import UIKit

class BlurEffectHelper {
    
    static func getBlurEffectView(frame: CGRect, color: UIColor = .white, style: UIBlurEffectStyle = .regular) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = frame
        //        visualEffectView.isUserInteractionEnabled = false
        
        let view = visualEffectView.subviews[1]
        view.backgroundColor = color
        return visualEffectView
    }
}
