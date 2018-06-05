//
//  CutomerBatteryView.swift
//  comic
//
//  Created by Chiao-Te Ni on 2018/3/5.
//  Copyright © 2018年 Appimc. All rights reserved.
//

import Foundation
import UIKit

class CustomerBatteryView: UIView {
    
    private var electrodeView: UIView?
    private var bodyView: UIView?
    
    private let xSeperateRatio: CGFloat = 0.9
    private let yHeightRatio: CGFloat = 0.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        for subView in subviews {
            subView.removeFromSuperview()
        }
        setupElectrodeView()
        setupBodyView()
    }
    
    func updateBatteryLevel(color: UIColor, value: Double) {
        setBGGrandent(for: bodyView, value: value, leftColor: color, rightColor: .clear)
    }
    
    private func setupElectrodeView() {
        let size = bounds.size
        let electrodeViewPtx    = size.width * xSeperateRatio
        let electrodeViewWidth  = (size.width - electrodeViewPtx)
        let electrodeViewHeight = size.height * yHeightRatio
        let electrodeViewPty    = (size.height - electrodeViewHeight) / 2// (a - 0.9a)/2
        
        electrodeView = UIView(frame: CGRect(x: electrodeViewPtx,
                                             y: electrodeViewPty,
                                             width: electrodeViewWidth,
                                             height: electrodeViewHeight))
        
        setBGGrandent(for: electrodeView, value: 0.5, leftColor: .clear, rightColor: .white)
        electrodeView?.cornerRadius = 2.5
        electrodeView?.layer.masksToBounds = true
        
        self.addSubview(electrodeView!)
    }
    
    private func setupBodyView() {
        let size = bounds.size
        let bodyViewPtx: CGFloat    = 0
        let bodyViewWidth           = size.width * xSeperateRatio
        let bodyViewPty: CGFloat    = 0
        let bodyViewHeight          = size.height
        
        bodyView = UIView(frame: CGRect(x: bodyViewPtx,
                                        y: bodyViewPty,
                                        width: bodyViewWidth,
                                        height: bodyViewHeight))
        
        bodyView?.borderColor = .white
        bodyView?.borderWidth = 0.5
        bodyView?.cornerRadius = 1.5
        bodyView?.layer.masksToBounds = true
        
        self.addSubview(bodyView!)
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
