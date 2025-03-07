//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

enum PokemonListViewControllerOutputEvents {
    
    case needShowDetails(pokemonModel: Pokemon)
    case needShowAlert(alertModel: AlertModel)
}

class PokemonListViewController: BaseViewController, RootViewGettable, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = PokemonListView
    
    // MARK: -
    // MARK: Variables
    
    public var outputEvents: ((PokemonListViewControllerOutputEvents) -> ())?
    
    private var pokemon: Pokemon?
    private var listModel: PokemonList?
    private var networkManager: NetworkManagerType
    private var pokemonProvider: PokemonProviderType
    
    private var pokemonList: Set<Pokemon> = []
    
    private var pokemonsAreLoading = false
    private let limit = 30
    private var storageService: StorageServiceType
    private var imageService: ImageServiceType
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
        self.rootView?.tableView?.addSubview(self.refreshControl)
        self.rootView?.tableView?.register(cellClass: PokemonListTableViewCell.self)
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
                self.rootView?.tableView?.reloadData()
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
    
    // MARK: -
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: PokemonListTableViewCell.self)
        let initialId = cell.id
        if initialId == cell.id {
            let pokemon = self.pokemonList.first { ($0.id - 1) == indexPath.row }
            if let pokemon = pokemon {
                self.imageService.image(for: pokemon) { image in
                    cell.pokemonIcon?.showSpinner()
                    if let image = image {
                        cell.configure(with: pokemon, image: image)
                        cell.pokemonIcon?.hideSpinner()
                    }
                } alertHandler: { error in
                    self.outputEvents?(.needShowAlert(alertModel: AlertModel(error: error)))
                }
            }
        }
        
        return cell
    }
    
    // MARK: -
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var pokemon = self.pokemonList.first { ($0.id - 1) == indexPath.row }
        if pokemon != nil {
            pokemon?.checkMark = .checkmark
            self.rootView?.tableView?.reloadData()
            if let pokemon = pokemon {
                self.pokemonList.update(with: pokemon)
                self.outputEvents?(.needShowDetails(pokemonModel: pokemon))
            }
        }
    }
    
    // MARK: -
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let sectionHeight = (self.rootView?.tableView?.contentSize.height ?? 0) - scrollView.frame.size.height
        if let listModel = self.listModel {
            if self.pokemonList.count < listModel.count {
                if position > sectionHeight {
                    self.loadPokemonList()
                }
            }
        }
    }
}
