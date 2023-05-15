//
//  PokemonView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit

final class PokemonView: BaseView {
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet var collectionView: UICollectionView?
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
        let action = UIAction(handler: self.someHandler(_ :))
        self.slider = MTCircularSlider(frame: self.imageView.bounds, primaryAction: action)
//        self.slider?.addTarget(self, action: Selector("valueChange:"), forControlEvents: .ValueChanged)
        self.imageView.addSubview(self.slider)
    }
    
    public func set(image: UIImage, text: String) {
        self.imageView?.image = image
        self.backgroundColor = image.getColors().background
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
