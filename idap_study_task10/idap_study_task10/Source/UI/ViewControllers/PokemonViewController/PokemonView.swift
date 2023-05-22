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
    @IBOutlet var imageBackgroundView: UIView?
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var infoContainer: UIView?
    
    // MARK: -
    // MARK: Variables
    
    var image: UIImage?
    
    // MARK: -
    // MARK: Public
    
    public func configure() {
        self.infoContainer?.layer.cornerRadius = 24
        self.flowLayoutConfigure()
    }
    
    public func set(image: UIImage, text: String) {
        self.image = image
        self.imageView?.image = image
    }
    
    func configureSlider(model: Pokemon) {
        self.circularSliderView?.prepareSlider(value: model.baseExperience ?? 0)
    }
    
    func flowLayoutConfigure() {
        let itemWidth = (self.collectionView?.frame.size.width ?? 0) - 48
        let itemHeight = self.collectionView?.frame.size.height
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: 127)
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
        gradientLayer.cornerRadius = 0
        gradientLayer.frame = self.frame
        gradientLayer.locations = [0.0, 0.5]
        gradientLayer.colors = [color.withAlphaComponent(0.2).cgColor, color.cgColor]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.collectionView?.layer.cornerRadius = 24
        self.prepareGradient(with: self.image?.getColors().background ?? .clear)
        self.imageBackgroundView?.layer.cornerRadius = (self.imageBackgroundView?.frame.width ?? 0) / 2
    }
}
