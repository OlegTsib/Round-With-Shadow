//
//  RoundWithShadow.swift
//
//  Created by Oleg Tsibulevsky on 02/05/2019.
//  Copyright © 2019 OT Development. All rights reserved.
//

import UIKit

class RoundWithShadow: UIView
{
    private let shapeLayer = CAShapeLayer()
    
    // MARK: Inspectable properties
    private enum CoderKeys : String , CustomStringConvertible
    {
        case borderWidth
        case borderColor
        case cornerRadius
        case circleView
        case shadowActive
        case shadowColor
        var description: String { return rawValue }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var circleView: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowActive: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 2.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.black.withAlphaComponent(0.5) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowOffsetWidth: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var shadowOffsetHeight: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    // MARK: - Initialization
    private enum InitMethod
    {
        case coder(NSCoder)
        case frame(CGRect)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()

        if circleView
        {
           self.layer.cornerRadius = frame.height / 2
        }
        else
        {
            self.layer.cornerRadius = cornerRadius
        }
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth

        if shadowActive
        {
            shapeLayer.removeFromSuperlayer()
            
            shapeLayer.cornerRadius    = self.layer.cornerRadius
            shapeLayer.frame           = bounds
            shapeLayer.shadowColor     = self.shadowColor.cgColor
            shapeLayer.shadowOffset    = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
            shapeLayer.shadowOpacity   = self.shadowOpacity
            shapeLayer.backgroundColor = self.backgroundColor?.cgColor
            shapeLayer.shadowRadius    = self.shadowRadius
            
            self.layer.insertSublayer(shapeLayer, above: self.layer)
            
        }
        
        for i in self.subviews
        {
            if circleView
            {
                i.layer.cornerRadius = frame.height / 2
            }
            else
            {
                i.layer.cornerRadius = cornerRadius
            }
            
            i.layer.masksToBounds = true
            
            self.insertSubview(i, aboveSubview: self)
        }
    }
    
    override func prepareForInterfaceBuilder()
    {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    // Setup the view appearance
    private func setupView()
    {
        self.setNeedsDisplay()
    }
}
