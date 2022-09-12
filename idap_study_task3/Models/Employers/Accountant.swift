import Foundation

class Accountant: Employee {
    
    override init(name: String) {
        super.init(name: name)
    }
    
    func count(washer: Washer) -> Bool {
        let isEnough = washer.money >= self.price
        
        if isEnough {
            super.takeMoney(another: washer)
        }
        
        return isEnough
    }
}
