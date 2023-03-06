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
        self.titleLabel.text = "Find out who"
        self.descriptionLabel.text = "IFunny is fun of your life. Images, GIFs and videos featured seven times a day. Your anaconda definitely wants some."
        self.button.titleLabel?.text = "GO!"
        self.button.backgroundColor = .yellow
        self.button.layer.cornerRadius = 30
        self.clipsToBounds = true
    }

}
