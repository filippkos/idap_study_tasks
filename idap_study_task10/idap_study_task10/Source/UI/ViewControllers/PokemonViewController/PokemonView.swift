//
//  PokemonView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit

final class PokemonView: BaseView {
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet var tableView: UITableView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var imageContainer: UIView?
    // MARK: -
    // MARK: Public
    
    public func set(image: UIImage, text: String) {
        self.imageView?.image = image
        self.nameLabel?.text = text
    }
}
