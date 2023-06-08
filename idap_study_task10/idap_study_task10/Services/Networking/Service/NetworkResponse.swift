//
//  NetworkResponce.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import Foundation

enum NetworkResponse: Error {

    case notFound(Error)
    case forbidden(Error)
    case clientError(Error)
    case badRequest(Error)
    case failed(Error)
    case serverError(Error)
    case noData(Error)
    case unableToDecode(Error)
    case downloadError(Error)
    
    var stringValue: String {
        switch self {
            
        case .notFound:
            return "No result found for your request."
        case .forbidden:
            return "No access."
        case .clientError:
            return "Client error."
        case .badRequest:
            return "Bad request."
        case .failed:
            return "Network request failed."
        case .serverError:
            return "Server is not available."
        case .noData:
            return "Response returned with no data to decode."
        case .unableToDecode:
            return "We could not decode the response."
        case .downloadError:
            return "Error downloading data."
        }
    }
}
