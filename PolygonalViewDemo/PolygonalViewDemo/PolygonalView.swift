//
//  PolygonalView.swift
//  PolygonalViewDemo
//
//  Created by Alexandre Brispot on 18/12/14.
//  Copyright (c) 2014 KiwiMobile. All rights reserved.
//

import UIKit

@IBDesignable class PolygonalView: UIView {
    
    @IBInspectable var sideNumber: Int = 4 {
        didSet {
            drawShape()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            drawShape()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 3 {
        didSet {
            drawShape()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            drawShape()
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawShape()
    }
    
    func drawShape() {
        var shapePath = UIBezierPath()
        let theta = CGFloat(2.0 * M_PI / Double(sideNumber))
        let offset = CGFloat(Float(cornerRadius) * tanf(Float(theta) / 2.0))
        let squareWidth = min(frame.height, frame.width)
        var length = squareWidth - CGFloat(borderWidth)
        if sideNumber < 4 { //We make an axecption for the triangle so it's not too large
            length /= 1.5
        }
        let sideLength = length * CGFloat(tanf(Float(theta) / 2.0))
        var point = CGPointMake(squareWidth / 2.0 + sideLength / 2.0 - offset, squareWidth - (squareWidth - length) / 2.0)
        var angle = CGFloat(M_PI)
        shapePath.moveToPoint(point)
        
        for var side = 0 ; side < sideNumber ; ++side {
            point = CGPointMake(CGFloat(point.x) + (sideLength - offset * 2.0) * CGFloat(cosf(Float(angle))), CGFloat(point.y) + (sideLength - offset * 2.0) * CGFloat(sinf(Float(angle))))
            shapePath.addLineToPoint(point)
            let center = CGPointMake(CGFloat(point.x) + CGFloat(cornerRadius) * CGFloat(cosf(Float(angle) + Float(M_PI_2))), CGFloat(point.y) + CGFloat(cornerRadius) * CGFloat(sinf(Float(angle) + Float(M_PI_2))))
            shapePath.addArcWithCenter(center, radius: CGFloat(cornerRadius), startAngle: angle - CGFloat(M_PI_2), endAngle: angle + theta - CGFloat(M_PI_2), clockwise: true)
            point = shapePath.currentPoint
            angle += theta
        }
        shapePath.closePath()
        
        let mask = CAShapeLayer()
        mask.path = shapePath.CGPath
        mask.lineWidth = borderWidth
        mask.strokeColor = UIColor.clearColor().CGColor
        mask.fillColor = UIColor.whiteColor().CGColor
        layer.mask = mask
        
        let border = CAShapeLayer()
        border.path = shapePath.CGPath
        border.lineWidth = borderWidth;
        border.strokeColor = borderColor.CGColor;
        border.fillColor = UIColor.clearColor().CGColor;
        layer.addSublayer(border)
    }
}
