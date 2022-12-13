import Foundation

enum NetworkResponce: String, Error {

    case notFound = "No result found for your request."
    case forbidden = "No accsess."
    case clientError = "Client error."
    case badRequest = "Bad request."
    case failed = "Network request failed."
    case serverError = "Server is not available."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the responce."
    case downloadError = "Error downloading data."
}
