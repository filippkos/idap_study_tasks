//
//  NetworkParcer.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import UIKit

class NetworkParser {
    
    // MARK: -
    // MARK: Private
    
    private func createUrlComponents(query: String, params: [String : String]?) -> URLComponents {
        var components = URLComponents()
            components.scheme = ServerConstants.scheme
            components.host = ServerConstants.host
            components.path = ServerConstants.path + ServerConstants.version + query
        if let params = params {
            components.queryItems = params.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        
        return components
    }
    
    // MARK: -
    // MARK: Internal
    
    internal func prepareRequest(query: String, params: [String : String]?, httpMethod: HttpMethod) -> URLRequest {
        let urlComponents = self.createUrlComponents(query: query, params: params)
        var request = URLRequest(url: urlComponents.url ?? URL(fileURLWithPath: ""))
        request.httpMethod = (HttpMethod.get).rawValue

        return request
    }
    
    internal func decode<Model: Codable>(data: Data) -> Result<Model, Error> {
        let decoder = JSONDecoder()
        do {
            return .success(try decoder.decode(Model.self, from: data))
        } catch {
            debugPrint("***Parser log - \(error)")
            
            return .failure(NetworkResponse.unableToDecode)
        }
    }
    
    internal func image(from data: Data) -> UIImage {
        var result = UIImage()
        if let image = UIImage(data: data) {
            result = image
        }
        
        return result
    }
    
    internal func handleNetworkResponse(_ statusCode: Int) -> Error {
        switch statusCode {
        case 400: return NetworkResponse.badRequest
        case 403: return NetworkResponse.forbidden
        case 404: return NetworkResponse.notFound
        case 405...500: return NetworkResponse.clientError
        case 501...599: return NetworkResponse.serverError
        default: return NetworkResponse.failed
        }
    }
}
