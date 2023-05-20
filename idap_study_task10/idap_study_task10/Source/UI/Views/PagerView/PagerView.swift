//
//  PaigerView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 04.03.2023.
//

protocol ScrollToPageProtocol {
    
    func scrollTo(page: IndexPath)
}

import UIKit
import SnapKit

class PagerView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: -
    // MARK: Variables
    
    var numberOfPages: Int = 3
    var arrayOfViews: [UIView] = []
    var scrollDelegate: ScrollToPageProtocol?
    let containerSize = 24
    let layout = UICollectionViewFlowLayout()
    
    // MARK: -
    // MARK: Init

    init() {
        super.init(frame: CGRect(), collectionViewLayout: layout)
        
        self.registerDefaultCell(cellClass: UICollectionViewCell.self)
        self.dataSource = self
        self.delegate = self
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.registerDefaultCell(cellClass: UICollectionViewCell.self)
        self.dataSource = self
        self.delegate = self
        self.collectionViewLayout = self.layout
        self.setup()
    }
    
    // MARK: -
    // MARK: Public
    
    func updateViews(number: Int) {
        arrayOfViews.forEach {
            $0.subviews.first?.backgroundColor = .white
            $0.subviews.first?.layer.borderColor = Colors.Colors.heather.color.cgColor
        }
        self.arrayOfViews[number].subviews.first?.backgroundColor = Colors.Colors.abbey.color
        self.arrayOfViews[number].subviews.first?.layer.borderColor = Colors.Colors.abbey.color.cgColor
    }
    
    // MARK: -
    // MARK: Private
    
    private func setup() {
        self.prepareViews()
    }
    
    private func prepareLayout() {
        self.layout.scrollDirection = .horizontal
        self.layout.sectionInset = self.getInsets()
        self.layout.itemSize = CGSize(width: self.containerSize, height: self.containerSize)
        self.layout.minimumLineSpacing = 0
        self.isScrollEnabled = false
    }
    
    private func prepareViews() {
        for _ in 0...self.numberOfPages {
            let view = UIView()
            view.frame.size = CGSize(width: self.containerSize / 2, height: self.containerSize / 2)
            view.layer.cornerRadius = CGFloat(self.containerSize / 4)
            view.backgroundColor = .white
            view.layer.borderColor = Colors.Colors.heather.color.cgColor
            view.layer.borderWidth = 1.5
            
            let viewContainer = UIView()
            viewContainer.frame.size = CGSize(width: self.containerSize, height: self.containerSize)
            viewContainer.addSubview(view)
            
            view.snp.makeConstraints {
                $0.trailing.leading.top.bottom.equalToSuperview().inset(6)
            }
            
            self.arrayOfViews.append(viewContainer)
        }
        self.updateViews(number: 0)
    }
    
    private func getInsets() -> UIEdgeInsets {
        let totalCellWidth = self.containerSize * self.numberOfPages
        
        let horizontalInset = (self.bounds.width - CGFloat(totalCellWidth)) / 2
        let verticalInset = (self.bounds.size.height - CGFloat(self.containerSize)) / 2

        return UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.prepareLayout()
    }

    // MARK: -
    // MARK: DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(cellClass: UICollectionViewCell.self, indexPath: indexPath)
        let view = self.arrayOfViews[indexPath.row]
        cell.addSubview(view)
 
        return cell
    }
    
    // MARK: -
    // MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.scrollDelegate?.scrollTo(page: indexPath)
    }
}
