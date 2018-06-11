//
//  Extension + Array.swift
//  GradientDemo
//
//  Created by Chiao-Te Ni on 2018/6/5.
//  Copyright © 2018年 aaron. All rights reserved.
//

import Foundation

extension Array {
    
    typealias E = Element
    
    subscript(safe index: Int) -> E? {
        guard index >= 0, index < self.count else { return nil }
        let element = self[index]
        return element
    }
}
