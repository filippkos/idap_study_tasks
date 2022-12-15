import UIKit

class PokemonProvider {
    
    // MARK: -
    // MARK: Variables
    
    let networkManager = NetworkManager()
    
    // MARK: -
    // MARK: Internal
    
    internal func getPokemon(name: String, completion: @escaping F.ResultHandler<Pokemon>) -> URLSessionDataTask {
        
        let task = self.networkManager.request(name: name, query: "/pokemon/\(name)", completion: completion)
        
        return task
    }
}
