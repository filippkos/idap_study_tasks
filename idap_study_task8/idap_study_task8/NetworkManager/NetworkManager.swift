import Foundation

class NetworkManager {
    private init() {}
    
    static let shared: NetworkManager = NetworkManager()
    
    func getWeather(city: String, completion: @escaping ((OfferModel?) -> ())) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/forecast/daily"
        urlComponents.queryItems = [URLQueryItem(name: "q", value: city),
                                    URLQueryItem(name: "appid", value: "85a70f7d616efc9081af3b10e12690e3")]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        let task = URLSession(configuration: .default)
        task.dataTask(with: request) { (data, responce, error) in
            if (responce as! HTTPURLResponse).statusCode != 200 {
                completion(nil)
                
                return
            }
            
            if data == nil {
                let decoder = JSONDecoder()
                var decoderOfferModel: OfferModel?
                
                if data != nil {
                    decoderOfferModel = try? decoder.decode(OfferModel.self, from: data!)
                }
                
                completion(decoderOfferModel)
            } else {
                print(error as Any)
            }
        }.resume()
    }
}
