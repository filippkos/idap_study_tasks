//
//  PokemonHeaderView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 26.05.2023.
//

import UIKit

class PokemonHeaderView: NibDesignable {
    
    typealias Loc = L10n.PokemonView
    
    // MARK: -
    // MARK: Outlets
  
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
        self.nameLabel?.text = model.name.capitalizingFirstLetter()
        self.heightTitle?.text = Loc.height
        self.heightValue?.text = "\(model.height?.description ?? "") \(Loc.cm)"
        self.weightTitle?.text = Loc.weight
        self.weightValue?.text = "\(model.weight?.description ?? "") \(Loc.kg)"
        self.orderTitle?.text = Loc.order
        self.orderValue?.text = model.order?.description
    }
    
    func configure(with model: PokemonRegularViewModel) {
        self.verticalTagView?.isCentered = true
        self.verticalTagView?.configure(with: model.items)
    }
}
