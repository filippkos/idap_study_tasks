//
//  VerticalTagView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 03.05.2023.
//

import UIKit

import RxSwift
import RxRelay

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
    @IBOutlet var viewHeight: NSLayoutConstraint?
    
    // MARK: -
    // MARK: Variables
    
    private var items: [VerticalTagItem] = []
    private var disposeBag = DisposeBag()
    
    // MARK: -
    // MARK: Public
    
    public func configure(with models: [VerticalTagItem]) {
        
        self.items = models
        
        self.verticalStackView?.removeAllArrangedSubviews()
        

        let selfWidth = self.frame.width
        
        // create row
        var stackView = createStackView()
        self.verticalStackView?.addArrangedSubview(stackView)
        var summaryWidth: CGFloat = -8
        
        self.items.forEach {
            let chipView = ChipView()
            chipView.fill(with: $0)
            
            let chipWidth = chipView.intrinsicContentSize.width
            summaryWidth += chipWidth + 8
            
            if summaryWidth < selfWidth {
                stackView.addArrangedSubview(chipView)
            } else {
                stackView.addArrangedSubview(UIView())
                stackView = createStackView()
                self.verticalStackView?.addArrangedSubview(stackView)
                summaryWidth = -8
            }
        }
        stackView.addArrangedSubview(UIView())
    }
    
    
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        return stackView
    }

    // MARK: -
    // MARK: Overrided
    
    override func configureView() {
        super.configureView()
        
    }
}
