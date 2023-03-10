//
//  DashboardCollectionViewCell.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 04.03.2023.
//

import UIKit

class DashboardCollectionViewCell: UICollectionViewCell {

    @IBOutlet var image: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var button: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    public func configure() {
        self.titleLabel.text = L10n.Dashboard.First.title
        self.descriptionLabel.text = L10n.Dashboard.First.description
        self.button.titleLabel?.text = L10n.Dashboard.buttonTitle
        self.button.titleLabel?.font = UIFont(name: "PlusJakartaSans-ExtraBold", size: 20)
        self.button.layer.cornerRadius = 30
        self.clipsToBounds = true
    }

}
