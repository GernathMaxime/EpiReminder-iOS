//
//  LDGradientView.swift
//  Ayomi
//
//  Created by Maxime Gernath on 13/07/2018.
//  Copyright © 2018 Ayomi. All rights reserved.
//

import UIKit

//@IBDesignable
class LDGradientView: UIView {

    @IBInspectable var startColor: UIColor = UIColor(red: 4/255, green: 39/255, blue: 105/255, alpha: 1)
    @IBInspectable var endColor: UIColor = UIColor(red: 1/255, green: 91/255, blue: 168/255, alpha: 1)
    @IBInspectable var Rounded: Bool = false

    override func draw(_ rect: CGRect) {

        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        let colorLocations: [CGFloat] = [0.0, 1.0]

        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!

        let startPoint = CGPoint(x: 0, y: 0.0)
        let endPoint = CGPoint(x: 0.0, y: bounds.height)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
        if Rounded == true {
            layer.cornerRadius = CGFloat(10)
            layer.masksToBounds = true
        }
    }
}
