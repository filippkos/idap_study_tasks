import UIKit

protocol NetworkManagerType {
    
    var parser: NetworkParser { get }
    func request<Model: Codable>(name: String, query: String, completion: @escaping (Result<Model, Error>) -> ()) ->URLSessionDataTask
    func getData(session: URLSession, from url: URL, completion: @escaping (Result<Data, Error>) -> ()) -> URLSessionDataTask
}

class NetworkManager: NetworkManagerType {
    
    // MARK: -
    // MARK: Variables
    
    internal let parser = NetworkParser()
    
    // MARK: -
    // MARK: Public

    func request<Model: Codable>(name: String, query: String, completion: @escaping (Result<Model, Error>) -> ()) ->URLSessionDataTask {
        let request = self.parser.prepareRequest(query: query, httpMethod: HttpMethod.get)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, responce, error) in
            if let data = data {
                let statusCode = responce?.getStatusCode()
                if statusCode != 200 {
                    completion(.failure(self.parser.handleNetworkResponce(statusCode ?? 0)))
                } else {
                    completion(self.parser.decode(data: data))
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
}
