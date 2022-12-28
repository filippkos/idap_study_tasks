//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

class PokemonProvider {
    
    // MARK: -
    // MARK: Variables
    
    private let networkManager = NetworkManager()
    
    // MARK: -
    // MARK: Internal
    
    internal func getPokemon(name: String, completion: @escaping F.ResultHandler<Pokemon>) -> URLSessionDataTask {
        let query = "/pokemon/\(name)"
        let request = self.networkManager.parser.prepareRequest(query: query, params: nil, httpMethod: .get)
        let task = self.networkManager.task(request: request, completion: completion)
        
        return task
    }
    
    internal func getPokemonList(limit: Int, offset: Int, completion: @escaping F.ResultHandler<PokemonList>) -> URLSessionDataTask {
        let query = "/pokemon/"
        let params = ["limit" : "\(limit)", "offset" : "\(offset)"]
        let request = self.networkManager.parser.prepareRequest(query: query, params: params, httpMethod: .get)
        let task = self.networkManager.task(request: request, completion: completion)
        
        return task
    }
}
