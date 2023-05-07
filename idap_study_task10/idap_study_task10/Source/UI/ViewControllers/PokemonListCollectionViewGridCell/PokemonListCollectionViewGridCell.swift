//
//  PokemonListCollectionViewGridCell.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 20.03.2023.
//

import UIKit

class PokemonListCollectionViewGridCell: UICollectionViewCell, Spinnable, PokemonListCollectionViewCell {

    // MARK: -
    // MARK: Typealiases
    
    typealias SpinnerType = SpinnerView
    
    // MARK: -
    // MARK: Variables
    
    var isLoaded: Bool = false
    var searchedId:Int?
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
        self.background.backgroundColor = Colors.Colors.wildSand.color
        self.image.image = image
        self.idLabel.text = model.id.description
        self.nameLabel.text = model.name.capitalizingFirstLetter()
        self.nameLabel.font = Fonts.PaytoneOne.regular.font(size: 22)
        self.nameLabel.textColor = Colors.Colors.abbey.color
    }
    
    func configure(with model: PokemonCollectionViewCellModel) {
        self.verticalTagView.isImagesEnabled = true
        self.verticalTagView?.configure(with: model.items)
    }
    
    func flowLayoutConfigure() {
        let itemWidth = 100
        let itemHeight = 35
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.estimatedItemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 2
        self.verticalTagView?.collectionView.collectionViewLayout = layout
        self.verticalTagView?.collectionView.isPagingEnabled = false
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
        self.nameLabel.text = nil
    }
}
