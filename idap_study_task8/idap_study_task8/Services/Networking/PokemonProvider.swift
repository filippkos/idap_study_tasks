//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

class PokemonProvider {
    
    // MARK: -
    // MARK: Variables
    
    private let networkManager: NetworkManagerType
    
    public init(networkManager: NetworkManagerType) {
        self.networkManager = networkManager
    }
    
    // MARK: -
    // MARK: Internal
    
    @discardableResult
    internal func pokemon(name: String, completion: @escaping F.ResultHandler<Pokemon>) -> URLSessionDataTask {
        let query = "/pokemon/\(name)"
        let request = self.networkManager.parser.prepareRequest(query: query, params: nil, httpMethod: .get)
        let task = self.networkManager.task(request: request, completion: completion)
        
        return task
    }
    
    @discardableResult
    internal func pokemonList(limit: Int, offset: Int, completion: @escaping F.ResultHandler<PokemonList>) -> URLSessionDataTask {
        let query = "/pokemon/"
        let params = ["limit" : "\(limit)", "offset" : "\(offset)"]
        let request = self.networkManager.parser.prepareRequest(query: query, params: params, httpMethod: .get)
        let task = self.networkManager.task(request: request, completion: completion)
        
        return task
    }
}
