import UIKit

class PokemonProvider {
    
    // MARK: -
    // MARK: Variables
    
    let networkManager = NetworkManager()
    
    // MARK: -
    // MARK: Internal
    
    internal func getPokemon(name: String, completion: @escaping F.ResultHandler<Pokemon>) -> URLSessionDataTask {
        let query = "/pokemon/\(name)"
        let request = self.networkManager.parser.prepareRequest(query: query, httpMethod: .get)
        let task = self.networkManager.task(request: request, completion: completion)
        
        return task
    }
    
    internal func getPokemonList(url: String, completion: @escaping F.ResultHandler<PokemonList>) -> URLSessionDataTask {
        let request = self.networkManager.parser.prepareRequest(url: url, httpMethod: .get)
        let task = self.networkManager.task(request: request, completion: completion)
        
        return task
    }
}
