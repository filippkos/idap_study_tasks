//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

// As an idea add swipe to refresh

enum PokemonListViewControllerOutputEvents {
    
    case needShowDetails(pokemonModel: PokemonModel)
    case needShowAlert(alertModel: AlertModel)
}

class PokemonListViewController: BaseViewController, RootViewGettable, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = PokemonListView
    
    // MARK: -
    // MARK: Variables
    
    public var outputEvents: ((PokemonListViewControllerOutputEvents) -> ())?
    
    private var model: PokemonList?
    private var pokemonProvider: PokemonProvider
    private var pokemonList: [PokemonModel] = [] {
        didSet {
            self.rootView?.tableView?.reloadData()
        }
    }
    
    private var pokemonsAreLoading = false
    private let limit = 200
    
    // MARK: -
    // MARK: Init
    
    public override init(serviceManager: ServiceManager) {
        self.pokemonProvider = serviceManager.pokemonProvider
        
        super.init(serviceManager: serviceManager)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.tableView?.register(cellClass: PokemonListTableViewCell.self)
        self.loadPokemonList()
    }
    
    // MARK: -
    // MARK: Private
    
    private func loadPokemonList() {
        if !self.pokemonsAreLoading {
            if self.model?.count != self.pokemonList.count {
                self.pokemonsAreLoading = true
                self.rootView?.showSpinner()
                _ = self.pokemonProvider.getPokemonList(limit: self.limit, offset: self.pokemonList.count) { result in
                    DispatchQueue.main.async { [weak self] in
                        switch result {
                        case .success(let model):
                            self?.model = model
                            self?.appendPokemons()
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
    
    private func appendPokemons() {
        self.model?.results.forEach { unit in
            let pokemonModel = PokemonModel(name: unit.name, image: nil, handler: nil)
            if !self.pokemonList.contains(pokemonModel) {
                self.pokemonList.append(pokemonModel)
            }
        }
    }
    
    // MARK: -
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: PokemonListTableViewCell.self)
        let model = self.pokemonList[indexPath.row]
        
        cell.fill(with: .init(text: model.name, image: model.image))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let pokemon = self.pokemonList.object(at: indexPath.row) {
            let pokemonModel = PokemonModel(name: pokemon.name, image: pokemon.image) { [weak self] image in
                self?.pokemonList[indexPath.row].image = image
            }
            
            self.outputEvents?(.needShowDetails(pokemonModel: pokemonModel))
        }
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
