import UIKit

protocol NetworkManagerType {
    
    var parser: NetworkParser { get }
    func request<Model: Codable>(name: String, query: String, completion: @escaping (Result<Model, Error>) -> ()) ->URLSessionDataTask
    func getImage(from url: String, completion: @escaping (Result<UIImage, Error>) -> ()) ->URLSessionDataTask
    func getData(session: URLSession, from url: URL, completion: @escaping (Result<Data, Error>) -> ()) -> URLSessionDataTask
}

class NetworkManager: NetworkManagerType {
    
    // MARK: -
    // MARK: Variables
    
    let parser = NetworkParser()
    
    // MARK: -
    // MARK: Public

    func request<Model: Codable>(name: String, query: String, completion: @escaping (Result<Model, Error>) -> ()) ->URLSessionDataTask {
        
        let request = prepareRequest(query: query, httpMethod: HttpMethod.get)
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
    
    func getImage(from url: String, completion: @escaping (Result<UIImage, Error>) -> ()) ->URLSessionDataTask {
        
        let url = URL(string: url) ?? URL(fileURLWithPath: "")
        let session = URLSession(configuration: .default)
        let task = self.getData(
            session: session,
            from: url,
            completion: { result in
                switch result {
                case let .success(data):
                    completion(.success(self.parser.image(from: data)))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        )
        
        return task
    }
    
    func getData(session: URLSession, from url: URL, completion: @escaping (Result<Data, Error>) -> ()) -> URLSessionDataTask {

        let task = session.dataTask(with: url) { (data, response, error) in
            if let e = error {
                print("Error downloading data: \(e)")
                completion(.failure(NetworkResponce.downloadError))
            } else {
                if let res = response as? HTTPURLResponse {
                    print("Downloaded data with response code \(res.statusCode)")
                    if let data = data {
                            completion(.success(data))
                    } else {
                        completion(.failure(NetworkResponce.noData))
                    }
                } else {
                    completion(.failure(NetworkResponce.notFound))
                }
            }
        }
        task.resume()
        
        return task
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareRequest(query: String, httpMethod: HttpMethod) -> URLRequest {
        var request: URLRequest
        let urlComponents = self.createUrlComponents(query: query)
        let httpMethod = HttpMethod.get
        
        request = URLRequest(url: urlComponents.url ?? URL(fileURLWithPath: ""))
        request.httpMethod = httpMethod.rawValue
        
        return request
    }
    
    private func createUrlComponents(query: String) -> URLComponents {
        var components = URLComponents()
            components.scheme = ServerConstants.scheme
            components.host = ServerConstants.host
            components.path = ServerConstants.path + ServerConstants.version + query
        
        return components
    }

    private func decode<Model: Codable>(data: Data) -> Result<Model, Error> {
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
