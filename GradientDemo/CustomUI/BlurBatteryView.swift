//
//  CutomerBatteryView.swift
//  comic
//
//  Created by Chiao-Te Ni on 2018/3/5.
//  Copyright © 2018年 Appimc. All rights reserved.
//

import Foundation
import UIKit

class BlurBatteryView: UIView {
    
    private var electrodeView: UIView?
    private var bodyView: UIView?
    
    private let electrodeGradient   = CAGradientLayer()
    private let bodyGradient        = CAGradientLayer()
    
    private let xSeperateRatio: CGFloat = 0.915
    private let yHeightRatio: CGFloat   = 0.5
    
    private let blurColor: UIColor = UIColor.lightGray.withAlphaComponent(0.2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        for subView in subviews {
            subView.removeFromSuperview()
        }
        setupElectrodeView()
        setupBodyView()
    }
    
    func updateBatteryLevel(color: UIColor, emptyColor: UIColor = .clear, value: Double) {
        let ratio = Double(xSeperateRatio)
        if value <= ratio {
            let bodyValue = value / ratio
            updateBodyGradient(color: color, emptyColor: emptyColor, value: bodyValue)
            updateElectrodeGradient(color: color, emptyColor: emptyColor, value: 0)
        } else {
            updateBodyGradient(color: color, emptyColor: emptyColor, value: 1)
            let electrodeValue = (value - ratio) * 10
            updateElectrodeGradient(color: color, emptyColor: emptyColor, value: electrodeValue)
        }
    }
    
    private func updateElectrodeGradient(color: UIColor, emptyColor: UIColor = .clear, value: Double) {
        let newValue = 0.5 + value
        let level = NSNumber(value: newValue)
        electrodeGradient.colors        = [UIColor.clear.cgColor, color.cgColor, color.cgColor, emptyColor.cgColor]
        electrodeGradient.locations     = [0.5, 0.5, level, level]
        electrodeGradient.startPoint    = CGPoint(x: 0, y: 1)
        electrodeGradient.endPoint      = CGPoint(x: 1, y: 1)
    }
    
    private func updateBodyGradient(color: UIColor, emptyColor: UIColor = .clear, value: Double) {
        let level = NSNumber(value: value)
        bodyGradient.colors       = [color.cgColor, emptyColor.cgColor]
        bodyGradient.locations    = [level, level]
    }
    
    private func setupElectrodeView() {
        let size = bounds.size
        let electrodeViewPtx    = size.width * (xSeperateRatio - 0.02)
        let electrodeViewWidth  = (size.width - electrodeViewPtx)
        let electrodeViewHeight = size.height * yHeightRatio
        let electrodeViewPty    = (size.height - electrodeViewHeight) / 2// (a - 0.9a)/2
        
        let frame = CGRect(x: electrodeViewPtx,
                           y: electrodeViewPty,
                           width: electrodeViewWidth,
                           height: electrodeViewHeight)
        
        let blurView = BlurEffectHelper.getBlurEffectView(frame: CGRect(x: frame.width/2,
                                                                        y: 0,
                                                                        width: frame.width,
                                                                        height: frame.height),
                                                          color: blurColor, style: .regular)
        let blurContainerView = UIView(frame: frame)
        blurContainerView.cornerRadius = electrodeViewHeight / 2
        blurContainerView.layer.masksToBounds = true
        blurContainerView.clipsToBounds = true
        
        electrodeView = UIView(frame: frame)
        electrodeView?.addSubview(blurView)

        electrodeView?.cornerRadius = electrodeViewHeight / 2
        electrodeView?.layer.masksToBounds = true
        
        electrodeGradient.frame         = electrodeView!.bounds
        electrodeGradient.colors        = [UIColor.clear.cgColor, UIColor.clear.cgColor]
        electrodeGradient.startPoint    = CGPoint(x: 0, y: 1)
        electrodeGradient.endPoint      = CGPoint(x: 0, y: 1)
        
        let electrodeGradientView = UIView(frame: electrodeView!.frame)
        electrodeGradientView.cornerRadius = electrodeViewHeight / 2
        electrodeGradientView.layer.masksToBounds = true
        electrodeGradientView.layer.insertSublayer(electrodeGradient, at: 0)
        
        self.addSubview(electrodeView!)
        self.addSubview(electrodeGradientView)
    }
    
    private func setupBodyView() {
        let size = bounds.size
        let bodyViewPtx: CGFloat    = 0
        let bodyViewWidth           = size.width * xSeperateRatio
        let bodyViewPty: CGFloat    = 0
        let bodyViewHeight          = size.height
        
        let frame = CGRect(x: bodyViewPtx, y: bodyViewPty, width: bodyViewWidth, height: bodyViewHeight)
        
        let blurView = BlurEffectHelper.getBlurEffectView(frame: frame, color: blurColor, style: .regular)
        blurView.cornerRadius           = bodyViewHeight / 10
        blurView.layer.masksToBounds    = true
        
        bodyView = UIView(frame: frame)
        guard let bodyView = bodyView else { return }
        bodyView.cornerRadius           = bodyViewHeight / 10
        bodyView.layer.masksToBounds    = true
        
        bodyGradient.frame            = bodyView.bounds
        bodyGradient.colors           = [UIColor.clear.cgColor, UIColor.clear.cgColor]
        bodyGradient.startPoint       = CGPoint(x: 0, y: 1)
        bodyGradient.endPoint         = CGPoint(x: 1, y: 1)
        
        bodyView.layer.insertSublayer(bodyGradient, at: 0)
        
        self.addSubview(blurView)
        self.addSubview(bodyView)
    }
    
    private func setBGGrandent(for view: UIView?, value: Double, leftColor: UIColor, rightColor: UIColor) {
        guard let targetView = view else {
            printDebug(.debug, "\(#function), bodyView == nil")
            return
        }
        let level = NSNumber(value: value)
        
        let headerGradient = CAGradientLayer()
        
        headerGradient.frame        = targetView.bounds
        headerGradient.colors       = [leftColor.cgColor, rightColor.cgColor]
        headerGradient.locations    = [level, level]
        headerGradient.startPoint   = CGPoint(x: 0, y: 1)
        headerGradient.endPoint     = CGPoint(x: 1, y: 1)
        
        targetView.layer.insertSublayer(headerGradient, at: 0)
    }
}
