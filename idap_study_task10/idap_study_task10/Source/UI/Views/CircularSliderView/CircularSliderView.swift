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
 
    var labelValue = 0
    var thumbLabel = UILabel()
    var labelBackground = UIView()
    
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
                Attributes.thumbShadowDepth(0),
            ]
        )
    }
    
    // MARK: -
    // MARK: Private
    
    private func configureLabel() {
        let center = self.slider?.thumbCenter ?? CGPoint()
        self.prepareLabelBackground(with: center)
        self.prepareThumbLabel(with: center)
        self.prepareProgressPath()
    }
    
    private func prepareLabelBackground(with point: CGPoint) {
        self.labelBackground.frame = CGRect(origin: point, size: CGSize(width: 31, height: 31))
        self.labelBackground.layer.cornerRadius = 15.5
        self.labelBackground.backgroundColor = .white
        self.labelBackground.center = point
        self.insertSubview(self.labelBackground, at: 3)
        self.labelBackground.layer.insertSublayer(self.configureGradient(), at: 0)
    }
    
    private func prepareThumbLabel(with point: CGPoint) {
        self.thumbLabel.text = self.labelValue.description
        self.thumbLabel.font = Fonts.PlusJakartaSans.medium.font(size: 15)
        self.thumbLabel.textColor = .white
        self.thumbLabel.center = point
        self.addSubview(self.thumbLabel)
        self.thumbLabel.sizeToFit()
    }
    
    private func prepareProgressPath() {
        let newGradient = CAGradientLayer()
        newGradient.frame = self.bounds
        newGradient.locations = [0.0, 0.9]
        newGradient.startPoint = CGPoint(x: 0, y: 0)
        newGradient.endPoint = CGPoint(x: 1, y: 1)
        newGradient.colors = [UIColor.green.cgColor, UIColor.blue.cgColor]
        let shapeMask = CAShapeLayer()
        shapeMask.path = self.slider?.progressPath?.cgPath
        newGradient.mask = shapeMask
        self.layer.insertSublayer(newGradient, at: 3)
    }
    
    private func configureGradient() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.labelBackground.bounds
        gradientLayer.locations = [0.0, 0.9]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.colors = [UIColor.green.cgColor, UIColor.blue.cgColor]
        gradientLayer.cornerRadius = 15
        
        return gradientLayer
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.configureLabel()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let center: CGPoint = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        let trackRadius = (self.slider?.outerControlRadius ?? 0) - 4
        let circlePath = UIBezierPath(arcCenter: center, radius: trackRadius, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        let color = Colors.Colors.wildSand.color.withAlphaComponent(0.5)
        shapeLayer.lineWidth = 11.0
        shapeLayer.path = circlePath.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.layer.insertSublayer(shapeLayer, at: 0)
    }
}
