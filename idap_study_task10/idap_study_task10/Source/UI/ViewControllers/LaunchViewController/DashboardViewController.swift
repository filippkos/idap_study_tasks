//
//  LaunchViewController.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit

enum DashboardViewControllerOutputEvents {
    
    case needShowPokemonList
}

final class DashboardViewController: BaseViewController, RootViewGettable, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = DashboardView
    
    // MARK: -
    // MARK: IBActions
    
    @IBAction func skipButton(_ sender: Any) {
        self.outputEvents?(.needShowPokemonList)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
    }
    
    // MARK: -
    // MARK: Variables
    
    private let numberOfPages: Int = 3
    public var outputEvents: F.VoidFunc<DashboardViewControllerOutputEvents>?
    
    // MARK: -
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        self.rootView?.collectionView.register(cellClass: DashboardCollectionViewCell.self)
        self.rootView?.collectionView.dataSource = self
        self.rootView?.flowLayoutConfigure()
    }
    
    // MARK: -
    // MARK: DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: DashboardCollectionViewCell.self, indexPath: indexPath)
        cell.configure()
        return cell
    }
}

