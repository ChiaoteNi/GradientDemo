//
//  TVCell.swift
//  GradientDemo
//
//  Created by Chiao-Te Ni on 2018/6/3.
//  Copyright © 2018年 aaron. All rights reserved.
//

import UIKit

class TVCell: UITableViewCell {

    @IBOutlet private weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = 15
        bgView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
