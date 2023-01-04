//Created for idap_study_task8 in 2022
// Using Swift 5.0

import UIKit

protocol NetworkManagerType {
    
    var parser: NetworkParser { get }
    
    func task<Model: Codable>(request: URLRequest, completion: @escaping F.ResultHandler<Model>) -> URLSessionDataTask
    func getData(from url: URL, session: URLSession, completion: @escaping F.ResultHandler<Data>) -> URLSessionDataTask
    @discardableResult
    func getImage(from url: String, completion: @escaping F.ResultHandler<UIImage>) -> URLSessionDataTask
}

class NetworkManager: NetworkManagerType {
    
    // MARK: -
    // MARK: Variables
    
    internal let parser = NetworkParser()
    
    // MARK: -
    // MARK: Public

    func task<Model: Codable>(request: URLRequest, completion: @escaping F.ResultHandler<Model>) -> URLSessionDataTask {
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
    
    @discardableResult
    func getImage(from url: String, completion: @escaping F.ResultHandler<UIImage>) -> URLSessionDataTask {
        let url = URL(string: url) ?? URL(fileURLWithPath: "")
        let session = URLSession(configuration: .default)
        let task = self.getData(
            from: url,
            session: session,
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
    
    func getData(from url: URL, session: URLSession, completion: @escaping F.ResultHandler<Data>) -> URLSessionDataTask {
        let task = session.dataTask(with: url) { (data, response, error) in
            if let e = error {
                debugPrint("Error downloading data: \(e)")
                completion(.failure(NetworkResponce.downloadError))
            } else {
                if let res = response as? HTTPURLResponse {
                    debugPrint("Downloaded data with response code \(res.statusCode)")
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
