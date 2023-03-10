//
//  PaigerView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 04.03.2023.
//

import UIKit
import SnapKit

class PagerView: UICollectionView, UICollectionViewDataSource {

    // MARK: -
    // MARK: Variables
    
    let numberOfPages: Int = 3
    var arrayOfViews: [UIView] = []
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 10, height: 10)
        layout.minimumLineSpacing = 0
        super.init(frame: CGRect(), collectionViewLayout: layout)
        
        self.register(cellClass: UICollectionViewCell.self)
        self.dataSource = self
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    // MARK: -
    // MARK: Private
    
    private func setup() {
        self.backgroundColor = .green
        self.prepareViews()
    }
    
    private func prepareViews() {
        for _ in 0...self.numberOfPages {
            let view = UIView()
            view.backgroundColor = .blue
            self.arrayOfViews.append(view)
        }
    }
    
    // MARK: -
    // MARK: DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(cellClass: UICollectionViewCell.self, indexPath: indexPath)
        let view = self.arrayOfViews[indexPath.row]
        view.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        cell.addSubview(view)
        return cell
    }
    
}
