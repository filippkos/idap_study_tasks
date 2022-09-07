import Foundation

class Accountant: Employee {
    
    override init(name: String) {
        super.init(name: name)
    }
    
    func count(washer: Washer) -> Bool {
        if washer.money >= self.price {
            super.takeMoney(another: washer)
            return true
        }
        return false
    }
}
