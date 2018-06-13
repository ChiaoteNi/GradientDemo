//
//  ViewController.swift
//  GradientDemo
//
//  Created by Chiao-Te Ni on 2018/5/19.
//  Copyright © 2018年 aaron. All rights reserved.
//

import UIKit

class BatteryVC: BaseDemoVC {

    @IBOutlet weak var batteryView: BatteryView!
    @IBOutlet weak var blurBatteryView: BlurBatteryView!
    @IBOutlet weak var statusBatteryView: BatteryView!
    @IBOutlet weak var slider: UISlider!
    
    private var lastValue: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setBackgroundImage(with: #imageLiteral(resourceName: "batteryDemoBG"), withContentType: .aspectFill, backgroundColor: .black)
        slider.addTarget(self, action: #selector(sliderDidEndSliding), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let value = Double(sender.value)
        if value > lastValue || sender.value == sender.maximumValue {
            batteryView.updateBatteryLevel(color: .green, value: value)
            statusBatteryView.updateBatteryLevel(color: .green, value: value)
            blurBatteryView.updateBatteryLevel(color: .green, value: value)
        } else {
            batteryView.updateBatteryLevel(color: .red, value: value)
            statusBatteryView.updateBatteryLevel(color: .red, value: value)
            blurBatteryView.updateBatteryLevel(color: .red, value: value)
        }
        lastValue = value
    }
    
    @objc private func sliderDidEndSliding() {
        batteryView.updateBatteryLevel(color: .white, value: lastValue)
        if lastValue > 0.2 {
            blurBatteryView.updateBatteryLevel(color: .green, value: lastValue)
        } else if lastValue > 0.1 {
            blurBatteryView.updateBatteryLevel(color: .yellow, value: lastValue)
        } else {
            blurBatteryView.updateBatteryLevel(color: .red, value: lastValue)
        }
    }
}

