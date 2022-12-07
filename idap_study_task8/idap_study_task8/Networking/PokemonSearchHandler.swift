import UIKit

protocol PokemonProvidable {
    func pokemon(name: String, completion: @escaping (Result<Pokemon, Error>) -> ()) -> URLSessionDataTask
    func image(from: String, completion: @escaping (UIImage) -> ()) -> URLSessionDataTask
}

class PokemonSearchHandler: PokemonProvidable {
    
    // MARK: -
    // MARK: Variables
    
    let networkManager = NetworkManager<Pokemon>()
    
    // MARK: -
    // MARK: Internal
    
    internal func pokemon(name: String, completion: @escaping (Result<Pokemon, Error>) -> ()) -> URLSessionDataTask {
        let task = self.networkManager.request(name: name, query: "/pokemon/\(name)", completion: completion)
        
        return task
    }
    
    internal func image(from: String, completion: @escaping (UIImage) -> ()) -> URLSessionDataTask {
        let task = self.networkManager.getImage(from: from, completion: completion)
        
        return task
    }
}
