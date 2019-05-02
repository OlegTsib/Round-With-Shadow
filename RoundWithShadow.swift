//
//  RoundWithShadow.swift
//
//  Created by Oleg Tsibulevsky on 02/05/2019.
//  Copyright © 2019 OT Development. All rights reserved.
//

import UIKit

class RoundWithShadow: UIView
{
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
    
    convenience override init(frame: CGRect)
    {
        self.init(.frame(frame))
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        borderWidth  = CGFloat(aDecoder.decodeDouble(forKey: CoderKeys.borderWidth .description))
        cornerRadius = CGFloat(aDecoder.decodeDouble(forKey: CoderKeys.cornerRadius.description))
        borderColor  = UIColor(coder: aDecoder) ?? UIColor.clear
        circleView   = aDecoder.decodeBool(forKey: CoderKeys.circleView.description)
        shadowActive = aDecoder.decodeBool(forKey: CoderKeys.shadowActive.description)
        shadowColor  = UIColor(coder: aDecoder) ?? UIColor.clear
    }
    
    override func encode(with aCoder: NSCoder)
    {
        aCoder.encode(borderWidth , forKey: CoderKeys.borderWidth .description)
        aCoder.encode(cornerRadius, forKey: CoderKeys.cornerRadius.description)
        aCoder.encode(borderColor , forKey: CoderKeys.borderColor .description)
        aCoder.encode(shadowColor , forKey: CoderKeys.shadowColor .description)
        aCoder.encode(circleView  , forKey: CoderKeys.circleView  .description)
        aCoder.encode(shadowActive, forKey: CoderKeys.shadowActive.description)
        super.encode(with: aCoder)
    }
    
    private init(_ initMethod: InitMethod)
    {
        switch initMethod
        {
        case let .coder(coder): super.init(coder: coder)!
        case let .frame(frame): super.init(frame: frame)
        }
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
        self.layer.masksToBounds = false
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        
        if shadowActive
        {
            let shapeLayer = CAShapeLayer()
            
            shapeLayer.cornerRadius    = self.layer.cornerRadius
            shapeLayer.frame           = bounds
            shapeLayer.masksToBounds   = false
            shapeLayer.shadowColor     = self.shadowColor.cgColor
            shapeLayer.shadowOffset    = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
            shapeLayer.shadowOpacity   = self.shadowOpacity
            shapeLayer.backgroundColor = self.backgroundColor?.cgColor
            shapeLayer.shadowRadius    = self.shadowRadius
            
            self.layer.addSublayer(shapeLayer)
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
