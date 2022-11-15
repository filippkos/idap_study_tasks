import Foundation

enum Alphabets: String {
    case en = "abcdefghijklmnopqrstuvwxyz"
    case ru = "абвгдеёжзиклмнопрстуфхцчшщьъэюя"
}

extension String {
    
    static func generate(letters: Alphabets, maxRange: Int) -> String {
        let range = 0...Int.random(in: 1..<maxRange)
        return range
            .compactMap { _ in letters.rawValue.randomElement()?.description }
            .reduce("") { $0 + $1 }
    }
}