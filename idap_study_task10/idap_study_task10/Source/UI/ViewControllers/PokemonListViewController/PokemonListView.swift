//
//  PokemonListView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit

final class PokemonListView: BaseView {
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var leftImage: UIImageView!
    @IBOutlet var rightImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    // MARK: -
    // MARK: Public
    
    func configure() {
        self.leftImage.image = Images.icon24.image
        self.rightImage.image = UIImage(systemName: "square.grid.2x2")
        self.rightImage.tintColor = Colors.Colors.abbey.color
        self.titleLabel.text = L10n.PokemonList.title
        self.titleLabel.textColor = Colors.Colors.abbey.color
        self.titleLabel.font = Fonts.PlusJakartaSans.extraBold.font(size: 24)
    }
    
    func flowLayoutConfigure() {
        let itemWidth = self.collectionView.frame.size.width
        let itemHeight = self.collectionView.frame.size.height
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth - 48, height: 127)
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        self.collectionView.collectionViewLayout = layout
        self.collectionView.isPagingEnabled = false
    }
}

