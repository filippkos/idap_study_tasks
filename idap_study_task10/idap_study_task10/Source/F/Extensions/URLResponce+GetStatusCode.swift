//
//  URLResponce+GetStatusCode.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import Foundation

extension URLResponse {

    var http: HTTPURLResponse? {
        return self as? HTTPURLResponse
    }
}
