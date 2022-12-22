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
    private var pokemonList: [String] {
        didSet {
            self.rootView?.tableView?.reloadData()
        }
    }
    
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
        self.rootView?.tableView?.register(cellClass: PokemonTableViewCell.self)
        self.task()
    }
    
    // MARK: -
    // MARK: Private
    
    private func task() {
        self.rootView?.showSpinner()
        _ = self.pokemonProvider.getPokemonList(offset: self.pokemonList.count) { result in
            DispatchQueue.main.async { [weak self] in
                self?.rootView?.hideSpinner()
                switch result {
                case .success(let model):
                    self?.model = model
                    self?.appendPokemons()
                case let .failure(error):
                    self?.outputEvents?(.needShowAlert(error: error))
                }
            }
        }
    }
    
    private func appendPokemons() {
        self.model?.results.forEach {unit in
            pokemonList.append(unit.name)
        }
    }
    
    // MARK: -
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: PokemonTableViewCell.self)
        if self.model != nil {
            cell.fill(text: self.pokemonList[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.outputEvents?(.needShowDetails(name: self.pokemonList[indexPath.row]))
    }
    
    // MARK: -
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let sectionHeight = (self.rootView?.tableView?.contentSize.height ?? 0) - scrollView.frame.size.height
        if position > sectionHeight {
            self.task()
        }
    }
}
