//
//  PokemonListView.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit

import SnapKit

final class PokemonListView: BaseView {
    
    typealias Loc = L10n.PokemonList
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet var collectionView: UICollectionView?
    
    // MARK: -
    // MARK: Variables
    
    var emptyResultLabel: UILabel?
    
    // MARK: -
    // MARK: Public
    
    func prepareEmptyResultMessage() {
        self.emptyResultLabel = UILabel()
        self.emptyResultLabel?.text = Loc.emptySearchResultMessage
        self.emptyResultLabel?.font = Fonts.PlusJakartaSans.medium.font(size: 15)
        self.emptyResultLabel?.textColor = Colors.Colors.mediumGrey.color
        self.emptyResultLabel?.numberOfLines = 0
        
        self.addSubview(self.emptyResultLabel ?? UILabel())
        self.emptyResultLabel?.snp.makeConstraints {
            $0.top.trailing.leading.equalTo(self.collectionView ?? UIView()).inset(16)
        }
    }
    
    func configureNavigationBar(with item: UINavigationItem, controller: UINavigationController) {
        item.rightBarButtonItem?.tintColor = Colors.Colors.abbey.color
        item.title = Loc.title
        controller.navigationBar.titleTextAttributes = [
            .foregroundColor: Colors.Colors.abbey.color,
            .font: Fonts.PlusJakartaSans.extraBold.font(size: 24)
        ]
    }
    
    func configureSearchBar(with item: UINavigationItem) {
        item.searchController?.searchBar.layer.cornerRadius = 20
        item.searchController?.searchBar.searchTextField.layer.borderWidth = 2
        item.searchController?.searchBar.clipsToBounds = true
    }
    
    func configureSearchBarState(with item: UINavigationItem) {
        if item.searchController?.searchBar.searchTextField.text != "" {
            item.searchController?.searchBar.searchTextField.layer.cornerRadius = 10
            item.searchController?.searchBar.searchTextField.layer.borderWidth = 2
            item.searchController?.searchBar.searchTextField.layer.borderColor = Colors.Colors.corn.color.cgColor
        } else {
            item.searchController?.searchBar.searchTextField.layer.borderWidth = 0
            item.searchController?.searchBar.searchTextField.layer.cornerRadius = 0
        }
    }
    
    func removeEmptyResultMessage() {
        self.emptyResultLabel?.removeFromSuperview()
    }
    
    func flowLayoutListConfigure() {
        let itemWidth = (self.collectionView?.frame.size.width ?? 0) - 48
        let itemHeight = self.collectionView?.frame.size.height
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth, height: 127)
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        self.collectionView?.collectionViewLayout = layout
        self.collectionView?.alwaysBounceVertical = true
    }
    
    func flowLayoutSquaresConfigure() {
        let itemWidth = ((self.collectionView?.frame.size.width ?? 0) - 42) / 2
        let itemHeight = (224 * itemWidth) / 167
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 9
        layout.scrollDirection = .vertical
        self.collectionView?.collectionViewLayout = layout
        self.collectionView?.alwaysBounceVertical = true
    }
}

