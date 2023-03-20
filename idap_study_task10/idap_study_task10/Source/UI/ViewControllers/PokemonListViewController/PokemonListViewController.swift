//
//  PokemonListViewController.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit

enum PokemonListViewControllerOutputEvents {
    
    case needShowDetails(pokemonModel: Pokemon)
    case needShowAlert(alertModel: AlertModel)
}

class PokemonListViewController: BaseViewController, RootViewGettable, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = PokemonListView
    
    // MARK: -
    // MARK: Variables
    
    public var outputEvents: F.VoidFunc<PokemonListViewControllerOutputEvents>?
    
    private var pokemon: Pokemon?
    private var listModel: PokemonList?
    private var networkManager: NetworkManagerType
    private var pokemonProvider: PokemonProviderType
    private var pokemonList: Set<Pokemon> = []
    private var pokemonsAreLoading = false
    private var storageService: StorageServiceType
    private var imageService: ImageServiceType
    private var isOneColumnCollectionView = true
    private let limit = 30
    private let group = DispatchGroup()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(PokemonListViewController.handleRefresh(_:)),
            for: UIControl.Event.valueChanged
        )
        refreshControl.tintColor = UIColor.cyan
        
        return refreshControl
    }()
    
    // MARK: -
    // MARK: Init
    
    public override init(serviceManager: ServiceManager) {
        self.pokemonProvider = serviceManager.pokemonProvider
        self.storageService = serviceManager.storageService
        self.networkManager = serviceManager.networkManager
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
        self.rootView?.configure()
        self.rootView?.flowLayoutListConfigure()
        self.rootView?.collectionView?.register(cellClass: PokemonListCollectionViewCell.self)
        self.rootView?.collectionView.dataSource = self
        self.rootView?.collectionView.delegate = self
        self.storageService.checkAndCreateDirectory()
        self.prepareTapGesture(on: self.rootView?.rightImage)
        self.loadPokemonList()
    }
    
    // MARK: -
    // MARK: HandleRefresh
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.pokemonList = []
        self.storageService.checkAndCreateDirectory()
        self.loadPokemonList()
        refreshControl.endRefreshing()
    }
    
    // MARK: -
    // MARK: Private
    
    private func loadPokemonList() {
        if !self.pokemonsAreLoading {
            if self.listModel?.count != self.pokemonList.count {
                self.pokemonsAreLoading = true
                self.rootView?.showSpinner()
                self.pokemonProvider.pokemonList(limit: self.limit, offset: self.pokemonList.count) { result in
                    DispatchQueue.main.async { [weak self] in
                        switch result {
                        case .success(let model):
                            self?.listModel = model
                            self?.iteratePokemons()
                        case let .failure(error):
                            self?.outputEvents?(.needShowAlert(alertModel: AlertModel(error: error)))
                        }
                        self?.rootView?.hideSpinner()
                        self?.pokemonsAreLoading = false
                    }
                }
            }
        }
    }
    
    private func iteratePokemons() {
        DispatchQueue.global(qos: .background).async {
            self.listModel?.results.forEach { unit in
                self.pokemon(name: unit.name, group: self.group)
            }
            print("<!> before wait \(Thread.current)")
            self.group.wait()
            DispatchQueue.main.async {
                self.rootView?.collectionView.reloadData()
            }
            print("<!> after wait")
        }
    }
    
    private func pokemon(name: String, group: DispatchGroup) {
        print("<!> \(name) enter")
        group.enter()
        self.pokemonProvider.pokemon(
            name: name,
            completion: { result in
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case .success(let model):
                        self?.pokemonList.insert(model)
                    case let .failure(error):
                        self?.outputEvents?(.needShowAlert(alertModel: AlertModel(error: error)))
                    }
                }
                group.leave()

                print("<!> \(name) leave")
            }
        )
    }
    
    private func prepareTapGesture(on image: UIImageView?) {
            let tap = UITapGestureRecognizer(
                target: self,
                action: #selector(self.changeCollectionViewLayout(_:))
            )
            image?.addGestureRecognizer(tap)
            image?.isUserInteractionEnabled = true
        }
        
        @objc private func changeCollectionViewLayout(_ sender: UITapGestureRecognizer?) {
            if self.isOneColumnCollectionView {
                self.rootView?.flowLayoutSquaresConfigure()
                self.isOneColumnCollectionView = false
            } else {
                self.rootView?.flowLayoutListConfigure()
                self.isOneColumnCollectionView = true
            }
        }
        
        private func cell(for indexPath: IndexPath) {

        }
    
    // MARK: -
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let sectionHeight = (self.rootView?.collectionView?.contentSize.height ?? 0) - scrollView.frame.size.height
        if let listModel = self.listModel {
            if self.pokemonList.count < listModel.count {
                if position > sectionHeight {
                    self.loadPokemonList()
                }
            }
        }
    }
    
    // MARK: -
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: PokemonListCollectionViewCell.self, indexPath: indexPath)
        let initialId = cell.id
        if initialId == cell.id {
            let pokemon = self.pokemonList.first { ($0.id - 1) == indexPath.row }
            if let pokemon = pokemon {
                self.imageService.image(for: pokemon) { image in
                    cell.image?.showSpinner()
                    if let image = image {
                        cell.configure(with: pokemon, image: image)
                        cell.image?.hideSpinner()
                    }
                } alertHandler: { error in
                    self.outputEvents?(.needShowAlert(alertModel: AlertModel(error: error)))
                }
            }
        }
        
        return cell
    }
    
    // MARK: -
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = self.pokemonList.first { ($0.id - 1) == indexPath.row }
        if pokemon != nil {
            self.rootView?.collectionView?.reloadData()
            if let pokemon = pokemon {
                self.pokemonList.update(with: pokemon)
                self.outputEvents?(.needShowDetails(pokemonModel: pokemon))
            }
        }
    }
}
