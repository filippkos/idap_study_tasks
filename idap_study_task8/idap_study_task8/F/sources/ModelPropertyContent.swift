import Foundation

protocol ModelPropertyContent {
    
    func modelPropertyContent() -> [(String, Any)]?
}

extension ModelPropertyContent {
    
    func modelPropertyContent() -> [(String, Any)]? {
        return Mirror(reflecting: self).children.compactMap {
            ($0.label?.description, $0.value) as? (String, Any)
        }
    }
}
