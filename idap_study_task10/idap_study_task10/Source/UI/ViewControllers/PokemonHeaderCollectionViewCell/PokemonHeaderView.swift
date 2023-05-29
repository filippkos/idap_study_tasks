//
//  PokemonHeaderView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 26.05.2023.
//

import UIKit

import RxSwift

class PokemonHeaderView: NibDesignable {

    var id: UUID = UUID()
    var dispose = DisposeBag()
    
    // MARK: -
    // MARK: Outlets
    
    var header: UILabel?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var heightTitle: UILabel?
    @IBOutlet var heightValue: UILabel?
    @IBOutlet var weightTitle: UILabel?
    @IBOutlet var weightValue: UILabel?
    @IBOutlet var orderTitle: UILabel?
    @IBOutlet var orderValue: UILabel?
    @IBOutlet var verticalTagView: VerticalTagView?
    
    // MARK: -
    // MARK: Public
    
    func configure(with model: Pokemon, indexPath: IndexPath) {
        self.nameLabel?.text = model.grouped[1]?.1.first?.capitalizingFirstLetter()
        self.heightTitle?.text = model.grouped[3]?.0
        self.heightValue?.text = "\(model.grouped[3]?.1.first ?? "") cm"
        self.weightTitle?.text = model.grouped[4]?.0
        self.weightValue?.text = "\(model.grouped[4]?.1.first ?? "") kg"
        self.orderTitle?.text = model.grouped[6]?.0
        self.orderValue?.text = model.grouped[6]?.1.first
    }
    
    func configure(with model: PokemonTableViewCellModel) {
        self.verticalTagView?.configure(with: model.items)
    }
    
    func flowLayoutConfigure() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        self.verticalTagView?.collectionView.setCollectionViewLayout(layout, animated: false)
        self.verticalTagView?.collectionView.alwaysBounceVertical = false
        self.verticalTagView?.collectionView.isScrollEnabled = false
    }
}
