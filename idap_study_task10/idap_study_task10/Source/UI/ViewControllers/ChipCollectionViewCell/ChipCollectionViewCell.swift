//
//  ChipCollectionViewCell.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 28.04.2023.
//

import UIKit

class ChipCollectionViewCell: UICollectionViewCell {
    
    var isLoaded: Bool = false
    private(set) var id = UUID()
    
    @IBOutlet var text: UILabel!
    @IBOutlet var imageContainer: UIView!
    @IBOutlet var image: UIImageView!
    @IBOutlet var stackView: UIStackView!
    
    // MARK: -
    // MARK: Overrided
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.image.image = nil
    }
}
