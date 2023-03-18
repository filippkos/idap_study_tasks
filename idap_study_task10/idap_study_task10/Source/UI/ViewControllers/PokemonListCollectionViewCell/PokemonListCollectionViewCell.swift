//
//  PokemonListCollectionViewCell.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 17.03.2023.
//

import UIKit

class PokemonListCollectionViewCell: UICollectionViewCell, Spinnable {
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
        self.label.text = nil
        self.id = UUID()
    }
}
