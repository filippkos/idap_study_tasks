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
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var text: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .green
        self.text.layer.cornerRadius = 17
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
    }
}
