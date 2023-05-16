//
//  PokemonView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit
import MTCircularSlider

final class PokemonView: BaseView {
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet var collectionView: UICollectionView?
    @IBOutlet var circularSliderContainer: UIView!
    @IBOutlet var imageBackgroundView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var infoContainer: UIView!
    
    var slider: MTCircularSlider!
    
    // MARK: -
    // MARK: Public
    
    public func configure() {
        self.imageBackgroundView.setNeedsLayout()
        self.imageBackgroundView.layoutIfNeeded()
        self.imageBackgroundView.layer.cornerRadius = self.imageBackgroundView.frame.width / 2
        self.infoContainer.layer.cornerRadius = 24
        self.flowLayoutConfigure()
    }
    
    public func set(image: UIImage, text: String) {
        self.imageView?.image = image
        self.backgroundColor = image.getColors().background
    }
    
    public func prepareSlider(model: Pokemon) {
        let action = UIAction(handler: self.someHandler(_ :))
        self.slider = MTCircularSlider(frame: self.circularSliderContainer.bounds, primaryAction: action)
        self.slider.valueMaximum = 255
        self.slider.valueMinimum = 0
        self.slider.value = CGFloat(Double(model.baseExperience ?? 0))
        self.slider.applyAttributes(
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
        self.slider.isUserInteractionEnabled = false
        self.circularSliderContainer.addSubview(self.slider)
    }
    
    func flowLayoutConfigure() {
        let itemWidth = self.collectionView?.frame.size.width
        let itemHeight = self.collectionView?.frame.size.height
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (itemWidth ?? 0) - 48, height: 127)
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        self.collectionView?.collectionViewLayout = layout
        self.collectionView?.isPagingEnabled = false
        self.collectionView?.alwaysBounceVertical = true
    }
    
    @objc func someHandler(_ : UIAction) {
        return
    }
}
