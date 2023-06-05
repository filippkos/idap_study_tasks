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

final class DashboardViewController: BaseViewController, RootViewGettable, ScrollToPageProtocol, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = DashboardView
    
    // MARK: -
    // MARK: IBActions
    
    @IBAction func skipButton(_ sender: Any) {
        self.outputEvents?(.needShowPokemonList)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if let index = self.rootView?.collectionView?.indexPathsForVisibleItems.first?.row {
            if index < self.numberOfPages - 1 {
                self.scrollTo(page: IndexPath(item: index + 1, section: 0))
                self.rootView?.pager?.updateViews(number: index)
            }
        }
    }
    
    // MARK: -
    // MARK: Variables
    
    public var outputEvents: F.VoidFunc<DashboardViewControllerOutputEvents>?
    private var contentModels: [DashboardContentModel] = []
    
    private let numberOfPages: Int = 3
    
    // MARK: -
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.collectionView?.register(cellClass: DashboardCollectionViewCell.self)
        self.rootView?.collectionView?.dataSource = self
        self.rootView?.collectionView?.delegate = self
        self.rootView?.pager?.scrollDelegate = self
        self.rootView?.flowLayoutConfigure()
        self.fillContentModels()
    }
    
    // MARK: -
    // MARK: Public
    
    func scrollTo(page: IndexPath) {
        self.rootView?.collectionView?.isPagingEnabled = false
        self.rootView?.collectionView?.scrollToItem(at: page, at: .centeredHorizontally, animated: true)
        self.handleNextButton(page: page)
        self.rootView?.collectionView?.isPagingEnabled = true
    }
    
    // MARK: -
    // MARK: Private
    
    private func fillContentModels() {
        for model in DashboardContentModel.allCases {
            self.contentModels.append(model)
        }
    }
    
    private func handleNextButton(page: IndexPath) {
        if page.row == self.numberOfPages - 1 {
            self.rootView?.nextButton?.isHidden = true
        } else {
            self.rootView?.nextButton?.isHidden = false
        }
    }
    
    // MARK: -
    // MARK: DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: DashboardCollectionViewCell.self, indexPath: indexPath)
        cell.configure(model: self.contentModels[indexPath.row])
        cell.outputEvents = { [weak self] event in
            switch event {
            case .goNext:
                self?.outputEvents?(.needShowPokemonList)
            }
        }
        return cell
    }
    
    // MARK: -
    // MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let index = self.rootView?.collectionView?.indexPathsForVisibleItems.first?.row {
            self.rootView?.pager?.updateViews(number: index)
        }
    }
    
}

