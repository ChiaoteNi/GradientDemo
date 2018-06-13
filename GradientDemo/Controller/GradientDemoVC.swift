//
//  GradientDemoVC.swift
//  GradientDemo
//
//  Created by Chiao-Te Ni on 2018/6/5.
//  Copyright © 2018年 aaron. All rights reserved.
//

import UIKit

class GradientDemoVC: BaseDemoVC {

    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var demoView: UIView!
    @IBOutlet var colorSliders: [UISlider]!
    @IBOutlet var locationSliders: [UISlider]!
    
    private var gradientLayer = CAGradientLayer()
    
    private var initColors: [CGColor] = [UIColor.blue.cgColor,
                                         UIColor.red.cgColor,
                                         UIColor.yellow.cgColor]
    
    private var colorSource: [UIColor] = [UIColor.red,
                                          UIColor.green,
                                          UIColor.blue,
                                          UIColor.yellow,
                                          UIColor.black.withAlphaComponent(0),
                                          UIColor.white.withAlphaComponent(0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer.colors        = initColors
        gradientLayer.locations     = [0.3, 0.6, 0.9]
        gradientLayer.startPoint    = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint      = CGPoint(x: 1, y: 1)
        demoView.layer.addSublayer(gradientLayer)
        
        for slider in colorSliders {
            slider.maximumValue = Float(colorSource.count - 1)
            slider.minimumValue = 0
        }
        resetGradient()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = demoView.bounds
    }
    
    @IBAction func strEndPtValueChanged(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            gradientLayer.startPoint.x = CGFloat(sender.value)
        case 1:
            gradientLayer.startPoint.y = CGFloat(sender.value)
        case 2:
            gradientLayer.endPoint.x = CGFloat(sender.value)
        case 3:
            gradientLayer.endPoint.y = CGFloat(sender.value)
        default:
            break
        }
    }
    
    @IBAction func locationValueChanged(_ sender: UISlider) {
        let index = sender.tag
        
        guard let locations = gradientLayer.locations else { return }
        guard index < locations.count, index >= 0 else { return }
        
        gradientLayer.locations?[index] = NSNumber(value: sender.value)
    }
    
    @IBAction func colorValueChanged(_ sender: UISlider) {
        let index = sender.tag
        sender.value = roundf(sender.value)
        
        guard let colors = gradientLayer.colors else { return }
        guard index < colors.count, index >= 0 else { return }
        
        let color = colorSource[safe: Int(sender.value)] ?? UIColor.brown
        gradientLayer.colors?[index] = color.cgColor
        
        sender.thumbTintColor = color
    }
    
    @IBAction func resetColorBtnPressed(_ sender: Any) {
        resetGradient()
    }
    
    private func resetGradient() {
        resetColors()
        resetLocations()
    }
    
    private func resetColors() {
        for slider in colorSliders {
            switch slider.tag {
            case 0:
                slider.value = 2
            case 1:
                slider.value = 0
            case 2:
                slider.value = 3
            default:
                continue
            }
            colorValueChanged(slider)
        }
    }
    
    private func resetLocations() {
        for slider in locationSliders {
            switch slider.tag {
            case 0:
                slider.value = 0.3
            case 1:
                slider.value = 0.6
            case 2:
                slider.value = 0.9
            default:
                continue
            }
            locationValueChanged(slider)
        }
    }
}
