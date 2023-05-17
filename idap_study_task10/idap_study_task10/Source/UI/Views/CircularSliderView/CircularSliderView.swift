//
//  CircularSliderView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 16.05.2023.
//

import UIKit
import MTCircularSlider

class CircularSliderView: NibDesignable {

    @IBOutlet var slider: MTCircularSlider?

    public func prepareSlider(value: Int) {
        self.slider?.valueMaximum = 255
        self.slider?.valueMinimum = 0
        self.slider?.value = CGFloat(Double(value))
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
}
