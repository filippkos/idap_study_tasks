import UIKit

class PokemonViewController: UIViewController, RootViewGettable, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: -
    // MARK: Type Inferences
    
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
    
    var model: TopLevel? {
        didSet {
            self.rootView?.tableView?.reloadData()
        }
    }
    var timer = Timer()
    var dataIsReady: Bool = false
    
    // MARK: -
    // MARK: Delegates
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let name = searchText.lowercased()
        
        timer.invalidate()
        
        if name != "" {
            timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in
                NetworkManager.shared.getPokemon(name: name, completion: { (model) in
                    DispatchQueue.main.async {
                        if model != nil {
                            self.dataIsReady = true
                            self.model = model
                            NetworkManager.shared.getImage(from: self.model?.sprites.frontDefault ?? "", completion: { image in
                                    self.rootView?.imageView?.image = image
                            })
                        } else {
                            let alert = UIAlertController(title: "error", message: "something wrong", preferredStyle: .alert)
                            let action = UIAlertAction(title: "ок", style: .cancel)
                            alert.addAction(action)
                            self.present(alert, animated: true)
                        }
                    }
                })
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataIsReady {
            
            if let content = model?.modelPropertyContent()?[section].1 {
                
                if content is [Any] {
                    return (content as! [Any]).count
                } else {
                    return 1
                }
            }
        } else {
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: PokemonTableViewCell.self)
        if self.model != nil {
            self.rootView?.nameLabel?.text = model?.name
            if let content = model?.modelPropertyContent()?[indexPath.section].1 {
                cell.parameterLabel?.text = anyPokeTypeToString(content: content, index: indexPath.row)
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var arr: [(String, Any)] = []
        if model != nil {
            arr = self.model!.modelPropertyContent()!
        }
        return arr.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName: String = ""
        if model != nil {
            sectionName = self.model?.modelPropertyContent()?[section].0 ?? ""
        }
        return sectionName
    }
    
    // MARK: -
    // MARK: Private funcs
    
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
            case is [GameIndex]:
                return (content as! [GameIndex])[index].gameIndex.description
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
                return "..."
        }
    }
}
