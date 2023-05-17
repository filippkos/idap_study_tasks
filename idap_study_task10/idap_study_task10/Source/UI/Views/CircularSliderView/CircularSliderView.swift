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
        self.slider?.valueMaximum = 255
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
}
