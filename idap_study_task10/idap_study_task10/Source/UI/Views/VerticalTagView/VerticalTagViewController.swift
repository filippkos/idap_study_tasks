//
//  VerticalTagView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 03.05.2023.
//

import UIKit

struct VerticalTagItem {
    
    let leftImage: UIImage?
    let title: String
}

class VerticalTagViewController: NibDesignable, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        let cell = collectionView.dequeueReusableCell(cellClass: ChipCollectionViewCell.self, indexPath: indexPath)
        cell.image?.isHidden = true
        cell.text?.text = self.items[indexPath.row].title
        cell.backgroundColor = Colors.Colors.wildSand.color
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

