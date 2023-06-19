//
//  NetworkManager.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

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
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            if let responseError = self.parser.handleNetworkResponse(response?.http?.statusCode ?? 0) {
                completion(.failure(responseError))
            } else {
                if let data = data {
                    completion(self.parser.decode(data: data))
                } else {
                    completion(.failure(NetworkError.noData))
                }
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
                completion(.failure(NetworkError.downloadError))
            } else {
                if let res = response as? HTTPURLResponse {
                    debugPrint("Downloaded data with response code \(res.statusCode)")
                    if let data = data {
                            completion(.success(data))
                    } else {
                        if let error = error {
                            completion(.failure(NetworkError.noData))
                        }
                    }
                } else {
                    if let error = error {
                        completion(.failure(NetworkError.notFound))
                    }
                }
            }
        }
        task.resume()
        
        return task
    }
}
