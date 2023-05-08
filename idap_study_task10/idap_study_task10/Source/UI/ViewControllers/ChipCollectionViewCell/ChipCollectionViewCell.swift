//
//  ChipCollectionViewCell.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 28.04.2023.
//

import UIKit

final class ChipCollectionViewCell: UICollectionViewCell {
    
    // MARK: -
    // MARK: Properties
    
    var isLoaded: Bool = false
    private(set) var id = UUID()
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet var tagLabel: UILabel?
    @IBOutlet var tagImageContainer: UIView?
    @IBOutlet var tagImage: UIImageView?
    @IBOutlet var tagStackView: UIStackView?
    
    // MARK: -
    // MARK: Overrided
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.tagImage?.image = nil
    }
    
    // MARK: -
    // MARK: Public
    
    public func fill(with model: VerticalTagItem) {
        self.tagLabel?.text = model.title
        self.tagImage?.image = model.leftImage
        self.tagStackView?.backgroundColor = model.backgroundColor
    }
}
