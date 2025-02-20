//
//  ServiceManager.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import Foundation

class ServiceManager {
    
    // MARK: -
    // MARK: Variables
    
    public let networkManager: NetworkManagerType
    public let storageService: StorageServiceType
    public let pokemonProvider: PokemonProviderType
    public let imageService: ImageServiceType
    
    // MARK: -
    // MARK: Init
    
    public init(networkManager: NetworkManagerType, storageService: StorageServiceType, pokemonProvider: PokemonProviderType, imageService: ImageServiceType) {
        self.networkManager = networkManager
        self.storageService = storageService
        self.pokemonProvider = pokemonProvider
        self.imageService = imageService
    }
}
