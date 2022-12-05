import Foundation
import UIKit

enum NetworkManagerErrors: Error {
    
    case invalidUrl
    case decodingError
    case resultDoesNotExist
}

enum HttpMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class NetworkManager {
    
    // MARK: -
    // MARK: Variables
     
    static let shared: NetworkManager = NetworkManager()
    
    // MARK: -
    // MARK: Public

    func response(
        name: String,
        completion: @escaping (Result<Pokemon, Error>) -> ()
    )
        ->URLSessionDataTask
    {
        var request: URLRequest
        let urlComponents = self.createUrlComponents(query: "/pokemon/\(name)")
        let httpMethod: HttpMethod = .get
        
        request = URLRequest(url: urlComponents.url ?? URL(fileURLWithPath: ""))
        request.httpMethod = httpMethod.rawValue
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, responce, error) in
            if let data = data {
                completion(self.decode(data: data))
            }
            if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
        
        return task
    }
    
    func getImage(
        from url: String,
        completion: @escaping ((UIImage) -> ())
    ) {
        let picUrl = URL(string: url)!
        let session = URLSession(configuration: .default)

        let downloadPicTask = session.dataTask(with: picUrl) { (data, response, error) in
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        if let image = UIImage(data: imageData) {
                            DispatchQueue.main.async {
                                completion(image)
                            }
                        }
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }.resume()
    }
    
    // MARK: -
    // MARK: Private
    
    private func createUrlComponents(query: String) -> URLComponents {
        var components = URLComponents()
            components.scheme = ServerConstants.scheme
            components.host = ServerConstants.host
            components.path = ServerConstants.path + ServerConstants.version + query
        
        return components
    }
    
    private func decode<Model: Codable>(
        data: Data
    )
        -> Result<Model, Error>
    {
        let decoder = JSONDecoder()
        do {
            return .success(try decoder.decode(Model.self, from: data))
        } catch {
            return .failure(NetworkManagerErrors.decodingError)
        }
    }
}
