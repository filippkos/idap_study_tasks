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
        let cell = collectionView.dequeueReusableCell(cellClass: ChipCollectionViewCell.self, indexPath: indexPath)
        let item = self.fillItem(item: self.items[indexPath.row])
        
        cell.text.text = item.title.capitalizingFirstLetter()
        if self.isImagesEnabled {
            cell.image.image = item.leftImage
            cell.text.textColor = item.textColor
            cell.stackView.backgroundColor = item.backgroundColor
        } else {
            //cell.imageContainer.isHidden = true
            cell.stackView.backgroundColor = Colors.Colors.wildSand.color
        }

        return cell
    }
    
    // MARK: -
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

