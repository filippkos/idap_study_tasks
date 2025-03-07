//
//  LaunchView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit

final class DashboardView: BaseView {
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet var collectionView: UICollectionView?
    @IBOutlet var pager: PagerView?
    @IBOutlet var nextButton: UIButton?
    
    // MARK: -
    // MARK: Public
    
    func flowLayoutConfigure() {
        let itemWidth = UIScreen.main.bounds.width
        let itemHeight = self.collectionView?.frame.size.height
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight ?? 0)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.collectionViewLayout = layout
        self.collectionView?.isPagingEnabled = true
    }
}
