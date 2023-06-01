//
//  ChipView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 30.05.2023.
//

import UIKit

final class ChipView: NibDesignable {
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet private var tagLabel: PaddingLabel?
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
        self.tagLabel?.text = model.title.capitalizingFirstLetter()
        self.tagLabel?.textColor = model.textColor
        self.tagLabel?.font = Fonts.PlusJakartaSans.medium.font(size: 15)
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
    
    public override var intrinsicContentSize: CGSize {
        return self.tagLabel?.intrinsicContentSize ?? CGSize()
    }
}
