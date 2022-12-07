import Foundation

enum NetworkResponce: String {
    
    case success
    case authentificationError = "Authentification error."
    case badRequest = "Bad request."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the responce."
}


