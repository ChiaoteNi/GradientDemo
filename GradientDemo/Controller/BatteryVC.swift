//
//  ViewController.swift
//  GradientDemo
//
//  Created by Chiao-Te Ni on 2018/5/19.
//  Copyright © 2018年 aaron. All rights reserved.
//

import UIKit

class BatteryVC: UIViewController {

    @IBOutlet weak var batteryView: BatteryView!
    @IBOutlet weak var blurBatteryView: BlurBatteryView!
    @IBOutlet weak var slider: UISlider!
    
    private var lastValue: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .black
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
            batteryView.updateBatteryLevel(color: UIColor.green, value: value)
            blurBatteryView.updateBatteryLevel(color: UIColor.green, value: value)
        } else {
            batteryView.updateBatteryLevel(color: UIColor.red, value: value)
            blurBatteryView.updateBatteryLevel(color: UIColor.red, value: value)
        }
        lastValue = value
    }
    
    @objc private func sliderDidEndSliding() {
        batteryView.updateBatteryLevel(color: UIColor.white, value: lastValue)
        if lastValue > 0.2 {
            blurBatteryView.updateBatteryLevel(color: UIColor.green, value: lastValue)
        } else if lastValue > 0.1 {
            blurBatteryView.updateBatteryLevel(color: UIColor.yellow, value: lastValue)
        } else {
            blurBatteryView.updateBatteryLevel(color: UIColor.red, value: lastValue)
        }
    }
}

