//
//  PokemonViewController.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit
import UIImageColors

enum PokemonViewControllerOutputEvents {

    case needShowAlert(alertModel: AlertModel)
}

final class PokemonViewController: BaseViewController, RootViewGettable, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = PokemonView
    
    // MARK: -
    // MARK: Types
    
    private enum ViewMode {
        
        case pokemonShowing
        case imageShowing
    }
    
    // MARK: -
    // MARK: Variables
    
    public var outputEvents: ((PokemonViewControllerOutputEvents) -> ())?
    private var imageService: ImageServiceType
    private var model: Pokemon
    
    // MARK: -
    // MARK: Init
    
    public init(serviceManager: ServiceManager, pokemonModel: Pokemon) {
        self.model = pokemonModel
        self.imageService = serviceManager.imageService

        super.init(serviceManager: serviceManager)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView?.collectionView?.register(cellClass: PokemonHeaderCollectionViewCell.self)
        self.rootView?.collectionView?.register(cellClass: PokemonCollectionViewCell.self)
        self.rootView?.collectionView?.dataSource = self
        self.rootView?.collectionView?.delegate = self
        self.setViewMode(.imageShowing)
        self.setImage(model: self.model) { [weak self] error in
            self?.outputEvents?(.needShowAlert(alertModel: AlertModel(error: error))
            )
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.customizeNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        self.rootView?.configure()
        self.rootView?.configureSlider(model: self.model)
    }
    
    // MARK: -
    // MARK: Private
    
    private func setViewMode(_ mode: ViewMode) {
        switch mode {
        case .pokemonShowing:
            self.rootView?.imageView?.image = nil
            self.rootView?.showSpinner(on: self.rootView, configure: nil)
        case .imageShowing:
            self.rootView?.hideSpinner(on: self.rootView, configure: nil)
        }
    }
    
    private func setImage(model: Pokemon, completion: @escaping (Error) -> ()) {
        self.imageService.image(for: model) { [weak self] image in
            if let image = image {
                self?.rootView?.set(image: image, text: model.name)
                self?.rootView?.prepareGradient(with: image.getColors()?.background ?? .clear)
            }
        } alertHandler: { error in
            completion(error)
        }
    }
    
    private func customizeNavigationBar() {
        let image = Images.backArrow.image.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image,
            style:.plain,
            target: self,
            action: #selector(self.backToPokemonList(_:))
        )
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: Int.intToFormattedIdString(number: model.id),
            style: .plain,
            target: self,
            action: nil
        )
        
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes(
            [.font: Fonts.PlusJakartaSans.extraBold.font(size: 24)],
            for: .normal
        )
    
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
        self.navigationItem.title = "Base experience"
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: Fonts.PlusJakartaSans.medium.font(size: 15)
        ]
    }
    
    @objc private func backToPokemonList(_ sender: UITapGestureRecognizer?) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: -
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.model.grouped.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(
                cellClass: PokemonHeaderCollectionViewCell.self,
                indexPath: indexPath
            )
            
            let items = self.model.types?.compactMap {
                return VerticalTagItem(type: $0.type.name)
            }
            
            let cellModel = PokemonCollectionViewCellModel(
                header: self.model.grouped[indexPath.row]?.0 ?? "",
                items: items ?? [])
            
            cell.configure(with: self.model, indexPath: indexPath)
            cell.configure(with: cellModel)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                cellClass: PokemonCollectionViewCell.self,
                indexPath: indexPath
            )
            
            let items = self.model.grouped[indexPath.row]?.1.map {
                VerticalTagItem(backgroundColor: Colors.Colors.wildSand.color, title: $0)
            }
            
            let cellModel = PokemonCollectionViewCellModel(
                header: self.model.grouped[indexPath.row]?.0 ?? "",
                items: items ?? []
            )
            
            cell.configure(with: cellModel)
            
            return cell
        }
    }
}
