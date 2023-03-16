//
//  CollectionView+ReusableCell.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 04.03.2023.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(cellClass: T.Type) {
        let className = String(describing: T.self)
        let nib: UINib = UINib(nibName: className, bundle: .main)
        self.register(nib, forCellWithReuseIdentifier: className)
    }
    
    func registerDefaultCell<T: UICollectionViewCell>(cellClass: T.Type) {
        let className = String(describing: T.self)
        self.register(T.self, forCellWithReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(cellClass: T.Type, indexPath: IndexPath) -> T {
        let className = String(describing: T.self)
        let cell = self.dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? T
        guard let cell = cell else {
            fatalError("this cell type doesn't registered")
        }
        return cell
    }
}
