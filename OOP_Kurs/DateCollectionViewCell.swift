//
//  DateCollectionViewCell.swift
//  OOP_Kurs
//
//  Created by Ilya Kangin on 10/13/19.
//  Copyright © 2019 Ilya Kangin. All rights reserved.
//

import UIKit

@IBDesignable

class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var Rectangle: UIView!
    
    
    func frameAppear() {
        let pathRect = CGRect(x: 6.5, y: 1, width: 28, height: 28)
        
        let path = UIBezierPath(roundedRect: pathRect, cornerRadius: 5)
        
        
        
        let rectLayer = CAShapeLayer()
        rectLayer.path = path.cgPath
        rectLayer.strokeColor = UIColor.systemGreen.cgColor
        rectLayer.lineWidth = 2
//        rectLayer.strokeEnd = 0
        rectLayer.fillColor = UIColor.clear.cgColor
        
        Rectangle.layer.addSublayer(rectLayer)
        Rectangle.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    func eventFrameAppear() {
            let pathRect = CGRect(x: 6.5, y: 1, width: 28, height: 28)
            
            let path = UIBezierPath(roundedRect: pathRect, cornerRadius: 5)
            
            
            
            let rectLayer = CAShapeLayer()
            rectLayer.path = path.cgPath
            rectLayer.strokeColor = UIColor.systemPurple.cgColor
            rectLayer.lineWidth = 2
    //        rectLayer.strokeEnd = 0
            rectLayer.fillColor = UIColor.clear.cgColor
            
            Rectangle.layer.addSublayer(rectLayer)
            Rectangle.layer.backgroundColor = UIColor.clear.cgColor
        }
    
    func rectangleAppear() {

        
        let pathRect = CGRect(x: 5.5, y: 0, width: 30, height: 30)
        
        let path = UIBezierPath(roundedRect: pathRect, cornerRadius: 5)
        
        let rectLayer = CAShapeLayer()
        rectLayer.path = path.cgPath
        rectLayer.fillColor = UIColor.systemGreen.cgColor
        
        Rectangle.layer.addSublayer(rectLayer)
        
    }
    
    
}
