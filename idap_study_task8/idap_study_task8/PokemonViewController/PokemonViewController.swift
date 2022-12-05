import UIKit

class PokemonViewController: UIViewController, RootViewGettable, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = PokemonView
    
    // MARK: -
    // MARK: Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView?.nameLabel?.text = ""
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
    
    // MARK: -
    // MARK: UISearchBarDelegate
    
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        let name = searchText.lowercased()
        
        if name != "" {
            self.createSearchTimer { [weak self] in
                self?.getPokemon(by: name)
            }
        }
    }
    
    // MARK: -
    // MARK: UISearchBarDelegate
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    )
        -> Int
    {
        if let content = self.content?[section].1 {
            return (content as? [Any])?.count ?? 1
        } else {
            
            return 0
        }
    }
    
    // MARK: -
    // MARK: UITableViewDelegate
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            cellClass: PokemonTableViewCell.self
        )
        if self.model != nil {
            if let content = self.content?[indexPath.section].1 {
                let text = anyPokeTypeToString(
                    content: content,
                    index: indexPath.row
                )
                cell.fill(text: text)
            }
        }
        
        return cell
    }
    
    func numberOfSections(
        in tableView: UITableView
    )
        -> Int
    {
        
        return self.content?.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    )
        -> String?
    {
        var sectionName: String = ""
        if self.model != nil {
            sectionName = self.content?[section].0 ?? ""
        }
        
        return sectionName
    }
    
    // MARK: -
    // MARK: Private funcs
    
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
        let task = NetworkManager.shared.response(
            name: name,
            completion: { result in
                DispatchQueue.main.async { [weak self] in
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
        self.rootView?.imageView?.setImage(
            from: self.model?.sprites.frontDefault
        )
    }
    
    private func presentAlert(error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: "ок",
            style: .cancel
        )
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    private func anyPokeTypeToString(content: Any, index: Int) -> String {
        switch content {
            case is Int:
                return (content as! Int).description
            case is String:
                return (content as! String)
            case is Bool:
                return (content as! Bool).description
            case is [Ability]:
                return (content as! [Ability])[index].ability.name
            case is [Species]:
                return (content as! [Species])[index].name
            case is [HeldItem]:
                return (content as! [HeldItem])[index].item.name
            case is [Move]:
                return (content as! [Move])[index].move.name
            case is Species:
                return (content as! Species).name
            case is [Stat]:
                return (content as! [Stat])[index].stat.name
            case is [TypeElement]:
                return (content as! [TypeElement])[index].type.name
            default:
                return "-"
        }
    }
}
