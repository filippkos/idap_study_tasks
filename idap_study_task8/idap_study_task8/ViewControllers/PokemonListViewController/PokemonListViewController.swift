//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

enum PokemonListViewControllerOutputEvents {
    
    case needShowDetails(name: String)
    case needShowAlert(error: Error)
}

class PokemonListViewController: UIViewController, RootViewGettable, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = PokemonListView
    
    // MARK: -
    // MARK: Variables
    
    private var model: PokemonList?
    private var pokemonProvider: PokemonProvider
    private var networkManager = NetworkManager()
    private var pokemonList: [PokemonCellData] {
        didSet {
            self.rootView?.tableView?.reloadData()
        }
    }
    
    private var pokemonsAreLoading = false
    public var outputEvents: ((PokemonListViewControllerOutputEvents) -> ())?
    
    // MARK: -
    // MARK: Init
    
    init(pokemonProvider: PokemonProvider) {
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
            print("model \(self.model?.count)")
            print("pokeList \(self.pokemonList.count)")
            if self.model?.count != self.pokemonList.count {
                self.pokemonsAreLoading = true
                self.rootView?.showSpinner()
                _ = self.pokemonProvider.getPokemonList(offset: self.pokemonList.count) { result in
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
            let pokemonCellData = PokemonCellData(name: unit.name, image: nil, handler: nil)
            pokemonList.append(pokemonCellData)
        }
    }
    
    private func lastPage() {
        
    }
    
    // MARK: -
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: PokemonListTableViewCell.self)
        if self.model != nil {
            cell.fill(text: self.pokemonList[indexPath.row].name)
            
            if let image = self.pokemonList[indexPath.row].image {
                cell.fill(image: image)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let pokemon = self.pokemonList.object(at: indexPath.row) {
            self.outputEvents?(.needShowDetails(name: pokemon.name))
            self.pokemonList[indexPath.row].image = UIImage(systemName: "eyes.inverse")
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
