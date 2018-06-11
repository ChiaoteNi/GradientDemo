//
//  MaskVC.swift
//  GradientDemo
//
//  Created by Chiao-Te Ni on 2018/6/3.
//  Copyright © 2018年 aaron. All rights reserved.
//

import UIKit

class MaskVC: BaseDemoVC {

    @IBOutlet weak var topImgView: UIImageView!
    @IBOutlet weak var bottomImgView: UIImageView!
    
    @IBOutlet weak var tvContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var topImgMaskLayer = CAGradientLayer()
    private var tvMaskLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundImage(with: #imageLiteral(resourceName: "icu9yIJ"), backgroundColor: .black)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: TVCell.self)
        
        topImgView.image = #imageLiteral(resourceName: "TopImg")
        topImgView.contentMode = .scaleToFill
        bottomImgView.image = #imageLiteral(resourceName: "BottomImg")
        bottomImgView.contentMode = .scaleToFill
        
        topImgMaskLayer.colors = [UIColor.clear.cgColor,
                                  UIColor.black.cgColor]
        topImgMaskLayer.locations = [0, 0, 1]
        
        tvMaskLayer.colors = [UIColor.clear.cgColor,
                              UIColor.black.cgColor,
                              UIColor.black.cgColor,
                              UIColor.clear.cgColor]
        tvMaskLayer.locations = [0, 0, 1]
        
        let imgView = UIImageView(image: #imageLiteral(resourceName: "maskImg"))
        imgView.frame = topImgView.frame
        topImgView.mask = imgView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        changeTableViewMaskLayer(to: sender.value)
        changeTopImgMaskLayer(to: sender.value)
    }
    
    private func changeTopImgMaskLayer(to value: Float) {
        topImgMaskLayer.frame = topImgView.bounds
        topImgView.layer.mask = topImgMaskLayer
        
        let spec: Float = 0.1
        
        if value >= spec {
            changeMask(topImgMaskLayer, withLocateion: [value - spec, value, 1])
        } else {
            changeMask(topImgMaskLayer, withLocateion: [value - spec, value, 1])
        }
    }
    
    private func changeTableViewMaskLayer(to value: Float) {
        tvMaskLayer.frame = tvContainerView.bounds
        tvContainerView.layer.mask = tvMaskLayer

        let value = value / 2
        let spec: Float = 0.1
        
        if value >= spec {
            changeMask(tvMaskLayer, withLocateion: [value - spec,
                                                    value, 1 - value,
                                                    1 - spec])
        } else {
            changeMask(tvMaskLayer, withLocateion: [0, value, 1 - value, 1])
        }
    }
    
    private func changeMask(_ maskLayer: CAGradientLayer, withLocateion location: [Float]) {
        let locations = location.map { NSNumber(value: $0) }
        maskLayer.locations = locations
    }
}

extension MaskVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(with: TVCell.self, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
