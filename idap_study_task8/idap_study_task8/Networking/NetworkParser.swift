import UIKit

class NetworkParser {
    
    private func createUrlComponents(query: String) -> URLComponents {
        var components = URLComponents()
            components.scheme = ServerConstants.scheme
            components.host = ServerConstants.host
            components.path = ServerConstants.path + ServerConstants.version + query
        
        return components
    }
    
    func prepareRequest(query: String, httpMethod: HttpMethod) -> URLRequest {
        var request: URLRequest
        let urlComponents = self.createUrlComponents(query: query)
        let httpMethod = HttpMethod.get
        
        request = URLRequest(url: urlComponents.url ?? URL(fileURLWithPath: ""))
        request.httpMethod = httpMethod.rawValue
        
        return request
    }
    
    func decode<Model: Codable>(data: Data) -> Result<Model, Error> {
        let decoder = JSONDecoder()
        do {
            return .success(try decoder.decode(Model.self, from: data))
        } catch {
            return .failure(NetworkResponce.unableToDecode)
        }
    }
    
    func image(from data: Data) -> UIImage {
        var result = UIImage()
        if let image = UIImage(data: data) {
            result = image
        }
        
        return result
    }
    
    func handleNetworkResponce(_ statusCode: Int) -> Error {
        switch statusCode {
        case 400: return NetworkResponce.badRequest
        case 403: return NetworkResponce.forbidden
        case 404: return NetworkResponce.notFound
        case 405...500: return NetworkResponce.clientError
        case 501...599: return NetworkResponce.serverError
        default: return NetworkResponce.failed
        }
    }
}
