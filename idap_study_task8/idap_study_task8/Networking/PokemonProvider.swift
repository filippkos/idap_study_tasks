import UIKit

class PokemonProvider {
    
    // MARK: -
    // MARK: Variables
    
    let networkManager = NetworkManager()
    
    // MARK: -
    // MARK: Internal
    
    internal func getPokemon(name: String, completion: @escaping F.ResultHandler<Pokemon>) -> URLSessionDataTask {
        let query = "/pokemon/\(name)"
        let request = self.networkManager.parser.prepareRequest(query: query, offset: nil, httpMethod: .get)
        let task = self.networkManager.task(request: request, completion: completion)
        
        return task
    }
    
    internal func getPokemonList(offset: Int, completion: @escaping F.ResultHandler<PokemonList>) -> URLSessionDataTask {
        let query = "/pokemon/"
        let request = self.networkManager.parser.prepareRequest(query: query, offset: offset, httpMethod: .get)
        let task = self.networkManager.task(request: request, completion: completion)
        
        return task
    }
}
