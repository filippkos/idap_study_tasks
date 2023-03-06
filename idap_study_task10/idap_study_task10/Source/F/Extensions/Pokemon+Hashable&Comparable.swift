//
//  Pokemon+Hashable&Comparable.swift
//  idap_study_task10
//
//  Created by Filipp Kosenko on 02.03.2023.
//

import Foundation

extension Pokemon: Hashable, Comparable {
    
    static func < (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id < rhs.id
    }
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
