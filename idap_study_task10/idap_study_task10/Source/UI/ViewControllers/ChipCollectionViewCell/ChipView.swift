//
//  ChipView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 30.05.2023.
//

import UIKit

class ChipView: NibDesignable {
    
    // MARK: -
    // MARK: Subtypes
    
    private typealias C = Constant
    
    public enum Constant {
        
        static let side: CGFloat = 70
    }
    
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
    
    // MARK: -
    // MARK: Overrided
    
    public override var intrinsicContentSize: CGSize {
        
        return self.tagLabel?.intrinsicContentSize ?? CGSize()
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: C.side, height: C.side)
    }
}

class PaddingLabel: UILabel {
    
    var topInset: CGFloat
    var bottomInset: CGFloat
    var leftInset: CGFloat
    var rightInset: CGFloat
    
    required init(withInsets top: CGFloat, _ bottom: CGFloat, _ left: CGFloat, _ right: CGFloat) {
        self.topInset = top
        self.bottomInset = bottom
        self.leftInset = left
        self.rightInset = right
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}
