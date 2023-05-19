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
    @IBOutlet var circularSliderView: CircularSliderView?
    @IBOutlet var imageBackgroundView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var infoContainer: UIView!
    
    // MARK: -
    // MARK: Public
    
    public func configure() {
        self.infoContainer.layer.cornerRadius = 24
        self.flowLayoutConfigure()
    }
    
    public func set(image: UIImage, text: String) {
        self.imageView?.image = image
        self.prepareGradient(with: image.getColors().background)
    }
    
    func configureSlider(model: Pokemon) {
        self.circularSliderView?.prepareSlider(value: model.baseExperience ?? 0)
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
    
    // MARK: -
    // MARK: Private
    
    private func prepareGradient(with color: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.cornerRadius = 10
        gradientLayer.frame = self.bounds
        gradientLayer.locations = [0.0, 0.5]
        gradientLayer.colors = [color.withAlphaComponent(0.5).cgColor, color.cgColor]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageBackgroundView.layer.cornerRadius = self.imageBackgroundView.frame.width / 2
    }
}
