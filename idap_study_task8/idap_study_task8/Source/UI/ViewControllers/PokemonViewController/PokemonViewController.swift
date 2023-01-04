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
        
        case pokemonShowing
        case imageShowing
    }
    
    // MARK: -
    // MARK: Variables
    
    public var outputEvents: ((PokemonViewControllerOutputEvents) -> ())?
    
    private var model: Pokemon
    
    // MARK: -
    // MARK: Init
    
    public init(serviceManager: ServiceManager, pokemonModel: Pokemon) {
        self.model = pokemonModel

        super.init(serviceManager: serviceManager)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView?.tableView?.register(cellClass: PokemonTableViewCell.self)
        self.setViewMode(.imageShowing)
        if let image = self.model.image {
            self.rootView?.set(image: image, text: self.model.name)
        }
        
    }
    
    // MARK: -
    // MARK: Private
    
    private func setViewMode(_ mode: ViewMode) {
        switch mode {
        case .pokemonShowing:
            self.rootView?.imageView?.image = nil
            self.rootView?.showSpinner(on: self.rootView, configure: nil)
            self.rootView?.showSpinner(on: self.rootView?.imageContainer, configure: nil)
        case .imageShowing:
            self.rootView?.hideSpinner(on: self.rootView, configure: nil)
            self.rootView?.hideSpinner(on: self.rootView?.imageContainer, configure: nil)
        }
        self.rootView?.nameLabel?.isHidden = mode != .imageShowing
        self.rootView?.tableView?.isHidden = mode != .imageShowing
    }
    
    // MARK: -
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.grouped[section]?.1.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: PokemonTableViewCell.self)
        cell.fill(text: (self.model.grouped[indexPath.section]?.1[indexPath.row]) ?? "")
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.model.grouped.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName: String = ""
        sectionName = self.model.grouped[section]?.0 ?? ""
        
        return sectionName
    }
}
