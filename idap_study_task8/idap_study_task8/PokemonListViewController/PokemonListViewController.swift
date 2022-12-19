import UIKit

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
    
    private let initUrl = "https://pokeapi.co/api/v2/pokemon/?limit=50&offset=0"
    private var nextUrl: String
    
    // MARK: -
    // MARK: Init
    
    init(pokemonProvider: PokemonProvider) {
        self.pokemonProvider = pokemonProvider
        self.pokemonList = []
        self.nextUrl = ""
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
        self.task(url: initUrl)
    }
    
    // MARK: -
    // MARK: Private
    
    private func task(url: String) -> URLSessionDataTask {
        return self.pokemonProvider.getPokemonList(url: url) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let model):
                    self?.model = model
                    self?.appendPokemons()
                    self?.nextUrl = self?.model?.next ?? ""
                case let .failure(error):
                    self?.presentAlert(error: error)
                }
            }
        }
    }
    
    private func appendPokemons() {
        self.model?.results.forEach {unit in
            pokemonList.append(unit.name)
        }
    }
    
    private func presentAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: (error as! NetworkResponce).rawValue, preferredStyle: .alert)
        let action = UIAlertAction(title: "ок", style: .cancel)
        alert.addAction(action)
        
        self.present(alert, animated: true)
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
        self.navigationController?.pushViewController(PokemonViewController(pokemonProvider: self.pokemonProvider, name: self.pokemonList[indexPath.row]), animated: false)
    }
    
    
    // MARK: -
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let sectionHeight = (self.rootView?.tableView?.contentSize.height ?? 0) - scrollView.frame.size.height
        if position > sectionHeight {
            let task = self.task(url: self.nextUrl)
        }
    }
}
