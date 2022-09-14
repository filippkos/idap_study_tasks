import Foundation

class Washer: Employee {
    var inside: Bool
    
    override init(name: String) {
        self.inside = false
        super.init(name: name)
    }
    
    func wash(car: Car) -> Bool {
        car.isClean = true
        super.takeMoney(another: car)
        self.moneyReceiver?.getMoney(another: self)
        return true
    }
}
