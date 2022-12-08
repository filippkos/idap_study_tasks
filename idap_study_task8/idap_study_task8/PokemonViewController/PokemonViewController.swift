import UIKit

class PokemonViewController: UIViewController, RootViewGettable, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = PokemonView
    
    // MARK: -
    // MARK: Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewMode(.firstShoving)
        self.rootView?.searchBar?.delegate = self
        self.rootView?.tableView?.register(cellClass: PokemonTableViewCell.self)
    }
    
    // MARK: -
    // MARK: Variables
    
    private var model: Pokemon? {
        didSet {
            self.rootView?.nameLabel?.text = model?.name
            self.rootView?.tableView?.reloadData()
        }
    }
    private var timer = Timer()
    private var content: [(String, Any)]? {
        return self.model?.modelPropertyContent()
    }
    private var searchHandler: PokemonProvidable
    
    init(searchHandler: PokemonProvidable) {
        self.searchHandler = searchHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        let task = self.searchHandler.pokemon(
            name: name,
            completion: { result in
                DispatchQueue.main.async { [weak self] in
                    self?.setViewMode(.pokemonShoving)
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
        
        let task = self.searchHandler.image(from: model.sprites.frontDefault) {
            self.rootView?.imageView?.image = $0
            self.setViewMode(.imageShoving)
        }
    }
    
    private func presentAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: (error as! NetworkResponce).rawValue, preferredStyle: .alert)
        let action = UIAlertAction(title: "ок", style: .cancel)
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }

    // MARK: -
    // MARK: UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let name = searchText.lowercased()
        
        if name != "" {
            self.createSearchTimer { [weak self] in
                self?.getPokemon(by: name)
            }
        } else {
            self.setViewMode(.emptySearchTextField)
        }
    }
    
    // MARK: -
    // MARK: UISearchBarDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let content = self.content?[section].1 {
            return (content as? [Any])?.count ?? 1
        } else {
            
            return 0
        }
    }
    
    // MARK: -
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            cellClass: PokemonTableViewCell.self
        )
        if self.model != nil {
            cell.fill(text: (self.model?.grouped[indexPath.section]?[indexPath.row]) ?? "")
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.content?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName: String = ""
        if self.model != nil {
            sectionName = self.content?[section].0 ?? ""
        }
        
        return sectionName
    }
    
    private enum ViewMode {
        case firstShoving
        case pokemonShoving
        case emptySearchTextField
        case imageShoving
        
    }
    
    private func setViewMode(_ mode: ViewMode) {
        switch mode {
        case .firstShoving: do {
            self.rootView?.placeHolderLabel?.text = "Enter pokemon name or id."
            self.rootView?.spinner?.startAnimating()
            self.rootView?.spinner?.isHidden = true
            self.rootView?.nameLabel?.isHidden = true
        }
            
        case .pokemonShoving: do {
            self.rootView?.imageView?.image = nil
            self.rootView?.tableView?.isHidden = true
            self.rootView?.nameLabel?.isHidden = true
            self.rootView?.spinner?.isHidden = false
            self.rootView?.placeHolderLabel?.isHidden = true
        }
        
        case .imageShoving: do {
            self.rootView?.tableView?.isHidden = false
            self.rootView?.nameLabel?.isHidden = false
            self.rootView?.spinner?.isHidden = true
        }
            
        case .emptySearchTextField: do {
            self.rootView?.imageView?.image = nil
            self.rootView?.tableView?.isHidden = true
            self.rootView?.nameLabel?.isHidden = true
            self.rootView?.spinner?.isHidden = true
            self.rootView?.placeHolderLabel?.isHidden = false
        }
        }
    }
}
