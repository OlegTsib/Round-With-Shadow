//
//  RoundWithShadow.swift
//
//  Created by Oleg Tsibulevsky on 02/05/2019.
//  Copyright © 2019 OT Development. All rights reserved.
//

import UIKit

class RoundWithShadow: UIView
{
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

        setCornersRadius(self)
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth

        if shadowActive
        {
            self.layer.shadowColor     = self.shadowColor.cgColor
            self.layer.shadowOffset    = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
            self.layer.shadowOpacity   = self.shadowOpacity
            self.layer.shadowRadius    = self.shadowRadius
        }
        
        self.subviews.forEach { (subView) in
            
            if let container = subView as? RoundWithShadowContainerView
            {
                setCornersRadius(container, masksToBounds: true)
                return
            }
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
    
    private func setCornersRadius(_ view: UIView, masksToBounds: Bool = false)
    {
        if circleView
        {
            view.layer.cornerRadius = frame.height / 2
        }
        else
        {
            view.layer.cornerRadius = cornerRadius
        }
        
        view.layer.masksToBounds = masksToBounds
    }
}
