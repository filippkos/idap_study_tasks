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
    case needShowAboutUs
}

class PokemonListViewController: BaseViewController, RootViewGettable, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UISearchBarDelegate {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = PokemonListView
    
    // MARK: -
    // MARK: Variables
    
    public var outputEvents: F.VoidFunc<PokemonListViewControllerOutputEvents>?
    
    private var pokemon: Pokemon?
    private var listModel: PokemonList?
    private var fullListModel: PokemonList?
    private var networkManager: NetworkManagerType
    private var pokemonProvider: PokemonProviderType
    private var pokemonList: Set<Pokemon> = []
    private var filteredPokemons: [Unit] = []
    private var searchedPokemonList: [Pokemon] = []
    private var pokemonsAreLoading = false
    private var storageService: StorageServiceType
    private var imageService: ImageServiceType
    private var isOneColumnCollectionView = true
    private var searchIsOn = false
    
    private let limit = 20
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
        self.rootView?.collectionView?.register(cellClass: PokemonListCollectionViewListCell.self)
        self.rootView?.collectionView?.register(cellClass: PokemonListCollectionViewGridCell.self)
        self.rootView?.collectionView.dataSource = self
        self.rootView?.collectionView.delegate = self
        self.customizeNavigationBar()
        self.storageService.checkAndCreateDirectory()
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
    
    private func loadPokemonList(text: String = "") {
        if !self.pokemonsAreLoading {
            self.pokemonsAreLoading = true
            self.rootView?.showSpinner()
            let limit = self.searchIsOn ? 2000 : self.limit
            let offset = self.searchIsOn ? 0 : self.pokemonList.count
            self.pokemonProvider.pokemonList(limit: limit, offset: offset) { result in
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case .success(let model):
                        if let searchIsOn = self?.searchIsOn, searchIsOn {
                            self?.fullListModel = model
                            self?.filteredPokemons = self?.fullListModel?.results.filter {
                                $0.name.starts(with: text.lowercased())
                            } ?? []
                            self?.iteratePokemons()
                        } else {
                            self?.listModel = model
                            self?.iteratePokemons()
                        }
                    case let .failure(error):
                        self?.outputEvents?(.needShowAlert(alertModel: AlertModel(error: error)))
                    }
                    
                    self?.rootView?.hideSpinner()
                    self?.pokemonsAreLoading = false
                }
            }
        }
    }
    
    private func iteratePokemons() {
        DispatchQueue.global(qos: .background).async {
            if self.searchIsOn {
                self.filteredPokemons.forEach { unit in
                    self.pokemon(name: unit.name, group: self.group)
                }
            } else {
                self.listModel?.results.forEach { unit in
                    self.pokemon(name: unit.name, group: self.group)
                }
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
                        if let searchIsOn = self?.searchIsOn, searchIsOn {
                            self?.searchedPokemonList.append(model)
                        } else {
                            self?.pokemonList.insert(model)
                        }
                    case let .failure(error):
                        self?.outputEvents?(.needShowAlert(alertModel: AlertModel(error: error)))
                    }
                }
                group.leave()

                print("<!> \(name) leave")
            }
        )
    }
    
    private func prepareTapGesture(on image: UIImageView?, selector: Selector) {
        let tap = UITapGestureRecognizer(
            target: self,
            action: selector
        )
        image?.addGestureRecognizer(tap)
        image?.isUserInteractionEnabled = true
    }
    
    @objc private func showAboutUs(_ sender: UITapGestureRecognizer?) {
        self.outputEvents?(.needShowAboutUs)
    }
        
    @objc private func changeCollectionViewLayout(_ sender: UITapGestureRecognizer?) {
        if self.isOneColumnCollectionView {
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "rectangle.grid.1x2")
            self.rootView?.flowLayoutSquaresConfigure()
            self.isOneColumnCollectionView = false
            self.rootView?.collectionView.reloadData()
        } else {
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "square.grid.2x2")
            self.rootView?.flowLayoutListConfigure()
            self.isOneColumnCollectionView = true
            self.rootView?.collectionView.reloadData()
        }
    }
    
    private func customizeNavigationBar() {
        let leftImage = Images.icon24.image
        let rightImage = UIImage(systemName: "square.grid.2x2")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: .done, target: self, action: #selector(self.showAboutUs(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImage, style: .plain, target: self, action: #selector(self.changeCollectionViewLayout(_:)))
        self.navigationItem.rightBarButtonItem?.tintColor = Colors.Colors.abbey.color
        
        self.navigationItem.title = L10n.PokemonList.title
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: Colors.Colors.abbey.color,
            .font: Fonts.PlusJakartaSans.extraBold.font(size: 24)
        ]
        
        self.navigationItem.searchController = UISearchController()
        self.navigationItem.searchController?.searchBar.delegate = self
    }
    
    private func configureSearchBar() {
        if self.navigationItem.searchController?.searchBar.searchTextField.text != "" {
            self.navigationItem.searchController?.searchBar.searchTextField.layer.cornerRadius = 10
            self.navigationItem.searchController?.searchBar.searchTextField.layer.borderWidth = 2
            self.navigationItem.searchController?.searchBar.searchTextField.layer.borderColor = Colors.Colors.corn.color.cgColor
        } else {
            self.navigationItem.searchController?.searchBar.searchTextField.layer.borderWidth = 0
            self.navigationItem.searchController?.searchBar.searchTextField.layer.cornerRadius = 0
        }
    }
    
    // MARK: -
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !self.searchIsOn {
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
    }
    
    // MARK: -
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var cellCount: Int = 0
        if !self.searchIsOn {
            cellCount = self.pokemonList.count
        } else {
            cellCount = self.searchedPokemonList.count
        }
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: PokemonListCollectionViewCell
        if self.isOneColumnCollectionView {
            cell = collectionView.dequeueReusableCell(cellClass: PokemonListCollectionViewListCell.self, indexPath: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(cellClass: PokemonListCollectionViewGridCell.self, indexPath: indexPath)
        }
        
        var cellPokemon: Pokemon?
        let initialId = cell.id
        if initialId == cell.id {
            if !self.searchIsOn {
                if let pokemon = self.pokemonList.first { ($0.id - 1) == indexPath.row } {
                    cellPokemon = pokemon
                }
            } else {
                cellPokemon = self.searchedPokemonList[indexPath.row]
            }
            if let pokemon = cellPokemon {
                self.imageService.image(for: pokemon) { image in
                    cell.image.showSpinner()
                    if let image = image {
                        cell.configure(with: pokemon, image: image)
                        cell.image?.hideSpinner()
                    }
                } alertHandler: { error in
                    self.outputEvents?(.needShowAlert(alertModel: AlertModel(error: error)))
                }
            }
        }
        
        return cell as! UICollectionViewCell
    }
    
    // MARK: -
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var cellPokemon: Pokemon?
        if !self.searchIsOn {
            if let pokemon = self.pokemonList.first { ($0.id - 1) == indexPath.row } {
                cellPokemon = pokemon
            }
        } else {
            cellPokemon = self.searchedPokemonList[indexPath.row]
        }
        if cellPokemon != nil {
            self.rootView?.collectionView?.reloadData()
            if let detailedPokemon = cellPokemon {
                self.outputEvents?(.needShowDetails(pokemonModel: detailedPokemon))
            }
        }
    }
    
    // MARK: -
    // MARK: UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.configureSearchBar()
        if searchText != "" {
            self.searchIsOn = true
            self.filteredPokemons.removeAll()
            self.searchedPokemonList.removeAll()
            self.loadPokemonList(text: searchText)
        } else {
            self.searchIsOn = false
            self.pokemonList.removeAll()
            self.loadPokemonList()
        }
        
        self.rootView?.collectionView?.reloadData()
    }
}
