//
//  PokemonProvider.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

protocol PokemonProviderType {
    
    @discardableResult
    func pokemon(name: String, completion: @escaping F.ResultHandler<Pokemon>) -> URLSessionDataTask
    @discardableResult
    func pokemonList(limit: Int, offset: Int, completion: @escaping F.ResultHandler<PokemonList>) -> URLSessionDataTask
    
}

import UIKit

class PokemonProvider: PokemonProviderType {
    
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
