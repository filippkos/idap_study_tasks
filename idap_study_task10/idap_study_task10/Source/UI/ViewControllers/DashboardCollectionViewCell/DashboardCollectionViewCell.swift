//
//  DashboardCollectionViewCell.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 04.03.2023.
//

import UIKit

enum DashboardCollectionViewCellOutputEvents {
    case goNext
}

final class DashboardCollectionViewCell: UICollectionViewCell {
    
    // MARK: -
    // MARK: Outlets

    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var image: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var button: UIButton!
    
    // MARK: -
    // MARK: Variables
    
    public var outputEvents: F.VoidFunc<DashboardCollectionViewCellOutputEvents>?
    
    private let buttonFontSize: CGFloat = 20
    private let buttonCornerRadius: CGFloat = 35
    
    // MARK: -
    // MARK: Public
    
    public func configure(model: DashboardContentModel) {
        self.titleLabel.text = model.title.description
        self.descriptionLabel.text = model.description.description
        
        self.image.image = model.image
        
        self.button.isHidden = !model.isVisible
        self.button.titleLabel?.text = L10n.Dashboard.buttonTitle
        self.button.titleLabel?.font = Fonts.PlusJakartaSans.extraBold.font(size: self.buttonFontSize)
        self.button.layer.cornerRadius = self.buttonCornerRadius
    }
    
    // MARK: -
    // MARK: Actions
    
    @IBAction func goButton() {
        self.outputEvents?(.goNext)
    }
}
