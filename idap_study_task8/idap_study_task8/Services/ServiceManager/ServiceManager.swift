//Created for idap_study_task8 in 2022
// Using Swift 5.0

import Foundation

class ServiceManager {
    
    // MARK: -
    // MARK: Variables
    
    public let networkManager: NetworkManagerType
    public let pokemonProvider: PokemonProvider
    
    // MARK: -
    // MARK: Init
    
    public init(networkManager: NetworkManagerType, pokemonProvider: PokemonProvider) {
        self.networkManager = networkManager
        self.pokemonProvider = pokemonProvider
    }
}
