//
//  PokemonView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 26.05.2023.
//

import UIKit

import RxSwift

struct PokemonRegularViewModel {
    
    let header: String?
    let items: [VerticalTagItem]
}

class PokemonRegularView: NibDesignable {

    // MARK: -
    // MARK: Typealiases
    
    typealias SpinnerType = SpinnerView
    
    // MARK: -
    // MARK: Variables
    
    internal var isLoaded: Bool = false
    
    private var model: PokemonRegularViewModel?
    private(set) var id = UUID()

    // MARK: -
    // MARK: Outlets
    
    @IBOutlet private var header: UILabel?
    @IBOutlet private var verticalTagView: VerticalTagView?

    // MARK: -
    // MARK: Public
    
    public func configure(with model: PokemonRegularViewModel) {
        self.model = model
        self.header?.text = model.header
        self.verticalTagView?.configure(with: model.items)
    }
    
    func flowLayoutConfigure() {
        let itemWidth = 100
        let itemHeight = 35
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        self.verticalTagView?.collectionView.collectionViewLayout = layout
        self.verticalTagView?.collectionView.isPagingEnabled = false
        self.verticalTagView?.collectionView.alwaysBounceVertical = false
        self.verticalTagView?.collectionView.isScrollEnabled = false
    }
}