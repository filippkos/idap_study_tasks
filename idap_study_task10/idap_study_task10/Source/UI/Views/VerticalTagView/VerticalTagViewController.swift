//
//  VerticalTagView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 03.05.2023.
//

import UIKit

struct VerticalTagItem {
    
    let leftImage: UIImage?
    let backgroundColor: UIColor?
    let textColor: UIColor?
    let title: String
    
    public init(leftImage: UIImage? = nil, backgroundColor: UIColor? = nil, textColor: UIColor? = nil, title: String) {
        self.leftImage = leftImage
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.title = title
    }
    
    public init(type: PokemonType) {
        self.title = type.rawValue
        self.backgroundColor = type.color
        self.textColor = type.textColor
        self.leftImage = type.image
    }
}

class VerticalTagViewController: NibDesignable, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: -
    // MARK: Outlets

    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: -
    // MARK: Variables

    var items: [VerticalTagItem] = []
    var isImagesEnabled: Bool = false
    
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
        
        if self.isImagesEnabled {
            cell.fill(with: self.items[indexPath.row])
        } else {
            cell.tagLabel?.text = self.items[indexPath.row].title
            cell.tagImageContainer?.isHidden = true
            cell.tagStackView?.backgroundColor = Colors.Colors.wildSand.color
        }

        return cell
    }
    
    // MARK: -
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

