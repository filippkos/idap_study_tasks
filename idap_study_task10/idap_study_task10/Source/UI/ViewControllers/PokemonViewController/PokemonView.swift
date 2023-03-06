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
    
    @IBOutlet internal var tableView: UITableView?
    @IBOutlet internal var nameLabel: UILabel?
    @IBOutlet internal var imageView: UIImageView?
    @IBOutlet internal var imageContainer: UIView?
    // MARK: -
    // MARK: Public
    
    public func set(image: UIImage, text: String) {
        self.imageView?.image = image
        self.nameLabel?.text = text
    }
}
