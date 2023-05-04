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
    
    // MARK: -
    // MARK: Public
    
    func configure() {
    }
    
    func flowLayoutListConfigure() {
        let itemWidth = self.collectionView.frame.size.width
        let itemHeight = self.collectionView.frame.size.height
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth - 48, height: 127)
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        self.collectionView.collectionViewLayout = layout
        self.collectionView.isPagingEnabled = false
        self.collectionView.alwaysBounceVertical = true
    }
    
    func flowLayoutSquaresConfigure() {
        let itemWidth = (self.collectionView.frame.size.width - 42) / 2
        let itemHeight = (224 * itemWidth) / 167
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 9
        layout.scrollDirection = .vertical
        self.collectionView.collectionViewLayout = layout
        self.collectionView.isPagingEnabled = false
        self.collectionView.alwaysBounceVertical = true
    }
}

