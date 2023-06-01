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
    
    @IBOutlet private var topConstraint: NSLayoutConstraint?
    @IBOutlet private var bottomConstraint: NSLayoutConstraint?
    @IBOutlet private var leftConstraint: NSLayoutConstraint?
    @IBOutlet private var rightConstraint: NSLayoutConstraint?
    
    // MARK: -
    // MARK: Variables
    
    let imageSize: CGFloat = 32
    let contentInset: CGFloat = 4
    var model: VerticalTagItem?
    
    // MARK: -
    // MARK: Public
    
    public func fill(with model: VerticalTagItem) {
        self.prepareText(with: model)
        self.prepareImageView(with: model)
        self.prepareContainer(with: model)
        self.setupConstraints()
    }
    
    // MARK: -
    // MARK: Private
    
    private func setupConstraints() {
        self.leftConstraint?.constant = self.contentInset
        self.rightConstraint?.constant = self.contentInset
        self.topConstraint?.constant = self.contentInset
        self.bottomConstraint?.constant = self.contentInset
    }
    
    private func prepareText(with model: VerticalTagItem) {
        self.model = model
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
        let labelWidth = self.tagLabel?.intrinsicContentSize.width ?? CGFloat()
        let labelHeight = self.tagLabel?.intrinsicContentSize.height ?? CGFloat()
        
        switch self.model?.state {
        case .none:
            return CGSize()
        case .some(.image):
            return CGSize(width: imageSize, height: imageSize)
        case .some(.text):
            return CGSize(width: labelWidth + (self.contentInset * 2), height: labelHeight)
        case .some(.full):
            return CGSize(
                width: imageSize + labelWidth + (self.contentInset * 2) + (self.tagStackView?.spacing ?? CGFloat()),
                height: imageSize + labelHeight
            )
        }
    }
}
