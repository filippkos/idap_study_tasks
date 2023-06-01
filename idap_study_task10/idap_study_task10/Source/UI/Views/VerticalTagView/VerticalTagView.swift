//
//  VerticalTagView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 03.05.2023.
//

import UIKit

import SnapKit

enum VerticalTagItemState {
    
    case image
    case text
    case full
}

struct VerticalTagItem {
    
    let leftImage: UIImage?
    let backgroundColor: UIColor?
    let textColor: UIColor?
    let title: String
    let state: VerticalTagItemState
    
    public init(
        leftImage: UIImage? = nil,
        backgroundColor: UIColor? = nil,
        textColor: UIColor? = nil,
        title: String,
        state: VerticalTagItemState = .text
    ) {
        self.leftImage = leftImage
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.title = title
        self.state = state
    }
    
    public init(
        type: PokemonType,
        state: VerticalTagItemState = .full
    ) {
        self.title = type.rawValue
        self.backgroundColor = type.color
        self.textColor = type.textColor
        self.leftImage = type.image
        self.state = state
    }
}

class VerticalTagView: NibDesignable {
    
    // MARK: -
    // MARK: Outlets

    @IBOutlet var verticalStackView: UIStackView?
    
    // MARK: -
    // MARK: Variables
    
    var spacing: CGFloat = 8
    var isCentered: Bool = false

    private var items: [VerticalTagItem] = []
    
    // MARK: -
    // MARK: Public
    
    public func configure(with models: [VerticalTagItem]) {
        self.items = models
        var stackView = createRowStackView()
        var summaryWidth: CGFloat = 0
        let selfWidth = self.frame.width
        self.verticalStackView?.spacing = self.spacing
        self.verticalStackView?.removeAllArrangedSubviews()
        self.verticalStackView?.addArrangedSubview(stackView)
        
        self.items.forEach {
            let chipView = ChipView()
            chipView.fill(with: $0)
            
            if chipView.model?.state == .full {
                stackView.addArrangedSubview(chipView)
                
                return
            }
            
            let chipWidth = chipView.intrinsicContentSize.width
            summaryWidth += chipWidth + self.spacing
            
            if summaryWidth < selfWidth {
                stackView.addArrangedSubview(chipView)
                summaryWidth += self.spacing
            } else {
                stackView.addArrangedSubview(self.createSpacer())
                stackView = createRowStackView()
                self.verticalStackView?.addArrangedSubview(stackView)
                summaryWidth = 0
                summaryWidth += chipWidth + self.spacing
                stackView.addArrangedSubview(chipView)
            }
        }
        
        stackView.addArrangedSubview(self.createSpacer())
        
        if isCentered {
            self.prepareСenteringСonstraints()
        }
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareСenteringСonstraints() {
        self.verticalStackView?.arrangedSubviews.forEach {
            if let row = $0 as? UIStackView {
                row.insertArrangedSubview(self.createSpacer(), at: 0)
                if let leading = row.arrangedSubviews.first,
                   let trailing = row.arrangedSubviews.last {
                    leading.snp.makeConstraints { $0.width.equalTo(trailing) }
                }
            }
        }
    }
    
    private func createRowStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = self.spacing
        
        return stackView
    }
    
    private func createSpacer() -> UIView {
        let spacer = UIView()
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacer.setContentCompressionResistancePriority(.defaultLow,for: .horizontal)

        return spacer
    }
}
