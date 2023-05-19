//
//  CircularSliderView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 16.05.2023.
//

import UIKit
import MTCircularSlider

class CircularSliderView: NibDesignable {
    
    // MARK: -
    // MARK: Outlets

    @IBOutlet var slider: MTCircularSlider?
    
    // MARK: -
    // MARK: Variables
    
    var thumbLabel = UILabel()
    var labelValue = 0
    
    // MARK: -
    // MARK: Public

    public func prepareSlider(value: Int) {
        self.labelValue = value
        self.slider?.valueMaximum = 300
        self.slider?.valueMinimum = 0
        self.slider?.value = CGFloat(Double(self.labelValue))
        self.slider?.isUserInteractionEnabled = false
        self.slider?.applyAttributes(
            [
                /* Track */
                Attributes.trackWidth(7),

                /* Thumb */
                Attributes.hasThumb(true),
                Attributes.thumbRadius(15.5),
                Attributes.thumbShadowRadius(0),
                Attributes.thumbShadowDepth(0)
            ]
        )
    }
    
    // MARK: -
    // MARK: Private
    
    private func configureLabel() {
        self.thumbLabel.text = self.labelValue.description
        self.thumbLabel.font = Fonts.PlusJakartaSans.medium.font(size: 15)
        self.thumbLabel.textColor = .black
        self.thumbLabel.center = self.slider?.thumbCenter ?? CGPoint()
        self.addSubview(self.thumbLabel)
        self.thumbLabel.sizeToFit()
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.configureLabel()
    }
    
    override func draw(_ rect: CGRect) {
        
        let center: CGPoint = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        var trackRadius = (self.slider?.outerControlRadius ?? 0) - 4
        let circlePath = UIBezierPath(arcCenter: center, radius: trackRadius ?? CGFloat(), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
            
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
            
        // Change the fill color
        shapeLayer.fillColor = UIColor.clear.cgColor
        // You can change the stroke color
        var color = Colors.Colors.wildSand.color.withAlphaComponent(0.5)
    
        shapeLayer.strokeColor = color.cgColor
        
        // You can change the line width
        shapeLayer.lineWidth = 11.0
            
        self.layer.insertSublayer(shapeLayer, at: 0)
    }
}
