//
//  Extension + NSObject.swift
//  comic
//
//  Created by Chiao-Te Ni on 2017/12/7.
//  Copyright © 2017年 Appimc. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
    
    /// 除錯用, 方便以後統一改成crash統計
    ///
    /// - Parameters:
    ///   - type: print種類 - error/warning/debug
    ///   - msg: 錯誤訊息
    func printDebug(_ type: PrintType, _ msg:String, funcName: String = #function) {
        //        NSObject.printDebug(type, msg, withFuncName: withFuncName, funcName: funcName)
        let msg = type.rawValue + ": \(className)->\(funcName), " + msg
        #if DEBUG && true
        print(msg)
        #else
        guard type != .debug else { return }
        ErrorInfoHandler.crashReport(msg)
        
        guard type == .cryptErr else { return }
        RealtimeDBDebugHelper.share.setLog(msg)
        #endif
    }
    
    /// 除錯用, 方便以後統一改成crash統計
    ///
    /// - Parameters:
    ///   - type: print種類 - error/warning/debug
    ///   - msg: 錯誤訊息
    static func printDebug(_ type: PrintType, _ msg:String, funcName: String = #function) {
        let msg = type.rawValue + ": \(className)->\(funcName), " + msg
        #if DEBUG && true
        print(msg)
        #else
        guard type != .debug else { return }
        ErrorInfoHandler.crashReport(msg)
        
        guard type == .cryptErr else { return }
        RealtimeDBDebugHelper.share.setLog(msg)
        #endif
    }
    
    func instanceVCfromSB(storyboardName: String, viewControllerID: String) -> UIViewController? {
        let sb = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: viewControllerID)
        return vc
    }
    
    static func instanceVCfromSB(storyboardName: String, viewControllerID: String) -> UIViewController? {
        let sb = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: viewControllerID)
        return vc
    }
}

enum PrintType: String {
    case error      = "ERROR"
    case warning    = "WARNING"
    case debug      = "DEBUG"
    case note       = "NOTE"
    case cryptErr   = "CryptError"
}
