//
//  PokemonListCollectionViewCell.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 17.03.2023.
//

import UIKit

final class PokemonListCollectionViewListCell: UICollectionViewCell, Spinnable, PokemonListCollectionViewCell {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias SpinnerType = SpinnerView
    
    // MARK: -
    // MARK: Variables
    
    var isLoaded: Bool = false
    private(set) var id = UUID()

    // MARK: -
    // MARK: Outlets
    
    @IBOutlet var background: UIView!
    @IBOutlet var image: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var verticalTagView: VerticalTagViewController!
    
    // MARK: -
    // MARK: Public
    
    func configure(with model: Pokemon, image: UIImage) {
        self.flowLayoutConfigure()
        self.background.backgroundColor = image.getColors().background.withAlphaComponent(0.5)
        self.image.image = image
        self.idLabel.text = Int.intToFormattedIdString(number: model.id)
        self.nameLabel.text = model.name.capitalizingFirstLetter()
        self.nameLabel.font = Fonts.PaytoneOne.regular.font(size: 22)
        self.nameLabel.textColor = Colors.Colors.abbey.color
    }
    
    func configure(with model: PokemonCollectionViewCellModel) {
        self.verticalTagView?.configure(with: model.items)
    }
    
    func flowLayoutConfigure() {
        let itemWidth = 24
        let itemHeight = 24
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = 8
        self.verticalTagView?.collectionView.setCollectionViewLayout(layout, animated: false)
        self.verticalTagView?.collectionView.alwaysBounceVertical = false
        self.verticalTagView?.collectionView.isScrollEnabled = false
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.background.layer.cornerRadius = self.background.frame.width / 2
        self.layer.cornerRadius = 16
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.image.image = nil
    }
}
