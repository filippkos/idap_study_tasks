//
//  PokemonView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit
import UIImageColors

final class PokemonView: BaseView {
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet var tableView: UITableView?
    @IBOutlet var circularSliderView: CircularSliderView?
    @IBOutlet var imageBackgroundView: UIView?
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var infoContainer: UIView?
    
    // MARK: -
    // MARK: Public
    
    public func configure() {
        self.infoContainer?.layer.cornerRadius = 24
    }
    
    public func set(image: UIImage, text: String) {
        self.imageView?.image = image
    }
    
    func configureSlider(model: Pokemon) {
        self.circularSliderView?.prepareSlider(value: model.baseExperience ?? 0)
    }
    
    func prepareGradient(with color: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.frame
        gradientLayer.locations = [0.0, 0.5]
        gradientLayer.colors = [color.withAlphaComponent(0.2).cgColor, color.cgColor]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.tableView?.layer.cornerRadius = 24
        self.imageBackgroundView?.layer.cornerRadius = (self.imageBackgroundView?.frame.width ?? 0) / 2
    }
}
