//
//  VerticalTagView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 03.05.2023.
//

import UIKit

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

class VerticalTagView: NibDesignable, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: -
    // MARK: Outlets

    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: -
    // MARK: Variables

    var items: [VerticalTagItem] = []
    
    // MARK: -
    // MARK: Overrided
    
    override func configureView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView?.register(cellClass: ChipCollectionViewCell.self)
        self.collectionView.isScrollEnabled = false
    }

    // MARK: -
    // MARK: Public

    func configure(with models: [VerticalTagItem]) {
        self.items = models
        self.collectionView.reloadData()
    }

    // MARK: -
    // MARK: Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            cellClass: ChipCollectionViewCell.self,
            indexPath: indexPath
        )
        cell.fill(with: self.items[indexPath.row])

        return cell
    }
    
    // MARK: -
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let itemSize = 24
        let spacing = 8
        let totalCellWidth = ((self.items.count) * (itemSize + spacing)) - spacing
        let sideInset = (Int(self.bounds.width) - totalCellWidth) / 2 - 5
        print("<!> \(self.items.count) \(self.bounds.width) \(sideInset)")

        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

