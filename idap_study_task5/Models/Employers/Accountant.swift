import Foundation

class Accountant: Employee, EmployeeStateProtocol {
    
    // MARK: Variables
    var state: EmployeeState
    let lock = NSLock()
    override var money: Int {
        didSet {
            if self.money - oldValue == price {
                self.lock.lock()
                if self.action() {
                    print("counting done")
                    self.moneyReceiver?.getMoney(another: self)
                }
                self.lock.unlock()
            }
        }
    }
    
    // MARK: Initializations and Deallocations
    override init(name: String) {
        self.state = .readyToWork
        super.init(name: name)
    }
    
    // MARK: Public ( Public visible funcs )
    func action() -> Bool {
        sleep(1)
        let isEnough = self.money >= self.price
        return isEnough
    }
}
