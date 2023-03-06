//
//  Array+OptionalValue.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import Foundation

extension Array {

    ///  Take an object safely
    func object(at index: Int) -> Element? {
        return (index <= self.count - 1) && (index >= 0) ? self[index] : nil
    }
}
