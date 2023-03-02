//Created for idap_study_task8 in 2022
// Using Swift 5.0

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
