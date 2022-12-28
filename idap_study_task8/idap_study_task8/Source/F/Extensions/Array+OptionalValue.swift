//Created for idap_study_task8 in 2022
// Using Swift 5.0

import Foundation

extension Array {

    ///  Take an object safely
    func object(at index: Int) -> Element? {
        return (index <= self.count - 1) && (index >= 0) ? self[index] : nil
    }
}
