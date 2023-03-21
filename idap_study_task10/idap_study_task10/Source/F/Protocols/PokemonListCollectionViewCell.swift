//
//  proto.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 20.03.2023.
//

import UIKit

protocol PokemonListCollectionViewCell {
    var id: UUID { get }
    var background: UIView! { get }
    var image: UIImageView! { get }
    var label: UILabel! { get }
    func configure(with: Pokemon, image: UIImage)
}
