//
//  ChipCollectionViewCell.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 28.04.2023.
//

import UIKit

final class ChipCollectionViewCell: UICollectionViewCell {
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet private var tagLabel: UILabel?
    @IBOutlet private var tagImage: UIImageView?
    @IBOutlet private var tagStackView: UIStackView?
    
    // MARK: -
    // MARK: Public
    
    public func fill(with model: VerticalTagItem) {
        self.prepareText(with: model)
        self.prepareImageView(with: model)
        self.prepareContainer(with: model)
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareText(with model: VerticalTagItem) {
        self.tagLabel?.text = model.title
        self.tagLabel?.isHidden = model.title.isEmpty || model.state == .image
    }
    
    private func prepareImageView(with model: VerticalTagItem) {
        self.tagImage?.image = model.leftImage
        self.tagImage?.isHidden = model.leftImage == nil || model.state == .text
    }
    
    private func prepareContainer(with model: VerticalTagItem) {
        self.backgroundColor = model.backgroundColor
    }
    
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
}
