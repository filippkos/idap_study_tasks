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
    private(set) var id = UUID()

    // MARK: -
    // MARK: Outlets
    
    @IBOutlet var background: UIView!
    @IBOutlet var image: UIImageView!
    @IBOutlet var label: UILabel!
    
    // MARK: -
    // MARK: Public
    
    func configure(with model: Pokemon, image: UIImage) {
        self.background.layer.cornerRadius = self.background.frame.width / 2
        self.background.backgroundColor = Colors.Colors.wildSand.color
        self.image.image = image
        self.label.text = model.name
        self.label.font = Fonts.PaytoneOne.regular.font(size: 22)
        self.label.textColor = Colors.Colors.abbey.color
        self.layer.cornerRadius = 16
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
        self.label.text = nil
        self.id = UUID()
    }
}
