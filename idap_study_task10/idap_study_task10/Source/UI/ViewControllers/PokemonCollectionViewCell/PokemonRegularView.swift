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

    // MARK: -
    // MARK: Outlets
    
    @IBOutlet private var header: UILabel?
    @IBOutlet private var verticalTagView: VerticalTagView?

    // MARK: -
    // MARK: Public
    
    public func configure(with model: PokemonRegularViewModel) {
        self.model = model
        self.header?.text = model.header
        self.verticalTagView?.isCentered = false
        self.verticalTagView?.configure(with: model.items)
    }
}
