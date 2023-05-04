//
//  PokemonHeaderCollectionViewCell.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 28.04.2023.
//

import UIKit

class PokemonHeaderCollectionViewCell: UICollectionViewCell {
    
    var id: UUID = UUID()
    
    // MARK: -
    // MARK: Outlets
    
    var header: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var heightTitle: UILabel!
    @IBOutlet var heightValue: UILabel!
    @IBOutlet var weightTitle: UILabel!
    @IBOutlet var weightValue: UILabel!
    @IBOutlet var orderTitle: UILabel!
    @IBOutlet var orderValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: -
    // MARK: Public
    
    func configure(with model: Pokemon, indexPath: IndexPath) {
        self.nameLabel.text = model.grouped[1]?.1.first
        self.heightTitle.text = model.grouped[3]?.0
        self.heightValue.text = "\(model.grouped[3]?.1.first ?? "") cm"
        self.weightTitle.text = model.grouped[4]?.0
        self.weightValue.text = "\(model.grouped[4]?.1.first ?? "") kg"
        self.orderTitle.text = model.grouped[6]?.0
        self.orderValue.text = model.grouped[6]?.1.first
    }
}
