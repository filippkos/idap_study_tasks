//
//  Cancellable.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import Foundation

protocol Cancellable {

    // MARK: - Methods

    func cancel()
}

extension URLSessionTask: Cancellable {

}
