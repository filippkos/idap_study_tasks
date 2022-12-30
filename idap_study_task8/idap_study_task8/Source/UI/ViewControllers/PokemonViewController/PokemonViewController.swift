//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

enum PokemonViewControllerOutputEvents {

    case needShowAlert(alertModel: AlertModel)
}

class PokemonViewController: BaseViewController, RootViewGettable, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: -
    // MARK: Typealiases
    
    typealias RootView = PokemonView
    
    // MARK: -
    // MARK: Types
    
    private enum ViewMode {
        
        case firstShowing
        case pokemonShowing
        case imageShowing
    }
    
    // MARK: -
    // MARK: Variables
    
    public var outputEvents: ((PokemonViewControllerOutputEvents) -> ())?
    
    private var model: Pokemon? {
        didSet {
            self.rootView?.nameLabel?.text = self.pokemonModel.name
            self.rootView?.tableView?.reloadData()
        }
    }
    
    private var pokemonModel: PokemonModel
    private var pokemonProvider: PokemonProvider
    private var networkManager: NetworkManagerType
    
    // MARK: -
    // MARK: Init
    
    public init(serviceManager: ServiceManager, pokemonModel: PokemonModel) {
        self.pokemonProvider = serviceManager.pokemonProvider
        self.networkManager = serviceManager.networkManager
        self.pokemonModel = pokemonModel

        super.init(serviceManager: serviceManager)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewMode(.firstShowing)
        self.rootView?.tableView?.register(cellClass: PokemonTableViewCell.self)
        self.getPokemon()
    }
    
    // MARK: -
    // MARK: Private
   
    private func getPokemon() {
        let _ = self.pokemonProvider.getPokemon(
            name: self.pokemonModel.name,
            completion: { result in
                DispatchQueue.main.async { [weak self] in
                    self?.setViewMode(.pokemonShowing)
                    switch result {
                    case .success(let model):
                        self?.processPokemons(model: model)
                    case let .failure(error):
                        self?.outputEvents?(.needShowAlert(alertModel: AlertModel(error: error)))
                    }
                }
            }
        )
    }
    
    private func processPokemons(model: Pokemon) {
        self.model = model
        
        let _ = self.networkManager.getImage(from: model.sprites.frontDefault) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(image):
                    self?.rootView?.show(image: image)
                    self?.setViewMode(.imageShowing)
                    self?.pokemonModel.handler?(image)
                case let .failure(error):
                    self?.outputEvents?(.needShowAlert(alertModel: AlertModel(error: error)))
                }
            }
        }
    }
    
    private func setViewMode(_ mode: ViewMode) {
        switch mode { // maybe need refactor
        case .firstShowing:
            self.rootView?.nameLabel?.isHidden = true
        case .pokemonShowing:
            self.rootView?.imageView?.image = nil
            self.rootView?.tableView?.isHidden = true
            self.rootView?.nameLabel?.isHidden = true
            self.rootView?.showSpinner(on: self.rootView, configure: nil)
        case .imageShowing:
            self.rootView?.tableView?.isHidden = false
            self.rootView?.nameLabel?.isHidden = false
            self.rootView?.hideSpinner(on: self.rootView, configure: nil)
        }
    }
    
    // MARK: -
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.grouped[section]?.1.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: PokemonTableViewCell.self)
        
        if self.model != nil {
            cell.fill(text: (self.model?.grouped[indexPath.section]?.1[indexPath.row]) ?? "")
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.model?.grouped.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName: String = ""
        sectionName = self.model?.grouped[section]?.0 ?? ""
        
        return sectionName
    }
}
