//
//  PokemonListCollectionViewCell.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 17.03.2023.
//

import UIKit

import UIImageColors

final class PokemonListCollectionViewListCell: UICollectionViewCell, Spinnable, PokemonListCollectionViewCell {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias SpinnerType = SpinnerView

    // MARK: -
    // MARK: Outlets
    
    @IBOutlet var background: UIView?
    @IBOutlet var image: UIImageView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var idLabel: UILabel?
    @IBOutlet var verticalTagView: VerticalTagView?
    
    // MARK: -
    // MARK: Variables
    
    var isLoaded: Bool = false
    private(set) var id = UUID()
    
    // MARK: -
    // MARK: Public
    
    func configure(with model: Pokemon, image: UIImage) {
        layoutIfNeeded()
        self.background?.backgroundColor = image.getColors(quality: .superLow)?.background.withAlphaComponent(0.3)
        self.image?.image = image
        self.idLabel?.text = Int.intToFormattedIdString(number: model.id)
        self.nameLabel?.text = model.name.capitalizingFirstLetter()
        self.nameLabel?.font = Fonts.PaytoneOne.regular.font(size: 22)
        self.nameLabel?.textColor = Colors.Colors.abbey.color
    }
    
    func configure(with model: PokemonRegularViewModel) {
        self.verticalTagView?.isCentered = false
        self.verticalTagView?.configure(with: model.items)
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.background?.layer.cornerRadius = (self.background?.bounds.width ?? 0) / 2
        self.layer.cornerRadius = 16
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.image?.image = nil
    }
}
