//Created for idap_study_task8 in 2023
// Using Swift 5.0

import Foundation

protocol Cancellable {

    // MARK: - Methods

    func cancel()
}

extension URLSessionTask: Cancellable {

}
