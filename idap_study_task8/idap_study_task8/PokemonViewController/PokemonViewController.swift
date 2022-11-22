import UIKit

class PokemonViewController: UIViewController, RootViewGettable, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: -
    // MARK: Type Inferences
    
    typealias RootView = PokemonView
    
    // MARK: -
    // MARK: Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            if let numOfRows = self.model?.abilities.count {
                return numOfRows
            }
        } else {
            return 0
        }
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: PokemonTableViewCell.self)
        if self.model != nil {
            self.rootView?.nameLabel?.text = self.model?.name
            cell.parameterLabel?.text = self.model?.abilities[indexPath.row].ability.name
        }
        return cell
    }
}
