import Foundation
import UIKit

class NetworkManager {
    
    static let shared: NetworkManager = NetworkManager()
    
    func getPokemon(name: String, completion: @escaping ((TopLevel?) -> ())) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "pokeapi.co"
        urlComponents.path = "/api/v2/pokemon/\(name)"
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        let task = URLSession(configuration: .default)
        task.dataTask(with: request) { (data, responce, error) in
            if (responce as! HTTPURLResponse).statusCode != 200 {
                completion(nil)
                return
            }
            
            if data != nil {
                let decoder = JSONDecoder()
                var decoderOfferModel: TopLevel?
                
                if data != nil {
                    decoderOfferModel = try? decoder.decode(TopLevel.self, from: data!)
                }
                
                completion(decoderOfferModel)
                
            } else {
                print(error as Any)
            }
        }.resume()
    }
    
    func getImage(from url: String, completion: @escaping ((UIImage) -> ())) {
        let picUrl = URL(string: url)!
        let session = URLSession(configuration: .default)

        let downloadPicTask = session.dataTask(with: picUrl) { (data, response, error) in
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            completion(image!)
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
}
