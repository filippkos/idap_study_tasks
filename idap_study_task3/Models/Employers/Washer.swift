import Foundation

class Washer: Employee {
    
    var inside: Bool
    override var money: Int {
        didSet {
            if self.money - oldValue == price {
                self.moneyReceiver?.getMoney(another: self)
            }
        }
    }
    
    override init(name: String) {
        self.inside = false
        super.init(name: name)
    }
    
    func action(car: Car) -> Bool {
        car.isClean = true
        super.takeMoney(another: car)
        return true
    }
}
