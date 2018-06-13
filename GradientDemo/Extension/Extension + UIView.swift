//
//  Extension + UIView + UINib.swift
//  comic
//
//  Created by Chiao-Te Ni on 2017/12/7.
//  Copyright © 2017年 Appimc. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    func getSubView<T: UIView>(subviewClass: T.Type) -> T? {
        guard self.subviews.isEmpty == false else{
            printDebug(.debug, "getSubView, but \(self.className).subViews is empty.")
            return nil
        }
        for subView in self.subviews {
            if subView.isKind(of: subviewClass){
                return subView as? T
            }
        }
        printDebug(.debug, "getSubView, but \(self.className).subViews targetClass subview doesn't exist.")
        return nil
    }
    
}

// MARK: - 設定背景色
public extension UIView {
    
    /// 用Graphic晶片將img當color畫到View上 （因為抓frame, 要放在layout完成之後）
    ///
    /// - Parameters:
    ///   - img: img source
    ///   - type: 佈滿模式
    ///   - backgroundColor: 圖片以外的底色
    public func setBackgroundImage(with img: UIImage, withContentType type: BgImgContentMode = .fill, backgroundColor: UIColor) {
        UIGraphicsBeginImageContext(self.bounds.size)
        // 畫底色
        backgroundColor.setFill()
        UIRectFill(self.bounds)
        // 上圖
        let viewSize = bounds.size
        let imgSize = img.size
        let drawRect: CGRect
        
        switch type {
        case .top:
            let width = viewSize.width
            let height = imgSize.height / viewSize.width * imgSize.width
            drawRect = CGRect(x: 0, y: 0, width: width, height: height)
        case .center:
            let x = (viewSize.width - imgSize.width) / 2
            let y = (viewSize.height - imgSize.height) / 2
            drawRect = CGRect(x: x, y: y, width: viewSize.width, height: imgSize.height)
        case .bottom:
            let x = viewSize.width - imgSize.width
            let y = viewSize.height - imgSize.height
            drawRect = CGRect(x: x, y: y, width: viewSize.width, height: imgSize.height)
        case .fill:
            drawRect = self.bounds
        case .aspectFill:
            let widthRatio = viewSize.width / imgSize.width
            let heightRatio = viewSize.height / imgSize.height
            let resizeRatio = max(widthRatio, heightRatio)
            
            let width = imgSize.width * resizeRatio
            let height = imgSize.height * resizeRatio
            let x = (viewSize.width - width) / 2
            let y = (viewSize.height - height) / 2
            
            drawRect = CGRect(x: x, y: y, width: width, height: height)
        }
        img.draw(in: drawRect)
        
        // 將結果輸出
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let image = newImage else { return }
        self.backgroundColor = UIColor(patternImage: image)
    }
    
     enum BgImgContentMode {
        case top
        case center
        case bottom
        case fill
        case aspectFill
    }
}

// MARK: - LoadNib

public extension UINib {
    public class func load(nibName name: String, bundle: Bundle? = nil) -> Any? {
        return UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil, options: nil).first
    }
    
    public class func loadView<T: UIView>(class: T.Type) -> T?  {
        let nibName = T.className
        return load(nibName: nibName) as? T
    }
}
