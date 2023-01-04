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
    private var pokemonProvider: PokemonProvider
    
    private var pokemonList: Set<Pokemon> = [] {
        didSet {
            self.rootView?.tableView?.reloadData()
        }
    }
    
    private var pokemonsAreLoading = false
    private let limit = 50
    
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
        self.networkManager = serviceManager.networkManager
        
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
        self.loadPokemonList()
    }
    
    // MARK: -
    // MARK: Private
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.pokemonList = []
        self.loadPokemonList()
        refreshControl.endRefreshing()
    }
    
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
        self.listModel?.results.forEach { unit in
            self.pokemon(name: unit.name)
        }
    }
    
    private func pokemon(name: String) {
        self.pokemonProvider.pokemon(
            name: name,
            completion: { result in
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case .success(let model):
                        self?.pokemonList.insert(model)
                        self?.processPokemons(model: model)
                    case let .failure(error):
                        self?.outputEvents?(.needShowAlert(alertModel: AlertModel(error: error)))
                    }
                }
            }
        )
    }
    
    private func processPokemons(model: Pokemon) {
        self.networkManager.getImage(from: model.sprites.frontDefault) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(image):
                    var pokemon = model
                    pokemon.image = image
                    self?.pokemonList.update(with: pokemon)
                case let .failure(error):
                    self?.outputEvents?(.needShowAlert(alertModel: AlertModel(error: error)))
                }
            }
        }
    }
    
    // MARK: -
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: PokemonListTableViewCell.self)
        let index = pokemonList.index(pokemonList.startIndex, offsetBy: indexPath.row)
        let model = self.pokemonList[index]
        cell.fill(with: model)
        return cell
    }
    
    // MARK: -
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = pokemonList.index(pokemonList.startIndex, offsetBy: indexPath.row)
        var pokemon = self.pokemonList[index]
        pokemon.checkMark = .checkmark
        self.pokemonList.update(with: pokemon)
        
        self.outputEvents?(.needShowDetails(pokemonModel: pokemon))
    }
    
    // MARK: -
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let sectionHeight = (self.rootView?.tableView?.contentSize.height ?? 0) - scrollView.frame.size.height
        
        if position > sectionHeight {
            self.loadPokemonList()
        }
    }
}
