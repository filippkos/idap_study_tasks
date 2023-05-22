//
//  PokemonCollectionViewCell.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 28.04.2023.
//

import UIKit

struct PokemonCollectionViewCellModel {
    
    let header: String?
    let items: [VerticalTagItem]
}

final class PokemonCollectionViewCell: UICollectionViewCell, Spinnable {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias SpinnerType = SpinnerView
    
    // MARK: -
    // MARK: Variables
    
    var model: PokemonCollectionViewCellModel?
    var isLoaded: Bool = false
    private(set) var id = UUID()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }

    // MARK: -
    // MARK: Outlets
    
    @IBOutlet var header: UILabel?
    @IBOutlet var verticalTagView: VerticalTagView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.flowLayoutConfigure()
        // Initialization code
    }

    // MARK: -
    // MARK: Public
    
    func configure(with model: PokemonCollectionViewCellModel) {
        self.model = model
        self.header?.text = model.header
        self.verticalTagView?.configure(with: model.items)
    }
    
    func flowLayoutConfigure() {
        let itemWidth = 100
        let itemHeight = 35
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        self.verticalTagView?.collectionView.collectionViewLayout = layout
        self.verticalTagView?.collectionView.isPagingEnabled = false
        self.verticalTagView?.collectionView.alwaysBounceVertical = false
        self.verticalTagView?.collectionView.isScrollEnabled = false
    }
}
