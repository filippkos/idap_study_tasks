//
//  PokemonHeaderView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 26.05.2023.
//

import UIKit

import RxSwift

enum PokemonHeaderTitles: String {
    
    case height = "Height"
    case weight = "Weight"
    case order = "Order"
}

class PokemonHeaderView: NibDesignable {
    
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
        self.nameLabel?.text = model.name.capitalizingFirstLetter()
        self.heightTitle?.text = PokemonHeaderTitles.height.rawValue
        self.heightValue?.text = "\(model.height?.description ?? "") cm"
        self.weightTitle?.text = PokemonHeaderTitles.weight.rawValue
        self.weightValue?.text = "\(model.weight?.description ?? "") kg"
        self.orderTitle?.text = PokemonHeaderTitles.order.rawValue
        self.orderValue?.text = model.order?.description
    }
    
    func configure(with model: PokemonRegularViewModel) {
        self.verticalTagView?.isCentered = true
        self.verticalTagView?.configure(with: model.items)
    }
}
