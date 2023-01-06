//Created for idap_study_task8 in 2023
// Using Swift 5.0

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
