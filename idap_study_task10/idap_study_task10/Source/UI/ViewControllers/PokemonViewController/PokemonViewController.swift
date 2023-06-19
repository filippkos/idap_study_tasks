//
//  PokemonViewController.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit

import UIImageColors

enum PokemonViewControllerOutputEvents {

    case needShowAlert(alertModel: AlertModel)
}

final class PokemonViewController: BaseViewController, RootViewGettable {
    
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
    private var imageService: ImageServiceType
    private var model: Pokemon
    
    // MARK: -
    // MARK: Init
    
    public init(serviceManager: ServiceManager, pokemonModel: Pokemon) {
        self.model = pokemonModel
        self.imageService = serviceManager.imageService

        super.init(serviceManager: serviceManager)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.rootView?.prepareHeaderView(model: self.model)
        self.rootView?.prepareRegularView(model: self.model)
        self.setView(mode: .imageShowing)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.customizeNavigationBar()
        self.rootView?.configureNavigationBar(with: self.navigationItem, controller: self.navigationController ?? UINavigationController())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.rootView?.configure()
        self.rootView?.configureSlider(model: self.model)

        self.setImage(model: self.model) { [weak self] error in
            self?.outputEvents?(.needShowAlert(alertModel: AlertModel(error: error)))
        }
    }
    
    // MARK: -
    // MARK: Private
    
    private func setView(mode: ViewMode) {
        switch mode {
        case .pokemonShowing:
            self.rootView?.imageView?.image = nil
            self.rootView?.showSpinner(on: self.rootView, configure: nil)
        case .imageShowing:
            self.rootView?.hideSpinner(on: self.rootView, configure: nil)
        }
    }
    
    private func setImage(model: Pokemon, completion: @escaping (Error) -> ()) {
        self.imageService.image(for: model) { [weak self] image in
            if let image = image {
                self?.rootView?.set(image: image, text: model.name)
                self?.rootView?.prepareGradient(with: image.getColors()?.background ?? .clear)
            }
        } alertHandler: { error in
            completion(error)
        }
    }
    
    private func customizeNavigationBar() {
        let image = Images.backArrow.image.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(self.backToPokemonList(_:))
        )
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: Int.intToFormattedIdString(number: model.id),
            style: .plain,
            target: self,
            action: nil
        )
    }
    
    @objc private func backToPokemonList(_ sender: UITapGestureRecognizer?) {
        self.navigationController?.popViewController(animated: true)
    }
}
