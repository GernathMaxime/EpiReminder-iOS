//
//  RoundButton.swift
//  Ayomi
//
//  Created by Maxime Gernath on 10/07/2018.
//  Copyright © 2018 Ayomi. All rights reserved.
//

import UIKit

//@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var startColor: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    @IBInspectable var endColor: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    @IBInspectable var fillcolor: UIColor = UIColor.clear
    @IBInspectable var radius: Int = 2
    @IBInspectable var rounded: Bool = false
    @IBInspectable var ghost: Bool = false
    @IBInspectable var lineWidth: Int = 2

    override func draw(_ rect: CGRect) {
        if ghost == true {
            let gradient = CAGradientLayer()
            gradient.frame =  CGRect(origin: CGPoint.zero, size: layer.frame.size)
            gradient.colors = [startColor.cgColor, endColor.cgColor]
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)

            let shape = CAShapeLayer()
            shape.lineWidth = CGFloat(lineWidth)
            if rounded == true {
                shape.path = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: lineWidth, y: lineWidth), size: CGSize(width: layer.frame.size.width - CGFloat(lineWidth * 2), height: layer.frame.size.height - CGFloat(lineWidth * 2))), cornerRadius: bounds.width/2).cgPath
            } else {
                shape.path = UIBezierPath(rect: CGRect(origin: CGPoint(x: lineWidth, y: lineWidth), size: CGSize(width: layer.frame.size.width - CGFloat(lineWidth * 2), height: layer.frame.size.height - CGFloat(lineWidth * 2)))).cgPath
            }
            shape.strokeColor = UIColor.white.cgColor
            shape.fillColor = fillcolor.cgColor
            gradient.mask = shape

            layer.addSublayer(gradient)
        } else if rounded == true {
            layer.cornerRadius = frame.size.height / CGFloat(radius)
            layer.masksToBounds = true
        }
    }
}
