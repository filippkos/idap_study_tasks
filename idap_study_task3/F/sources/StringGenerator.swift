import Foundation

extension String {
    static func generate() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        return String((0..<Int.random(in: 1..<10)).map { _ in letters.randomElement() ?? "_" } )
    } 
}
