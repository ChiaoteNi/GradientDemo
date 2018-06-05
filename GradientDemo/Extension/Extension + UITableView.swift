//
//  Extension + UITableView.swift
//  comic
//
//  Created by Chiao-Te Ni on 2017/12/7.
//  Copyright © 2017年 Appimc. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(cellType: T.Type) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func register<T: UITableViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T
    }
    
    func getCell <T: UITableViewCell> (with type:T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(with: type, for: indexPath) else {
            return T()
        }
        return cell
    }
}

