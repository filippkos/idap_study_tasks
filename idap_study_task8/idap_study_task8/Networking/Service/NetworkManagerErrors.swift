import Foundation

enum NetworkManagerErrors: String, Error {
    
    case invalidUrl = "invalid url"
    case decodingError = "decoding problem"
    case resultDoesNotExist = "result does nnot exist"
}
