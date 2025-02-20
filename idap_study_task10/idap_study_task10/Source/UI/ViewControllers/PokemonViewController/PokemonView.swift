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
    
    @IBOutlet var stackView: UIStackView?
    @IBOutlet var circularSliderView: CircularSliderView?
    @IBOutlet var imageBackgroundView: UIView?
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var infoContainer: UIView?
    
    // MARK: -
    // MARK: Public
    
    func configureNavigationBar(with item: UINavigationItem, controller: UINavigationController) {
        item.rightBarButtonItem?.setTitleTextAttributes(
            [.font: Fonts.PlusJakartaSans.extraBold.font(size: 24)],
            for: .normal
        )
        item.leftBarButtonItem?.tintColor = .white
        item.rightBarButtonItem?.tintColor = .white
        
        item.title = "Base experience"
        controller.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: Fonts.PlusJakartaSans.medium.font(size: 15)
        ]
    }
    
    func prepareHeaderView(model: Pokemon) {
        let items = model.types?.compactMap {
            return VerticalTagItem(type: $0.type.name)
        }
        
        let cellModel = PokemonRegularViewModel(
            header: model.grouped[0]?.0 ?? "",
            items: items ?? []
        )

        let headerView = PokemonHeaderView()
        headerView.configure(with: model, indexPath: IndexPath(index: 0))
        headerView.configure(with: cellModel)
        self.stackView?.addArrangedSubview(headerView)
    }
    
    func prepareRegularView(model: Pokemon) {
        let sortedArray = model.grouped.sorted(by: { $0.0 < $1.0 })
        sortedArray.forEach {
            let items = model.grouped[$0.key]?.1.map {
                VerticalTagItem(backgroundColor: Colors.Colors.wildSand.color, title: $0)
            }

            let cellModel = PokemonRegularViewModel(
                header: model.grouped[$0.key]?.0 ?? "",
                items: items ?? []
            )
            
            let cellView = PokemonRegularView()
            cellView.configure(with: cellModel)
            self.stackView?.addArrangedSubview(cellView)
        }
    }
    
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

        layoutIfNeeded()
        self.stackView?.layer.cornerRadius = 24
        self.imageBackgroundView?.layer.cornerRadius = (self.imageBackgroundView?.frame.width ?? 0) / 2
    }
}
