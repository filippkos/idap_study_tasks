import UIKit

class NetworkManager<Model: Codable> {
    
    // MARK: -
    // MARK: Public

    func request(name: String, query: String, completion: @escaping (Result<Model, Error>) -> ()) ->URLSessionDataTask {
        var request: URLRequest
        let urlComponents = self.createUrlComponents(query: query)
        let httpMethod = HttpMethod.get
        
        request = URLRequest(url: urlComponents.url ?? URL(fileURLWithPath: ""))
        request.httpMethod = httpMethod.rawValue
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, responce, error) in
            if let data = data {
                let statusCode = responce?.getStatusCode()
                if statusCode != 200 {
                    completion(.failure(self.handleNetworkResponce(statusCode ?? 0)))
                } else {
                    completion(self.decode(data: data))
                }
            } else {
                completion(.failure(NetworkResponce.noData))
            }
            if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
        
        return task
    }
    
    func getImage(from url: String, completion: @escaping ((UIImage) -> ())) ->URLSessionDataTask {
        let url = URL(string: url) ?? URL(fileURLWithPath: "")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let e = error {
                print("Error downloading picture: \(e)")
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
        }
        task.resume()
        
        return task
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
            return .failure(NetworkResponce.unableToDecode)
        }
    }
    
    private func handleNetworkResponce(_ statusCode: Int) -> Error {
        switch statusCode {
        case 400: return NetworkResponce.badRequest
        case 403: return NetworkResponce.forbidden
        case 404: return NetworkResponce.notFound
        case 405...500: return NetworkResponce.clientError
        case 501...599: return NetworkResponce.serverError
        default:
            return NetworkResponce.failed
        }
    }
}
