import Foundation

class Washer: Employee, EmployeeStateProtocol {
    
    // MARK: Variables
    var state: EmployeeState
    override var money: Int {
        didSet {
            if self.money - oldValue == price {
                self.state = .needsProcessing
                self.moneyReceiver?.getMoney(another: self)
                self.state = .free
            }
        }
    }
    
    // MARK: Initializations and Deallocations
    override init(name: String) {
        self.state = .free
        super.init(name: name)
    }
    
    // MARK: Public ( Public visible funcs )
    func action(car: Car) -> Bool {
        sleep(car.time)
        car.isClean = true
        print("car \(car.id) washed by \(self.name)")
        super.takeMoney(another: car)
        return true
    }
}
