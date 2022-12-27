//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

enum PokemonListViewControllerOutputEvents {
    
    case needShowDetails(pokemonModel: PokemonModel)
    case needShowAlert(error: Error)
}

class PokemonListViewController: BaseViewController, RootViewGettable, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = PokemonListView
    
    // MARK: -
    // MARK: Variables
    
    private var model: PokemonList?
    private var pokemonProvider: PokemonProvider
    private var networkManager = NetworkManager()
    private var pokemonList: [PokemonModel] {
        didSet {
            self.rootView?.tableView?.reloadData()
        }
    }
    
    private var pokemonsAreLoading = false
    public var outputEvents: ((PokemonListViewControllerOutputEvents) -> ())?
    private let limit = 50
    
    // MARK: -
    // MARK: Init
    
    public init(pokemonProvider: PokemonProvider) {
        self.pokemonProvider = pokemonProvider
        self.pokemonList = []
        
        super.init(nibName: nil, bundle: nil)
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
                            self?.outputEvents?(.needShowAlert(error: error))
                        }
                        self?.rootView?.hideSpinner()
                        self?.pokemonsAreLoading = false
                    }
                }
            }
        }
    }
    
    private func appendPokemons() {
        self.model?.results.forEach {unit in
            let pokemonCellData = PokemonModel(name: unit.name, image: nil, handler: nil) // need check for unique by id
            self.pokemonList.append(pokemonCellData)
        }
    }
    
    // MARK: -
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: PokemonListTableViewCell.self)
            cell.fill(text: self.pokemonList[indexPath.row].name)
            
            if let image = self.pokemonList[indexPath.row].image {
                cell.fill(image: image)
            }
        
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
