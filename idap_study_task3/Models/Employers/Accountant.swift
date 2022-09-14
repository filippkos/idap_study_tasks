import Foundation

class Accountant: Employee {
    
    override init(name: String) {
        super.init(name: name)
    }
    
    func count(washer: Washer) -> Bool {
        let isEnough = self.money >= self.price
        
        if isEnough {
            self.moneyReceiver?.getMoney(another: self)
        }
        
        return isEnough
    }
}
