import UIKit

class PokemonViewController: UIViewController, RootViewGettable, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = PokemonView
    
    // MARK: -
    // MARK: Variables
    
    private var model: Pokemon? {
        didSet {
            self.rootView?.nameLabel?.text = self.pokemonName
            self.rootView?.tableView?.reloadData()
        }
    }
    
    private var pokemonName: String
    private var timer = Timer()
    private var pokemonProvider: PokemonProvider
    private var networkManager = NetworkManager()
    weak var coordinator: AppCoordinator?
    
    // MARK: -
    // MARK: Init
    
    init(pokemonProvider: PokemonProvider, name: String) {
        self.pokemonProvider = pokemonProvider
        self.pokemonName = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("PokemonViewController is dead")
    }
    
    // MARK: -
    // MARK: Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewMode(.firstShowing)
        self.rootView?.tableView?.register(cellClass: PokemonTableViewCell.self)
        self.getPokemon(by: self.pokemonName)
    }
    
    // MARK: -
    // MARK: Private
    
    private func createSearchTimer(completion: @escaping () -> ()) {
        self.timer.invalidate()
        
        self.timer = Timer.scheduledTimer(
            withTimeInterval: 2,
            repeats: false,
            block: { timer in
                completion()
                
                timer.invalidate()
            }
        )
    }
    
    private func getPokemon(by name: String) {
        let task = self.pokemonProvider.getPokemon(name: name, completion: { result in
            DispatchQueue.main.async { [weak self] in
                self?.setViewMode(.pokemonShowing)
                switch result {
                    
                case .success(let model):
                    self?.processPokemons(model: model)
                case let .failure(error):
                    self?.presentAlert(error: error)
                }
            }
        }
        )
    }
    
    private func processPokemons(model: Pokemon) {
        self.model = model
        let task = self.networkManager.getImage(from: model.sprites.frontDefault) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                    
                case let .success(image):
                    self?.rootView?.imageView?.image = image
                    self?.setViewMode(.imageShowing)
                case let .failure(error):
                    self?.presentAlert(error: error)
                }
            }
        }
    }
    
    private func presentAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: (error as! NetworkResponce).rawValue, preferredStyle: .alert)
        let action = UIAlertAction(title: "ок", style: .cancel)
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    // MARK: -
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.model?.grouped[section]?.1.count ?? 0
    }
    
    // MARK: -
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: PokemonTableViewCell.self)
        if self.model != nil {
            cell.fill(text: (self.model?.grouped[indexPath.section]?.1[indexPath.row]) ?? "")
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        self.model?.grouped.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName: String = ""
        if self.model != nil {
            sectionName = self.model?.grouped[section]?.0 ?? ""
        }
        
        return sectionName
    }
    
    private enum ViewMode {
        case firstShowing
        case pokemonShowing
        case emptySearchTextField
        case imageShowing
    }
    
    private func setViewMode(_ mode: ViewMode) {
        switch mode {
        case .firstShowing:
            self.rootView?.spinner?.startAnimating()
            self.rootView?.spinner?.isHidden = true
            self.rootView?.nameLabel?.isHidden = true
        case .pokemonShowing:
            self.rootView?.imageView?.image = nil
            self.rootView?.tableView?.isHidden = true
            self.rootView?.nameLabel?.isHidden = true
            self.rootView?.spinner?.isHidden = false
        case .imageShowing:
            self.rootView?.tableView?.isHidden = false
            self.rootView?.nameLabel?.isHidden = false
            self.rootView?.spinner?.isHidden = true
        case .emptySearchTextField:
            self.rootView?.imageView?.image = nil
            self.rootView?.tableView?.isHidden = true
            self.rootView?.nameLabel?.isHidden = true
            self.rootView?.spinner?.isHidden = true
        }
    }
}
