import Foundation
import UIKit

enum Fonts {
    enum TimesNewRoman {
        case regular
        func size(_ value: CGFloat) -> UIFont? {
            let font = UIFont(name: "Times New Roman", size: value)
            return font
        }
    }
    enum Arial {
        case regular
        func size(_ value: CGFloat) -> UIFont? {
            let font = UIFont(name: "Arial", size: value)
            return font
        }
    }
}
