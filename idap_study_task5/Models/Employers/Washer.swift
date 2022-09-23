import Foundation

class Washer: Employee, EmployeeStateProtocol {
    
    var state: EmployeeState
    
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
        self.state = .readyToWork
        super.init(name: name)
        
    }
    
    func action(car: Car) -> Bool {
        sleep(1)
        car.isClean = true
        super.takeMoney(another: car)
        return true
    }
}
